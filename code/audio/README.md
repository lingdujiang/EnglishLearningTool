# 📢 音频文件说明

## 方案 1：使用在线 TTS（当前方案）

目前代码使用**百度 TTS**，无需下载音频文件，直接联网播放。

**优点**：
- ✅ 无需下载 50 个音频文件
- ✅ 发音标准
- ✅ 国内可用

**缺点**：
- ⚠️ 需要联网
- ⚠️ 首次播放可能稍慢

---

## 方案 2：使用本地音频文件（备用方案）

如果在线 TTS 无法使用，可以下载音频文件：

### 步骤 1：创建文件夹结构

```
audio/
├── cat.mp3
├── dog.mp3
├── bird.mp3
└── ... (共 50 个文件)
```

### 步骤 2：下载音频文件

**免费 TTS 工具**：

1. **TTSMaker** (推荐)
   - 网址：https://ttsmaker.com/
   - 选择 "English (US)" → "Google US English"
   - 输入单词 → 下载 MP3

2. **Voicemaker**
   - 网址：https://voicemaker.in/
   - 免费额度：50 词/次

3. **Azure TTS 演示**
   - 网址：https://azure.microsoft.com/zh-cn/services/cognitive-services/text-to-speech/
   - 在线试听 → 用录音工具录制

### 步骤 3：批量生成（推荐）

使用 Python 脚本批量生成（需要安装库）：

```python
# 需要安装：pip install gTTS
from gtts import gTTS
import os

words = ['cat', 'dog', 'bird', 'fish', 'rabbit', ...]  # 50 个单词

for word in words:
    tts = gTTS(word, lang='en')
    tts.save(f'audio/{word}.mp3')
    print(f'生成：{word}.mp3')
```

---

## 方案 3：使用浏览器 TTS

如果以上都不行，代码已内置浏览器 TTS 作为备用。

**注意**：某些浏览器可能需要用户先与页面交互才能播放声音。

---

## 当前配置

代码默认使用**百度 TTS**（在线），如果失败会自动降级到**浏览器 TTS**。

**无需额外配置**，打开网页即可使用！
