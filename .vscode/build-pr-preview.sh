#!/bin/bash
# Compiles the fixed PDF set that .github/workflows/PR-Preview.yml (via
# FancyScript's reusable pr-preview.yml) builds on every PR, so it can be
# checked locally before pushing. Keep this list in sync with the
# `texfile` matrix in template/.github/workflows/pr-preview.yml.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

bash template/tools/gen-main.sh main

FILES=(
  presentation_noaufraeumen.tex
  presentation_noaufraeumen-bright.tex
  print_students-cover.tex
  print_solution-cover.tex
)

for f in "${FILES[@]}"; do
  echo "==> $f"
  tectonic -Z search-path=. -Z search-path=template -Z search-path=template/sty/moloch \
    -Z continue-on-errors -o . "main/$f"
done
