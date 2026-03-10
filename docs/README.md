# 单词小动物园 - 每日 5 词 MVP

一个适合一年级小学生的英语学习工具，每天学习 5 个单词，用小动物成长激励坚持。

## 📁 项目结构

```
code/
├── index.html          # 主页面
├── style.css           # 样式文件
├── script.js           # 逻辑文件
├── data/
│   └── words.js        # 50 个单词词库
├── images/             # 图片资源（需自行准备）
│   ├── egg.png         # 动物等级：蛋
│   ├── chick.png       # 动物等级：雏鸟
│   ├── bird.png        # 动物等级：小鸟
│   ├── bigbird.png     # 动物等级：大鸟
│   ├── phoenix.png     # 动物等级：凤凰
│   ├── cat.png         # 单词图片（50 个）
│   ├── dog.png
│   └── ...
├── audio/              # 音频资源（需自行准备）
│   ├── cat.mp3         # 单词发音（50 个）
│   ├── dog.mp3
│   └── ...
└── README.md           # 本文件
```

## 🚀 快速启动

### 方法 1：直接打开
双击 `index.html` 文件即可在浏览器中打开使用。

### 方法 2：本地服务器（推荐）
```bash
# 使用 Python
cd code
python -m http.server 8000

# 或使用 Node.js
npx http-server -p 8000

# 然后访问 http://localhost:8000
```

### 方法 3：部署到网络
- **GitHub Pages**: 上传到 GitHub，启用 Pages 功能
- **Vercel**: 拖拽文件夹到 Vercel 部署
- **Netlify**: 拖拽文件夹到 Netlify 部署

## 🎮 使用说明

1. **打开网页** - 自动显示今日第 1 个单词
2. **听发音** - 点击 🔊 按钮听标准发音
3. **跟读** - 点击 🎤 按钮录音对比（可选）
4. **下一个** - 点击按钮学习下一个单词
5. **完成奖励** - 学完 5 词后小动物长大

## 🎯 核心功能

- ✅ 每日 5 词，自动按天更新
- ✅ 单词发音（本地音频 + 浏览器 TTS 备用）
- ✅ 跟读录音功能
- ✅ 小动物成长系统（5 个等级）
- ✅ 学习进度本地存储
- ✅ 键盘快捷键（空格=发音，回车=下一个）

## 🛠️ 自定义

### 修改词库
编辑 `data/words.js` 文件，按照格式添加或修改单词。

### 修改动物等级规则
编辑 `script.js` 中的 `getAnimalLevel()` 函数。

### 修改样式
编辑 `style.css` 文件，调整颜色、字体、布局等。

## 📝 需要准备的材料

### 图片资源（55 张）
- **动物等级图**（5 张）：egg.png, chick.png, bird.png, bigbird.png, phoenix.png
- **单词图片**（50 张）：对应每个单词的插图

**免费图片资源推荐**：
- [Unsplash](https://unsplash.com/) - 高质量免费图片
- [Pixabay](https://pixabay.com/) - 免费可商用图片
- [Flaticon](https://www.flaticon.com/) - 图标和插图

### 音频资源（50 个）
- **单词发音**（50 个）：每个单词的 MP3 发音文件

**免费 TTS 工具推荐**：
- [Google Text-to-Speech](https://cloud.google.com/text-to-speech)
- [Azure TTS](https://azure.microsoft.com/zh-cn/services/cognitive-services/text-to-speech/)
- [百度语音合成](https://ai.baidu.com/tech/speech/tts)

**临时方案**：代码已内置浏览器 TTS，即使没有音频文件也能发音！

## 🔧 调试技巧

在浏览器控制台输入以下命令：

```javascript
// 重置学习进度
resetProgress()

// 查看当前进度
console.log(localStorage)

// 手动设置连续学习天数
localStorage.setItem('totalDays', '10')
location.reload()
```

## 📱 浏览器兼容性

- ✅ Chrome / Edge（推荐）
- ✅ Firefox
- ✅ Safari
- ⚠️ IE 不支持（需要现代浏览器）

## 🎨 后续扩展建议

1. **复习系统** - 艾宾浩斯遗忘曲线复习
2. **游戏化** - 单词配对、拼写挑战等小游戏
3. **家长端** - 学习报告、进度统计
4. **分享功能** - 分享成就到社交媒体
5. **更多主题** - 更多动物、更多单词分类

## 📄 许可证

本项目仅供学习使用。

---

**开发时间**：2026-03-10  
**版本**：v1.0 MVP  
**目标用户**：小学一年级学生
