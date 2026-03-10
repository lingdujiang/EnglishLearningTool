# 🚀 Vercel 部署指南

## 快速部署（推荐）

### 方法 1: 一键导入（最简单）⭐

1. **点击下方链接直接导入**：
   ```
   https://vercel.com/new/clone?repository-url=https://github.com/lingdujiang/EnglishLearningTool&project-name=english-learning-zoo&repository-name=EnglishLearningTool&root-directory=code
   ```

2. **登录 GitHub**（如果没有 Vercel 账号）

3. **点击 Import**

4. **等待部署**（约 1 分钟）

5. **完成！** 获得访问地址

---

### 方法 2: 手动部署

#### 步骤 1: 访问 Vercel
打开：**https://vercel.com**

#### 步骤 2: 登录
- 点击 "Sign Up" 或 "Login"
- 选择 "Continue with GitHub"
- 授权 Vercel 访问 GitHub

#### 步骤 3: 导入项目
1. 点击 **"Add New Project"**
2. 选择 **"Import Git Repository"**
3. 找到 `EnglishLearningTool` 仓库
4. 点击 **"Import"**

#### 步骤 4: 配置项目
```
Framework Preset: Other
Root Directory: code
Build Command: (留空)
Output Directory: (留空)
Install Command: (留空)
```

#### 步骤 5: 部署
- 点击 **"Deploy"**
- 等待 1-2 分钟
- 看到 "Congratulations" 即成功

---

## 🎉 部署成功后

### 访问地址
```
https://english-learning-zoo.vercel.app
```

或自定义域名（如果配置了）

### 分享链接
```
🦁 单词小动物园 - Vercel 版
每天学习 5 个单词，小动物陪你一起成长！
🔗 立即体验：https://english-learning-zoo.vercel.app
```

---

## ⚙️ 自动部署

Vercel 已配置自动部署：
- ✅ 每次 push 到 main 分支自动更新
- ✅ 自动 HTTPS
- ✅ 全球 CDN 加速

### 查看部署状态
访问：**https://vercel.com/dashboard**

---

## 🌐 多平台部署

现在你的项目部署在两个平台：

| 平台 | 访问地址 | 特点 |
|------|----------|------|
| **GitHub Pages** | https://lingdujiang.github.io/EnglishLearningTool/ | 稳定、官方 |
| **Vercel** | https://english-learning-zoo.vercel.app | 快速、自动 |

### 推荐用法
- **国内用户**: 优先使用 Vercel
- **国外用户**: 两个都可以
- **备用方案**: 一个挂了用另一个

---

## 🎨 自定义域名（可选）

### 在 Vercel 上配置

1. **购买域名**
   - 阿里云、腾讯云、Namecheap 等

2. **Vercel 设置**
   - 进入项目 → Settings → Domains
   - 添加你的域名
   - 按照提示配置 DNS

3. **DNS 配置**
   ```
   类型：CNAME
   主机：www
   值：cname.vercel-dns.com
   ```

4. **等待生效**（约 10 分钟）

---

## 📊 访问统计

### Vercel Analytics
1. 进入项目 → Analytics
2. 启用分析功能
3. 查看访问量、来源等

### 完全免费额度
- ✅ 无限带宽
- ✅ 无限请求
- ✅ 100GB 流量/月
- ✅ 自动 HTTPS

---

## 🔧 常见问题

### Q: 部署失败？
A: 
1. 检查 vercel.json 配置
2. 确认 code/ 目录存在
3. 查看部署日志

### Q: 访问 404？
A:
1. 等待 1-2 分钟部署完成
2. 检查 Root Directory 是否为 `code`
3. 刷新页面

### Q: 如何更新？
A:
```bash
git push origin main
```
Vercel 会自动重新部署（约 1 分钟）

---

## 💡 优化建议

### 1. 添加 PWA 支持
让用户可以安装到手机桌面

### 2. 配置自定义域名
更专业、易记

### 3. 添加访问统计
了解使用情况

### 4. 启用 Vercel Analytics
查看性能数据

---

## 🔗 相关链接

- **Vercel 官网**: https://vercel.com
- **项目仓库**: https://github.com/lingdujiang/EnglishLearningTool
- **部署文档**: https://vercel.com/docs

---

**祝部署成功！** 🎉
