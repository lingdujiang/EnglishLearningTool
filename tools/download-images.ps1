# 批量下载项目所需图片
# 使用免费图床 API (无需 API key)

Write-Host "🎨 开始下载图片素材..." -ForegroundColor Cyan
Write-Host ""

# 创建 images 和 audio 文件夹
$imagesDir = Join-Path $PSScriptRoot "images"
if (-not (Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir | Out-Null
    Write-Host "✅ 创建文件夹：$imagesDir" -ForegroundColor Green
}

# ========== 动物等级图 (使用 emoji 转图片服务) ==========
Write-Host "`n🐣 下载动物等级图..." -ForegroundColor Cyan

$animalEmojis = @{
    "egg" = "🥚"
    "chick" = "🐣"
    "bird" = "🐤"
    "bigbird" = "🐔"
    "phoenix" = "🦜"
}

foreach ($item in $animalEmojis.GetEnumerator()) {
    $name = $item.Key
    $emoji = $item.Value
    $filename = Join-Path $imagesDir "$name.png"
    
    Write-Host "  [$name] $emoji " -NoNewline
    
    # 使用 emoji 转图片服务
    try {
        # 创建一个简单的彩色圆形背景 + emoji
        $url = "https://api.iconify.design/noto:$($name.Replace('bigbird','chicken')).svg"
        
        # 如果 iconify 没有，使用占位图服务
        $color = switch ($name) {
            "egg" { "FFE4B5" }
            "chick" { "FFD700" }
            "bird" { "87CEEB" }
            "bigbird" { "BA55D3" }
            "phoenix" { "FF4500" }
        }
        
        $placeholderUrl = "https://placehold.co/200x200/$color/FFFFFF.png?text=$emoji"
        
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add("User-Agent", "PowerShell Script")
        $webClient.DownloadFile($placeholderUrl, $filename)
        
        if (Test-Path $filename) {
            Write-Host "✅" -ForegroundColor Green
        } else {
            Write-Host "❌" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "❌ $($_.Exception.Message)" -ForegroundColor Red
    }
}

# ========== 单词图片 ==========
Write-Host "`n📖 下载单词图片..." -ForegroundColor Cyan

$words = @(
    # 动物类
    "cat", "dog", "bird", "fish", "rabbit",
    "duck", "pig", "cow", "horse", "sheep",
    # 颜色类
    "red", "blue", "green", "yellow", "orange",
    "purple", "pink", "black", "white", "brown",
    # 数字类
    "one", "two", "three", "four", "five",
    "six", "seven", "eight", "nine", "ten",
    # 家庭成员
    "mom", "dad", "grandma", "grandpa", "sister",
    "brother", "baby", "family", "uncle", "aunt",
    # 日常物品
    "ball", "book", "pencil", "bag", "cup",
    "chair", "table", "bed", "door", "window"
)

# 颜色映射（按分类）
$colorMap = @{
    "cat" = "FFB6C1"; "dog" = "8B4513"; "bird" = "87CEEB"; "fish" = "FFA500"; "rabbit" = "FFC0CB"
    "duck" = "FFD700"; "pig" = "FFC0CB"; "cow" = "000000"; "horse" = "8B4513"; "sheep" = "F5F5F5"
    "red" = "FF0000"; "blue" = "0000FF"; "green" = "008000"; "yellow" = "FFFF00"; "orange" = "FFA500"
    "purple" = "800080"; "pink" = "FFC0CB"; "black" = "000000"; "white" = "FFFFFF"; "brown" = "A52A2A"
    "one" = "FF6B6B"; "two" = "4ECDC4"; "three" = "45B7D1"; "four" = "96CEB4"; "five" = "FFEAA7"
    "six" = "DDA0DD"; "seven" = "98FB98"; "eight" = "F0E68C"; "nine" = "E6E6FA"; "ten" = "FFDAB9"
    "mom" = "FFB6C1"; "dad" = "4682B4"; "grandma" = "DDA0DD"; "grandpa" = "708090"; "sister" = "FF69B4"
    "brother" = "1E90FF"; "baby" = "FFDAB9"; "family" = "9370DB"; "uncle" = "2F4F4F"; "aunt" = "DB7093"
    "ball" = "FF4500"; "book" = "8B4513"; "pencil" = "FFD700"; "bag" = "4169E1"; "cup" = "F5F5DC"
    "chair" = "8B4513"; "table" = "A0522D"; "bed" = "4682B4"; "door" = "8B4513"; "window" = "87CEEB"
}

$successCount = 0
$failCount = 0

foreach ($word in $words) {
    $index = $words.IndexOf($word) + 1
    $filename = Join-Path $imagesDir "$word.png"
    
    Write-Host "  [$index/$($words.Count)] $word " -NoNewline
    
    try {
        $color = $colorMap[$word]
        if (-not $color) { $color = "667eea" }
        
        # 使用 placehold.co 生成带文字的图片
        $text = $word.Substring(0, 1).ToUpper()
        $url = "https://placehold.co/400x400/$color/FFFFFF.png?text=$text"
        
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add("User-Agent", "PowerShell Script")
        $webClient.DownloadFile($url, $filename)
        
        if (Test-Path $filename) {
            $size = (Get-Item $filename).Length
            if ($size -gt 1000) {
                Write-Host "✅ ($([math]::Round($size/1024, 1))KB)" -ForegroundColor Green
                $successCount++
            } else {
                Write-Host "⚠️ 文件过小" -ForegroundColor Yellow
                $failCount++
            }
        } else {
            Write-Host "❌" -ForegroundColor Red
            $failCount++
        }
    }
    catch {
        Write-Host "❌" -ForegroundColor Red
        $failCount++
    }
}

Write-Host ""
Write-Host "=" -ForegroundColor Cyan -NoNewline
Write-Host "========================" -NoNewline
Write-Host "=" -ForegroundColor Cyan
Write-Host "✅ 成功：$successCount/$($words.Count)" -ForegroundColor Green
Write-Host "❌ 失败：$failCount/$($words.Count)" -ForegroundColor Red
Write-Host ""

if ($successCount -ge ($words.Count - 5)) {
    Write-Host "🎉 图片下载基本完成！" -ForegroundColor Green
    Write-Host "📂 文件位置：$imagesDir" -ForegroundColor Cyan
} else {
    Write-Host "⚠ 部分图片下载失败，请检查网络" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "下一步:" -ForegroundColor Cyan
Write-Host "1. 打开 index.html" -ForegroundColor White
Write-Host "2. 检查图片是否正常显示" -ForegroundColor White
Write-Host "3. 开始使用！" -ForegroundColor White
Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
