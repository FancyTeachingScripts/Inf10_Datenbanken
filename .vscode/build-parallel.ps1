# Parallel LaTeX Build Script
Write-Host "=== Parallel LaTeX Build Script ===" -ForegroundColor Magenta

# Find all TeX files in main directory
$texFiles = Get-ChildItem -Path ".\main\*.tex"
Write-Host "Found $($texFiles.Count) TeX files to compile in parallel..." -ForegroundColor Cyan

# Start first compilation pass
$processes = @()
foreach ($file in $texFiles) {
    Write-Host "Starting first compilation pass of $($file.Name)..." -ForegroundColor Yellow
    $process = Start-Process -FilePath "lualatex" -ArgumentList "-interaction=nonstopmode", "-output-directory=.", $file.FullName -PassThru -NoNewWindow -Wait:$false
    $processes += @{Process=$process; FileName=$file.Name; FilePath=$file.FullName}
}

# Wait for first pass to complete
Write-Host "Waiting for first compilation pass to complete..." -ForegroundColor Cyan
foreach ($procInfo in $processes) {
    $procInfo.Process.WaitForExit()
    if ($procInfo.Process.ExitCode -eq 0) {
        Write-Host "First pass completed for $($procInfo.FileName)" -ForegroundColor Green
    } else {
        Write-Host "First pass failed for $($procInfo.FileName)" -ForegroundColor Red
    }
}

# Start second compilation pass
$processes2 = @()
foreach ($procInfo in $processes) {
    Write-Host "Starting second compilation pass of $($procInfo.FileName)..." -ForegroundColor Yellow
    $process = Start-Process -FilePath "lualatex" -ArgumentList "-interaction=nonstopmode", "-output-directory=.", $procInfo.FilePath -PassThru -NoNewWindow -Wait:$false
    $processes2 += @{Process=$process; FileName=$procInfo.FileName}
}

# Wait for second pass to complete and report final results
Write-Host "Waiting for second compilation pass to complete..." -ForegroundColor Cyan
foreach ($procInfo in $processes2) {
    $procInfo.Process.WaitForExit()
    if ($procInfo.Process.ExitCode -eq 0) {
        Write-Host "Successfully compiled $($procInfo.FileName) (2 passes)" -ForegroundColor Green
    } else {
        Write-Host "Failed second pass for $($procInfo.FileName)" -ForegroundColor Red
    }
}

# Move PDF files to main/pdfs directory
Write-Host "Moving PDF files to main/pdfs directory..." -ForegroundColor Cyan

# Create main/pdfs directory if it doesn't exist
if (!(Test-Path ".\main\pdfs")) {
    New-Item -ItemType Directory -Path ".\main\pdfs" -Force | Out-Null
    Write-Host "Created main/pdfs directory" -ForegroundColor Yellow
}

Get-ChildItem -Path "." -Name "*.pdf" | Where-Object { $_ -like "main_*" -or $_ -like "presentation*" -or $_ -like "print*" } | ForEach-Object {
    Move-Item $_ ".\main\pdfs\" -Force
    Write-Host "Moved $_ to main/pdfs directory" -ForegroundColor Yellow
}

# Clean up temporary files
Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
Get-ChildItem -Path "." -Include "*.aux","*.log","*.nav","*.out","*.snm","*.toc","*.atfi","*.fls","*.fdb_latexmk","*.synctex.gz","*.bbl","*.blg" -Recurse | Remove-Item -Force

Write-Host "Cleanup completed!" -ForegroundColor Green
Write-Host "=== Build process finished ===" -ForegroundColor Magenta
