# 快速下载所有图片（使用占位图服务）
Write-Host "🎨 快速下载图片素材..." -ForegroundColor Cyan
Write-Host ""

$imagesDir = Join-Path $PSScriptRoot "images"
if (-not (Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir | Out-Null
}

# 动物等级图（使用彩色圆形占位图）
Write-Host "📥 下载动物等级图..." -ForegroundColor Cyan
$animals = @{
    "egg" = "FFE4B5"
    "chick" = "FFD700"
    "bird" = "87CEEB"
    "bigbird" = "BA55D3"
    "phoenix" = "FF4500"
}

foreach ($item in $animals.GetEnumerator()) {
    $url = "https://placehold.co/200x200/$($item.Value)/FFFFFF.png?text=$($item.Key)"
    $dest = Join-Path $imagesDir "$($item.Key).png"
    try {
        (New-Object Net.WebClient).DownloadFile($url, $dest)
        Write-Host "  ✅ $($item.Key).png" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ $($item.Key).png" -ForegroundColor Red
    }
}

# 单词图片
Write-Host "`n📥 下载单词图片..." -ForegroundColor Cyan
$words = @(
    "cat","dog","bird","fish","rabbit","duck","pig","cow","horse","sheep",
    "red","blue","green","yellow","orange","purple","pink","black","white","brown",
    "one","two","three","four","five","six","seven","eight","nine","ten",
    "mom","dad","grandma","grandpa","sister","brother","baby","family","uncle","aunt",
    "ball","book","pencil","bag","cup","chair","table","bed","door","window"
)

# 颜色映射
$colors = @{
    "cat"="FFB6C1";"dog"="8B4513";"bird"="87CEEB";"fish"="FFA500";"rabbit"="FFC0CB"
    "duck"="FFD700";"pig"="FFC0CB";"cow"="000000";"horse"="8B4513";"sheep"="F5F5F5"
    "red"="FF0000";"blue"="0000FF";"green"="008000";"yellow"="FFFF00";"orange"="FFA500"
    "purple"="800080";"pink"="FFC0CB";"black"="000000";"white"="FFFFFF";"brown"="A52A2A"
    "one"="FF6B6B";"two"="4ECDC4";"three"="45B7D1";"four"="96CEB4";"five"="FFEAA7"
    "six"="DDA0DD";"seven"="98FB98";"eight"="F0E68C";"nine"="E6E6FA";"ten"="FFDAB9"
    "mom"="FFB6C1";"dad"="4682B4";"grandma"="DDA0DD";"grandpa"="708090";"sister"="FF69B4"
    "brother"="1E90FF";"baby"="FFDAB9";"family"="9370DB";"uncle"="2F4F4F";"aunt"="DB7093"
    "ball"="FF4500";"book"="8B4513";"pencil"="FFD700";"bag"="4169E1";"cup"="F5F5DC"
    "chair"="8B4513";"table"="A0522D";"bed"="4682B4";"door"="8B4513";"window"="87CEEB"
}

$count = 0
foreach ($word in $words) {
    $color = if ($colors[$word]) { $colors[$word] } else { "667eea" }
    $letter = $word.Substring(0,1).ToUpper()
    $url = "https://placehold.co/400x400/$color/FFFFFF.png?text=$letter"
    $dest = Join-Path $imagesDir "$word.png"
    
    try {
        (New-Object Net.WebClient).DownloadFile($url, $dest)
        $count++
        Write-Host "  ✅ $word.png" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ $word.png" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "====================" -ForegroundColor Cyan
Write-Host "✅ 完成！下载 $count/50 张单词图片" -ForegroundColor Green
Write-Host "📂 位置：$imagesDir" -ForegroundColor Cyan
Write-Host ""
Write-Host "刷新 index.html 即可看到图片！" -ForegroundColor Green
