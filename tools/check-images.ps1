# 整理图片素材到正确位置
# 确保所有图片都在 images/ 文件夹中

Write-Host "📁 整理图片素材..." -ForegroundColor Cyan
Write-Host ""

$imagesDir = Join-Path $PSScriptRoot "images"
$downloadsDir = "$env:USERPROFILE\Downloads"

# 创建 images 文件夹
if (-not (Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir | Out-Null
    Write-Host "✅ 创建文件夹：$imagesDir" -ForegroundColor Green
} else {
    Write-Host "✅ 文件夹已存在：$imagesDir" -ForegroundColor Green
}

# 需要的图片列表
$animalImages = @("egg.png", "chick.png", "bird.png", "bigbird.png", "phoenix.png")

$allWords = @(
    "cat", "dog", "bird", "fish", "rabbit", "duck", "pig", "cow", "horse", "sheep",
    "red", "blue", "green", "yellow", "orange", "purple", "pink", "black", "white", "brown",
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
    "mom", "dad", "grandma", "grandpa", "sister", "brother", "baby", "family", "uncle", "aunt",
    "ball", "book", "pencil", "bag", "cup", "chair", "table", "bed", "door", "window"
)

Write-Host "`n📋 检查动物等级图..." -ForegroundColor Cyan
foreach ($img in $animalImages) {
    $dest = Join-Path $imagesDir $img
    if (Test-Path $dest) {
        Write-Host "  ✅ $img" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  缺少：$img" -ForegroundColor Yellow
        Write-Host "     提示：打开 create-images.html 下载" -ForegroundColor Gray
    }
}

Write-Host "`n📋 检查单词图片..." -ForegroundColor Cyan
$missingCount = 0
foreach ($word in $allWords) {
    $dest = Join-Path $imagesDir "$word.png"
    if (Test-Path $dest) {
        # 检查文件大小
        $size = (Get-Item $dest).Length
        if ($size -gt 1000) {
            Write-Host "  ✅ $word.png ($([math]::Round($size/1024, 1))KB)" -ForegroundColor Green
        } else {
            Write-Host "  ⚠️  $word.png (文件过小)" -ForegroundColor Yellow
            $missingCount++
        }
    } else {
        Write-Host "  ❌ 缺少：$word.png" -ForegroundColor Red
        $missingCount++
    }
}

Write-Host ""
Write-Host "=" -ForegroundColor Cyan -NoNewline
Write-Host "========================" -NoNewline
Write-Host "=" -ForegroundColor Cyan

$presentCount = (Get-ChildItem $imagesDir -Filter "*.png").Count
Write-Host "📊 当前图片数量：$presentCount 张" -ForegroundColor White
Write-Host "⚠️  缺失图片：$missingCount 张" -ForegroundColor $(if ($missingCount -eq 0) { "Green" } else { "Yellow" })
Write-Host ""

if ($missingCount -eq 0) {
    Write-Host "🎉 所有图片已就绪！" -ForegroundColor Green
    Write-Host ""
    Write-Host "下一步:" -ForegroundColor Cyan
    Write-Host "1. 打开 index.html" -ForegroundColor White
    Write-Host "2. 测试图片和发音" -ForegroundColor White
    Write-Host "3. 开始使用！" -ForegroundColor White
} else {
    Write-Host "💡 如何获取缺失的图片:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "方法 1: 使用图片生成工具（推荐）" -ForegroundColor White
    Write-Host "  1. 打开 create-images.html" -ForegroundColor Gray
    Write-Host "  2. 点击「📥 一键下载所有图片」" -ForegroundColor Gray
    Write-Host "  3. 将下载的图片放入 images/ 文件夹" -ForegroundColor Gray
    Write-Host ""
    Write-Host "方法 2: 手动下载" -ForegroundColor White
    Write-Host "  1. 访问 https://placehold.co/" -ForegroundColor Gray
    Write-Host "  2. 生成 400x400 的彩色图片" -ForegroundColor Gray
    Write-Host "  3. 保存为对应的文件名（如 cat.png）" -ForegroundColor Gray
    Write-Host ""
    Write-Host "方法 3: 使用占位图（临时方案）" -ForegroundColor White
    Write-Host "  运行以下命令下载简化版图片:" -ForegroundColor Gray
    Write-Host "  powershell -File download-images.ps1" -ForegroundColor Gray
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
