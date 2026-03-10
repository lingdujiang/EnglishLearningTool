# 批量生成英语单词发音文件
# 使用 Microsoft Speech API (Windows 内置)
# 无需安装任何软件！

Write-Host "🎤 开始生成英语单词发音文件..." -ForegroundColor Cyan
Write-Host ""

# 创建 audio 文件夹
$audioDir = Join-Path $PSScriptRoot "audio"
if (-not (Test-Path $audioDir)) {
    New-Item -ItemType Directory -Path $audioDir | Out-Null
    Write-Host "✅ 创建文件夹：$audioDir" -ForegroundColor Green
}

# 50 个一年级英语单词
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

# 创建语音合成对象
Add-Type -AssemblyName System.Speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer

# 设置为英语
$speak.SelectVoiceByHints("en-US")

Write-Host "📢 使用语音引擎：$($speak.Voice.Name)" -ForegroundColor Green
Write-Host ""

$successCount = 0
$failCount = 0

foreach ($word in $words) {
    $index = $words.IndexOf($word) + 1
    Write-Host "[$index/$($words.Count)] 生成：$word.wav" -NoNewline
    
    try {
        $outputFile = Join-Path $audioDir "$word.wav"
        
        # 生成语音并保存为 WAV 文件
        $speak.SetOutputToWaveFile($outputFile)
        $speak.Speak($word)
        $speak.SetOutputToNull()
        
        if (Test-Path $outputFile) {
            Write-Host " ✅" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host " ❌ 文件创建失败" -ForegroundColor Red
            $failCount++
        }
    }
    catch {
        Write-Host " ❌ $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
}

# 清理
$speak.Dispose()

Write-Host ""
Write-Host "=" -ForegroundColor Cyan -NoNewline
Write-Host "========================" -NoNewline
Write-Host "=" -ForegroundColor Cyan
Write-Host "✅ 成功：$successCount/$($words.Count)" -ForegroundColor Green
Write-Host "❌ 失败：$failCount/$($words.Count)" -ForegroundColor Red
Write-Host ""

if ($successCount -eq $words.Count) {
    Write-Host "🎉 所有单词发音文件生成成功！" -ForegroundColor Green
    Write-Host "📂 文件位置：$audioDir" -ForegroundColor Cyan
} else {
    Write-Host "⚠ 部分文件生成失败" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "下一步:" -ForegroundColor Cyan
Write-Host "1. 打开 index.html" -ForegroundColor White
Write-Host "2. 点击「🔊 听发音」按钮" -ForegroundColor White
Write-Host "3. 应该能听到清晰的发音了！" -ForegroundColor White
Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
