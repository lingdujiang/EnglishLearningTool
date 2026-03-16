# Rename images: ${word}_timestamp.png -> ${word}.png
$sourceDir = "D:\clawProject\EnglishLearningProject\code\images"

# All 50 words
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

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Renaming images in: $sourceDir" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$renamedCount = 0
$skippedCount = 0

foreach ($word in $words) {
    # Find files matching pattern: ${word}_*.png
    $pattern = Join-Path $sourceDir "${word}_*.png"
    $files = Get-ChildItem -Path $pattern -File -ErrorAction SilentlyContinue
    
    if ($files.Count -eq 0) {
        Write-Host "[$word] No matching files found" -ForegroundColor Yellow
        $skippedCount++
        continue
    }
    
    # Get the first matching file (should be only one)
    $oldFile = $files[0]
    $newFileName = "${word}.png"
    $newFilePath = Join-Path $sourceDir $newFileName
    
    Write-Host "[$word] Found: $($oldFile.Name)" -ForegroundColor Gray
    
    # Check if target file already exists
    if (Test-Path $newFilePath) {
        Write-Host "  Target exists, overwriting: $newFileName" -ForegroundColor Yellow
        Remove-Item -Path $newFilePath -Force
    }
    
    # Rename the file
    Rename-Item -Path $oldFile.FullName -NewName $newFileName
    Write-Host "  [RENAMED] $($oldFile.Name) -> $newFileName" -ForegroundColor Green
    $renamedCount++
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Rename completed!" -ForegroundColor Cyan
Write-Host "Renamed: $renamedCount | Skipped: $skippedCount" -ForegroundColor Cyan
Write-Host "Output directory: $sourceDir" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
