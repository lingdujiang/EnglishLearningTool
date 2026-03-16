# Batch Image Generation Script
$apiKey = "sk-6dad665b8a33487a94b17b2d5647d278"
$saveDir = "D:\clawProject\EnglishLearningProject\code\data\images\generated"

# Create save directory
if (!(Test-Path $saveDir)) {
    New-Item -ItemType Directory -Path $saveDir -Force
    Write-Host "Created directory: $saveDir"
}

# Word list
$words = @("dog", "red", "mom", "ball")

# Prompt template
$promptStyle = "cartoon style, clean white background, high resolution, cute, simple lines, no text, no watermark"

foreach ($word in $words) {
    Write-Host "Generating: $word ..."
    
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
        Write-Host "Task ID: $taskId"
        
        # Poll task status
        $maxAttempts = 30
        $attempt = 0
        $status = "PENDING"
        
        while ($status -eq "PENDING" -or $status -eq "RUNNING") {
            Start-Sleep -Seconds 2
            $attempt++
            
            $taskResponse = Invoke-RestMethod -Uri "https://dashscope.aliyuncs.com/api/v1/tasks/$taskId" -Method Get -Headers $headers
            $status = $taskResponse.output.task_status
            
            Write-Host "  Status: $status (attempt $attempt/$maxAttempts)"
            
            if ($attempt -ge $maxAttempts) {
                Write-Host "  Timeout, skipping" -ForegroundColor Yellow
                break
            }
        }
        
        if ($status -eq "SUCCEEDED") {
            $imageUrl = $taskResponse.output.results[0].url
            Write-Host "  Image URL: $imageUrl"
            
            # Generate filename
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $fileName = "${word}_${timestamp}.png"
            $outputPath = Join-Path $saveDir $fileName
            
            # Download image
            Invoke-WebRequest -Uri $imageUrl -OutFile $outputPath
            Write-Host "  Saved: $outputPath" -ForegroundColor Green
        } else {
            Write-Host "  Generation failed: $status" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "Batch generation completed!" -ForegroundColor Cyan
