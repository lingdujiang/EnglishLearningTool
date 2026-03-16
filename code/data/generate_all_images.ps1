# Batch Image Generation Script - All 50 Words
$apiKey = "sk-6dad665b8a33487a94b17b2d5647d278"
$saveDir = "D:\clawProject\EnglishLearningProject\code\images"

# Create save directory
if (!(Test-Path $saveDir)) {
    New-Item -ItemType Directory -Path $saveDir -Force
    Write-Host "Created directory: $saveDir"
}

# All 50 words from input.js
$words = @(
    # Animals (1-10)
    "cat", "dog", "bird", "fish", "rabbit", "duck", "pig", "cow", "horse", "sheep",
    # Colors (11-20)
    "red", "blue", "green", "yellow", "orange", "purple", "pink", "black", "white", "brown",
    # Numbers (21-30)
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
    # Family (31-40)
    "mom", "dad", "grandma", "grandpa", "sister", "brother", "baby", "family", "uncle", "aunt",
    # Objects (41-50)
    "ball", "book", "pencil", "bag", "cup", "chair", "table", "bed", "door", "window"
)

# Prompt template
$promptStyle = "cartoon style, clean white background, high resolution, cute, simple lines, no text, no watermark"

$total = $words.Count
$successCount = 0
$failCount = 0

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting batch generation: $total words" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

for ($i = 0; $i -lt $total; $i++) {
    $word = $words[$i]
    $num = $i + 1
    Write-Host "[$num/$total] Generating: $word ..." -ForegroundColor Yellow
    
    $prompt = "$word, $promptStyle"
    
    # Submit task
    $headers = @{
        "Authorization" = "Bearer $apiKey"
        "Content-Type" = "application/json"
        "X-DashScope-Async" = "enable"
    }
    
    $body = @{
        model = "wanx2.1-t2i-turbo"
        input = @{
            prompt = $prompt
        }
        parameters = @{
            style = "cartoon"
            size = "1024*1024"
        }
    } | ConvertTo-Json -Depth 5
    
    try {
        $submitResponse = Invoke-RestMethod -Uri "https://dashscope.aliyuncs.com/api/v1/services/aigc/text2image/image-synthesis" -Method Post -Headers $headers -Body $body
        
        $taskId = $submitResponse.output.task_id
        
        # Poll task status
        $maxAttempts = 30
        $attempt = 0
        $status = "PENDING"
        
        while ($status -eq "PENDING" -or $status -eq "RUNNING") {
            Start-Sleep -Seconds 2
            $attempt++
            
            $taskResponse = Invoke-RestMethod -Uri "https://dashscope.aliyuncs.com/api/v1/tasks/$taskId" -Method Get -Headers $headers
            $status = $taskResponse.output.task_status
            
            if ($attempt % 5 -eq 0) {
                Write-Host "  Status: $status (attempt $attempt/$maxAttempts)"
            }
            
            if ($attempt -ge $maxAttempts) {
                Write-Host "  Timeout, skipping" -ForegroundColor Red
                $failCount++
                break
            }
        }
        
        if ($status -eq "SUCCEEDED") {
            $imageUrl = $taskResponse.output.results[0].url
            
            # Generate filename
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $fileName = "${word}_${timestamp}.png"
            $outputPath = Join-Path $saveDir $fileName
            
            # Download image
            Invoke-WebRequest -Uri $imageUrl -OutFile $outputPath
            Write-Host "  [SUCCESS] Saved: $fileName" -ForegroundColor Green
            $successCount++
        } elseif ($status -ne "TIMEOUT") {
            Write-Host "  [FAILED] Generation failed: $status" -ForegroundColor Red
            $failCount++
        }
    }
    catch {
        Write-Host "  [ERROR] $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
    
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Batch generation completed!" -ForegroundColor Cyan
Write-Host "Total: $total | Success: $successCount | Failed: $failCount" -ForegroundColor Cyan
Write-Host "Output directory: $saveDir" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
