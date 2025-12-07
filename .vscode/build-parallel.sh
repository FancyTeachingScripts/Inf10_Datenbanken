#!/bin/bash
# Parallel LaTeX Build Script for Debian

echo "=== Parallel LaTeX Build Script ==="

# Create output directory
mkdir -p main/pdfs

# Find all tex files
files=(main/*.tex)
echo "Found ${#files[@]} TeX files to compile..."

# Function to run lualatex
run_lualatex() {
    lualatex -interaction=nonstopmode -output-directory=. "$1" > /dev/null
}

echo "Starting first compilation pass..."
pids=()
for file in "${files[@]}"; do
    echo "Compiling $(basename "$file")..."
    run_lualatex "$file" &
    pids+=($!)
done

# Wait for first pass
for pid in "${pids[@]}"; do
    wait $pid
done
echo "First pass completed."

echo "Starting second compilation pass..."
pids=()
for file in "${files[@]}"; do
    echo "Compiling $(basename "$file")..."
    run_lualatex "$file" &
    pids+=($!)
done

# Wait for second pass
for pid in "${pids[@]}"; do
    wait $pid
done
echo "Second pass completed."

# Move PDFs
echo "Moving PDF files..."
mv *.pdf main/pdfs/ 2>/dev/null

echo "Done."
