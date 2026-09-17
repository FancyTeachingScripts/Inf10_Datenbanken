# Compiles the fixed PDF set that .github/workflows/PR-Preview.yml (via
# FancyScript's reusable pr-preview.yml) builds on every PR, so it can be
# checked locally before pushing. Keep this list in sync with the
# `texfile` matrix in template/.github/workflows/pr-preview.yml.

$ErrorActionPreference = "Stop"

Set-Location (Join-Path $PSScriptRoot "..")

bash template/tools/gen-main.sh main

$files = @(
    "presentation_noaufraeumen.tex",
    "presentation_noaufraeumen-bright.tex",
    "print_students-cover.tex",
    "print_solution-cover.tex"
)

$baseArgs = @("-Z", "search-path=.", "-Z", "search-path=template", "-Z", "search-path=template/sty/moloch", "-Z", "continue-on-errors")

foreach ($f in $files) {
    Write-Host "==> $f" -ForegroundColor Cyan
    & tectonic @baseArgs -o . "main/$f"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed compilation for $f" -ForegroundColor Red
        exit $LASTEXITCODE
    }
}
