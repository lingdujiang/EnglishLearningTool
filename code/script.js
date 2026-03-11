// ==================== 全局变量 ====================
let currentWordIndex = 0;        // 当前单词索引
let todayIndex = 0;              // 今日学习进度
let isRecording = false;         // 是否正在录音
let mediaRecorder = null;        // 录音器
let audioChunks = [];            // 录音数据块

// ==================== 初始化 ====================
document.addEventListener('DOMContentLoaded', function() {
  // 预加载语音列表（Chrome 需要）
  if ('speechSynthesis' in window) {
    speechSynthesis.getVoices();
    // 有些浏览器需要延迟加载
    setTimeout(() => speechSynthesis.getVoices(), 100);
  }
  
  // 加载保存的布局
  loadLayout();
  
  initApp();
  setupEventListeners();
  
  console.log('🎉 单词小动物园已启动！');
  console.log('📢 按 F12 打开控制台查看调试信息');
  console.log('🔊 测试发音：在控制台输入 testSpeech()');
});

// ==================== 测试发音（调试用）====================
window.testSpeech = function() {
  console.log('🔊 测试发音功能...');
  speakWord('Hello');
  setTimeout(() => speakWord('World'), 1000);
};

// ==================== 初始化应用 ====================
function initApp() {
  // 检查今天的学习状态
  checkTodayStatus();
  
  // 更新动物等级显示
  updateAnimalDisplay();
}

// ==================== 检查今日状态 ====================
function checkTodayStatus() {
  const lastDate = localStorage.getItem('lastLearnDate');
  const today = new Date().toDateString();
  
  if (lastDate !== today) {
    // 新的一天，重置进度
    localStorage.setItem('lastLearnDate', today);
    localStorage.setItem('todayIndex', '0');
    todayIndex = 0;
    
    // 增加连续学习天数（如果不是第一次）
    if (lastDate) {
      const totalDays = parseInt(localStorage.getItem('totalDays')) || 0;
      localStorage.setItem('totalDays', totalDays + 1);
    }
  } else {
    // 继续今天的进度
    todayIndex = parseInt(localStorage.getItem('todayIndex')) || 0;
  }
  
  // 检查是否已完成今日学习
  if (todayIndex >= 5) {
    showPage('completed-page');
  } else {
    currentWordIndex = todayIndex;
    showWord(currentWordIndex);
    showPage('learning-page');
  }
  
  updateProgress();
  updatePrevButton();
}

// ==================== 更新上一个按钮状态 ====================
function updatePrevButton() {
  const btnPrev = document.getElementById('btn-prev');
  if (btnPrev) {
    if (todayIndex === 0) {
      btnPrev.disabled = true;
      btnPrev.style.opacity = '0.5';
      btnPrev.style.cursor = 'not-allowed';
    } else {
      btnPrev.disabled = false;
      btnPrev.style.opacity = '1';
      btnPrev.style.cursor = 'pointer';
    }
  }
}

// ==================== 显示单词 ====================
function showWord(index) {
  if (index >= wordBank.length) {
    index = 0; // 循环回到开头
  }
  
  const word = wordBank[index];
  
  document.getElementById('word-text').textContent = word.word;
  document.getElementById('word-meaning').textContent = word.meaning;
  document.getElementById('word-sentence').textContent = word.sentence;
  document.getElementById('word-image').src = word.image || 'images/placeholder.png';
  
  // 保存当前音频路径
  document.getElementById('audio-player').dataset.audio = word.audio || '';
}

// ==================== 播放发音 ====================
function playAudio() {
  const currentWord = document.getElementById('word-text').textContent;
  console.log('播放发音:', currentWord);
  
  // 方案 1: 优先使用本地音频文件 (最可靠)
  playLocalAudio(currentWord);
}

// ==================== 本地音频文件 ====================
function playLocalAudio(word) {
  console.log('📂 尝试播放本地音频:', word);
  
  const audioUrl = `audio/${word}.mp3`;
  const audio = new Audio(audioUrl);
  audio.volume = 1.0;
  
  let hasPlayed = false;
  
  audio.addEventListener('play', () => {
    hasPlayed = true;
    console.log('▶ 本地音频开始播放');
  });
  
  audio.addEventListener('ended', () => {
    console.log('✅ 本地音频播放完成');
  });
  
  audio.addEventListener('error', (e) => {
    console.log('⚠ 本地音频不存在，降级到百度 TTS');
    if (!hasPlayed) {
      playBaiduTTS(word);
    }
  });
  
  audio.play().catch(err => {
    console.log('⚠ 本地音频播放失败，降级到百度 TTS');
    playBaiduTTS(word);
  });
}

// ==================== 在线 TTS (百度 - 国内可用) ====================
function playBaiduTTS(word) {
  console.log('🌐 使用百度 TTS:', word);
  
  // 百度 TTS (免费，国内可用)
  const audioUrl = `https://fanyi.baidu.com/gettts?text=${encodeURIComponent(word)}&lang=en&spd=5&source=web`;
  
  const audio = new Audio(audioUrl);
  audio.volume = 1.0;
  audio.crossOrigin = 'anonymous';
  
  let hasPlayed = false;
  
  audio.addEventListener('play', () => {
    console.log('▶ 百度 TTS 开始播放');
    hasPlayed = true;
  });
  
  audio.addEventListener('ended', () => {
    console.log('✅ 百度 TTS 播放完成');
  });
  
  audio.addEventListener('error', (e) => {
    console.error('❌ 百度 TTS 失败:', e);
    if (!hasPlayed) {
      console.log('降级到浏览器 TTS');
      setTimeout(() => speakWordWithFix(word), 100);
    }
  });
  
  // 设置超时，如果 3 秒内没开始播放则切换备用方案
  const timeout = setTimeout(() => {
    if (!hasPlayed) {
      console.log(' 百度 TTS 超时，降级到浏览器 TTS');
      speakWordWithFix(word);
    }
  }, 3000);
  
  audio.play().catch(err => {
    console.error('❌ 播放失败:', err);
    clearTimeout(timeout);
    console.log('降级到浏览器 TTS');
    setTimeout(() => speakWordWithFix(word), 100);
  });
  
  audio.addEventListener('ended', () => {
    clearTimeout(timeout);
  });
}

// ==================== 浏览器 TTS (修复版) ====================
function speakWordWithFix(word) {
  console.log('🔊 浏览器 TTS 准备发音:', word);
  
  if (!('speechSynthesis' in window)) {
    console.error('❌ 浏览器不支持 TTS');
    alert('您的浏览器不支持语音播放，请使用 Chrome 或 Edge 浏览器');
    return;
  }
  
  const synth = window.speechSynthesis;
  const voices = synth.getVoices();
  
  if (voices.length === 0) {
    console.error('❌ 语音列表为空');
    return;
  }
  
  const utterance = new SpeechSynthesisUtterance(word);
  utterance.lang = 'en-US';
  utterance.rate = 0.7;
  utterance.volume = 1.0;
  
  // 选择英语语音
  for (let voice of voices) {
    if (voice.lang === 'en-US' || voice.lang === 'en-GB') {
      utterance.voice = voice;
      console.log('🎤 使用语音:', voice.name);
      break;
    }
  }
  
  // 使用 addEventListener 而不是直接赋值
  utterance.addEventListener('start', () => {
    console.log('▶ 开始发音:', word);
  });
  
  utterance.addEventListener('end', () => {
    console.log('✅ 发音完成:', word);
  });
  
  utterance.addEventListener('error', (event) => {
    console.error('❌ TTS 错误:', event.error);
  });
  
  // 关键：确保在下一帧执行，避免时序问题
  setTimeout(() => {
    console.log('📢 发送发音请求...');
    synth.speak(utterance);
  }, 10);
}

// 保留原函数名兼容
function speakWord(word) {
  speakWordWithFix(word);
}

// ==================== 上一个单词 ====================
function prevWord() {
  if (todayIndex > 0) {
    todayIndex--;
    currentWordIndex = todayIndex;
    
    // 保存进度
    localStorage.setItem('todayIndex', todayIndex);
    
    updateProgress();
    showWord(currentWordIndex);
    updateAnimalDisplay();
    updatePrevButton();
  }
}

// ==================== 下一个单词 ====================
function nextWord() {
  todayIndex++;
  currentWordIndex = todayIndex;
  
  // 保存进度
  localStorage.setItem('todayIndex', todayIndex);
  
  // 计算总学习单词数
  const totalWords = parseInt(localStorage.getItem('totalWords')) || 0;
  localStorage.setItem('totalWords', totalWords + 1);
  
  updateProgress();
  
  if (todayIndex >= 5) {
    // 今日学习完成
    showCompletePage();
  } else {
    showWord(currentWordIndex);
    updatePrevButton();
  }
  
  updateAnimalDisplay();
}

// ==================== 更新进度显示 ====================
function updateProgress() {
  const dots = document.querySelectorAll('.dot');
  const progressText = document.getElementById('progress-text');
  
  dots.forEach((dot, index) => {
    if (index < todayIndex) {
      dot.className = 'dot completed';
    } else if (index === todayIndex) {
      dot.className = 'dot active';
    } else {
      dot.className = 'dot';
    }
  });
  
  progressText.textContent = `${Math.min(todayIndex + 1, 5)}/5`;
}

// ==================== 显示完成页面 ====================
function showCompletePage() {
  // 更新动物等级
  const totalDays = parseInt(localStorage.getItem('totalDays')) || 1;
  const oldLevel = getAnimalLevel(totalDays - 1);
  const newLevel = getAnimalLevel(totalDays);
  
  // 显示升级动画
  const levelUpArrow = document.querySelector('.level-up-arrow');
  if (levelUpArrow && newLevel > oldLevel) {
    const animalNames = ['蛋', '雏鸟', '小鸟', '大鸟', '凤凰'];
    levelUpArrow.textContent = `${animalNames[oldLevel]} → ${animalNames[newLevel]}`;
  }
  
  showPage('complete-page');
}

// ==================== 获取动物等级 ====================
function getAnimalLevel(days) {
  if (days >= 10) return 4;
  if (days >= 6) return 3;
  if (days >= 3) return 2;
  if (days >= 1) return 1;
  return 0;
}

// ==================== 更新动物显示 ====================
function updateAnimalDisplay() {
  const totalDays = parseInt(localStorage.getItem('totalDays')) || 0;
  const totalWords = parseInt(localStorage.getItem('totalWords')) || 0;
  const level = getAnimalLevel(totalDays);
  
  const animalImages = ['images/egg_0.png', 'images/egg_1.png', 'images/egg_2.png', 'images/egg_3.png', 'images/egg_4.png'];
  const animalNames = ['蛋', '雏鸟', '小鸟', '大鸟', '凤凰'];
  
  document.getElementById('animal-image').src = animalImages[level];
  document.getElementById('animal-level').textContent = `等级：${animalNames[level]}`;
  document.getElementById('days-count').textContent = `连续学习：${totalDays}天`;
}

// ==================== 页面切换 ====================
function showPage(pageId) {
  // 隐藏所有页面
  document.querySelectorAll('.page').forEach(page => {
    page.classList.add('hidden');
  });
  
  // 显示目标页面
  document.getElementById(pageId).classList.remove('hidden');
}

// ==================== 设置事件监听 ====================
function setupEventListeners() {
  // 听发音按钮
  document.getElementById('btn-play').addEventListener('click', playAudio);
  
  // 跟读按钮
  document.getElementById('btn-record').addEventListener('click', toggleRecording);
  
  // 上一个按钮
  document.getElementById('btn-prev').addEventListener('click', prevWord);
  
  // 下一个按钮
  document.getElementById('btn-next').addEventListener('click', nextWord);
  
  // 明天继续按钮
  document.getElementById('btn-tomorrow').addEventListener('click', function() {
    showPage('completed-page');
  });
  
  // 再来一次按钮 - 重置今日进度，重新学习
  document.getElementById('btn-retry').addEventListener('click', function() {
    if (confirm('确定要重新学习今天的单词吗？进度将重置。')) {
      localStorage.setItem('todayIndex', '0');
      todayIndex = 0;
      currentWordIndex = 0;
      
      // 不减少总学习天数和总单词数，只重置今日进度
      showWord(0);
      showPage('learning-page');
      updateProgress();
      updatePrevButton();
      updateAnimalDisplay();
    }
  });
  
  // 复习旧词按钮
  document.getElementById('btn-review').addEventListener('click', function() {
    alert('复习功能开发中... 敬请期待！');
  });
  
  // 重置进度按钮
  document.getElementById('btn-reset').addEventListener('click', function() {
    if (confirm('⚠️ 确定要重置学习进度吗？\n\n这将清除：\n- 连续学习天数\n- 今日学习进度\n- 总学习单词数\n\n此操作不可恢复！')) {
      resetProgress();
    }
  });
  
  // 设置按钮 - 打开设置面板
  document.getElementById('btn-settings').addEventListener('click', function() {
    document.getElementById('settings-panel').classList.remove('hidden');
  });
  
  // 关闭设置面板
  document.getElementById('btn-close-settings').addEventListener('click', function() {
    document.getElementById('settings-panel').classList.add('hidden');
  });
  
  // 点击面板外部关闭
  document.getElementById('settings-panel').addEventListener('click', function(e) {
    if (e.target === this) {
      this.classList.add('hidden');
    }
  });
  
  // 布局选项切换
  document.querySelectorAll('input[name="layout"]').forEach(radio => {
    radio.addEventListener('change', function() {
      setLayout(this.value);
    });
  });
}

// ==================== 录音功能 ====================
async function toggleRecording() {
  if (isRecording) {
    // 停止录音
    stopRecording();
  } else {
    // 开始录音
    startRecording();
  }
}

async function startRecording() {
  try {
    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    mediaRecorder = new MediaRecorder(stream);
    audioChunks = [];
    
    mediaRecorder.ondataavailable = event => {
      audioChunks.push(event.data);
    };
    
    mediaRecorder.onstop = () => {
      // 录音完成，可以播放对比
      const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
      const audioUrl = URL.createObjectURL(audioBlob);
      const audio = new Audio(audioUrl);
      
      // 先播放原音，再播放录音
      playAudio();
      setTimeout(() => {
        audio.play();
      }, 1000);
      
      // 停止所有音轨
      stream.getTracks().forEach(track => track.stop());
    };
    
    mediaRecorder.start();
    isRecording = true;
    
    // 更新按钮状态
    const btnRecord = document.getElementById('btn-record');
    btnRecord.textContent = '⏹ 停止';
    btnRecord.classList.add('btn-recording');
    
  } catch (err) {
    console.error('录音失败:', err);
    alert('无法访问麦克风，请检查浏览器权限设置');
  }
}

function stopRecording() {
  if (mediaRecorder && mediaRecorder.state !== 'inactive') {
    mediaRecorder.stop();
  }
  
  isRecording = false;
  
  // 恢复按钮状态
  const btnRecord = document.getElementById('btn-record');
  btnRecord.textContent = '🎤 跟读';
  btnRecord.classList.remove('btn-recording');
}

// ==================== 键盘快捷键 ====================
document.addEventListener('keydown', function(e) {
  if (e.code === 'Space') {
    e.preventDefault();
    playAudio();
  } else if (e.code === 'Enter' || e.code === 'NumpadEnter') {
    e.preventDefault();
    nextWord();
  }
});

// ==================== 调试工具（开发用）====================
// 在控制台输入 resetProgress() 可以重置进度
window.resetProgress = function() {
  localStorage.clear();
  alert('✅ 学习进度已重置！\n\n小动物回到了蛋的状态，重新开始学习吧！🥚');
  location.reload();
};

// ==================== 布局设置 ====================
// 加载保存的布局
function loadLayout() {
  const savedLayout = localStorage.getItem('layout') || 'layout-a';
  setLayout(savedLayout, true);
}

// 设置布局
function setLayout(layoutName, isInit = false) {
  // 移除所有布局类
  document.body.classList.remove('layout-a', 'layout-b', 'layout-c');
  
  // 添加选中的布局类
  document.body.classList.add(layoutName);
  
  // 更新单选按钮状态
  const radio = document.querySelector(`input[name="layout"][value="${layoutName}"]`);
  if (radio) {
    radio.checked = true;
  }
  
  // 保存布局设置
  localStorage.setItem('layout', layoutName);
  
  if (!isInit) {
    console.log('布局已切换:', layoutName);
  }
}

console.log('单词小动物园已启动！输入 resetProgress() 可重置学习进度');
