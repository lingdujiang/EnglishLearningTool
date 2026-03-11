# 🦁 单词小动物园

> 小学一年级英语学习工具 - 每日 5 词，快乐成长！

**在线版本**: [GitHub Pages](https://lingdujiang.github.io/EnglishLearningTool/) ⭐ NEW

---

## 🚀 快速开始

### 1. 打开程序
双击 **`code/index.html`** 即可开始使用！

或访问在线版本：[GitHub Pages](https://lingdujiang.github.io/EnglishLearningTool/)

### 2. 功能特性
- ✅ **每日 5 词** - 每天学习 5 个新单词
- ✅ **动物成长** - 从蛋到凤凰的成长激励 🐣→🐤→🐦→🦅→🔥
- ✅ **发音跟读** - 标准发音 + 录音对比
- ✅ **进度保存** - 自动保存学习进度
- ✅ **离线使用** - 无需网络，打开即用
- ⭐ **布局切换** - 三种布局样式自由选择（紧凑/分栏/悬浮）
- ⭐ **重置进度** - 一键重置学习数据（带确认保护）

---

## 📁 目录结构

```
EnglishLearningProject/
├── code/           # 📱 正式程序（打开这个）
│   ├── index.html          # 主页面
│   ├── style.css           # 样式（含三种布局）
│   ├── script.js           # 逻辑（含布局切换）
│   ├── data/words.js       # 50 词词库
│   ├── images/             # 图片素材
│   ├── audio/              # 音频素材
│   └── test-levels.html    # 等级测试页面 ⭐
├── tools/          # 🛠️ 工具脚本（维护用）
│   ├── make-transparent.py   # 图片透明处理
│   └── rename-images.py      # 图片重命名
├── docs/           # 📖 文档说明
│   ├── 设计文档.md           # 完整设计说明 ⭐
│   ├── 维护文档.md           # 日常维护指南
│   ├── 需求文档.md           # 产品需求说明
│   └── README.md             # 项目说明
├── backup/         # 💾 备份文件夹
└── README.md       # 📋 本文件
```

详细说明请查看：**`docs/目录结构说明.md`** 和 **`docs/设计文档.md`** ⭐ NEW

---

## 🛠️ 常用工具

### 下载图片
```bash
powershell -ExecutionPolicy Bypass -File "tools/quick-download-images.ps1"
```

### 生成音频
```bash
powershell -ExecutionPolicy Bypass -File "tools/generate-audio.ps1"
```

### 检查文件
```bash
powershell -ExecutionPolicy Bypass -File "tools/check-images.ps1"
```

---

## 📖 文档导航

| 文档 | 用途 |
|------|------|
| **docs/设计文档.md** ⭐ | 完整的设计说明和技术架构 |
| **docs/维护文档.md** | 日常维护和故障排查 |
| **docs/需求文档.md** | 产品功能和设计说明 |
| **docs/图片素材说明.md** | 图片素材获取指南 |
| **docs/目录结构说明.md** | 目录结构详细说明 |

---

## 🎯 适合人群

- 👶 小学一年级学生
- 👨‍👩‍👧 家长辅导孩子英语
- 👩‍🏫 英语教师课堂辅助

---

## 💡 使用提示

1. **每天学习** - 打开页面自动显示今日 5 词
2. **点击发音** - 🔊 按钮听标准发音
3. **跟读练习** - 🎤 按钮录音对比
4. **完成奖励** - 学完后小动物会长大
5. **坚持学习** - 连续学习解锁更多等级
6. **⭐ 切换布局** - 点击右上角 ⚙️ 选择喜欢的布局样式
7. **⭐ 重置进度** - 点击底部 🗑️ 按钮可重置学习数据

---

## 🔧 遇到问题？

### 图片不显示
```bash
powershell -ExecutionPolicy Bypass -File "tools/quick-download-images.ps1"
```

### 声音不播放
```bash
powershell -ExecutionPolicy Bypass -File "tools/generate-audio.ps1"
```

### ⭐ 布局显示异常
```javascript
// 在控制台重置为默认布局
localStorage.setItem('layout', 'layout-a')
location.reload()
```

### ⭐ 重置学习进度
- 方法 1：点击底部 🗑️ 重置进度按钮
- 方法 2：在控制台输入 `resetProgress()`

### 其他问题
查看 **`docs/维护文档.md`** 获取详细故障排查指南。

---

## 📊 学习统计

在浏览器控制台（F12）输入：
```javascript
// 查看学习数据
console.log(localStorage)

// 查看连续学习天数
localStorage.getItem('totalDays')

// 查看总学习单词数
localStorage.getItem('totalWords')

// 查看当前布局设置 ⭐
localStorage.getItem('layout')

// 重置进度
localStorage.clear()
location.reload()

// 或使用重置按钮（推荐）
resetProgress()
```

---

## 🎉 开始学习吧！

**双击 `code/index.html` 打开程序** 👉

或访问在线版本：[GitHub Pages](https://lingdujiang.github.io/EnglishLearningTool/) 🌐

---

## 📦 部署说明 ⭐ NEW

### GitHub Pages 部署
1. 打开仓库 Settings → Pages
2. Source 选择 `Deploy from a branch`
3. Branch 选择 `main`，文件夹选择 `/code`
4. 保存后访问：`https://用户名.github.io/仓库名/`

### 自动部署
项目配置了 GitHub Actions，推送到 main 分支后自动部署。

---

**版本**: v1.3  
**最后更新**: 2026-03-11  
**适用年级**: 小学一年级  
**GitHub**: [lingdujiang/EnglishLearningTool](https://github.com/lingdujiang/EnglishLearningTool)
