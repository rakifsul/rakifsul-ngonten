#!/bin/bash

# Jalankan dari root repo (rakifsul-ngonten)
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
TEKS_DIR="$BASE_DIR/teks"
README_FILE="$BASE_DIR/README.md"

# Header untuk README
echo "# List of RAKIFSUL Ngonten Blog Posts" > "$README_FILE"
echo "" >> "$README_FILE"
echo "This repository contains my Indonesian version of my blog posts." >> "$README_FILE"
echo "" >> "$README_FILE"
echo "I write the [English version at Substack](https://rakifsul.substack.com)." >> "$README_FILE"
echo "" >> "$README_FILE"

# Loop untuk setiap folder tahun-bulan (urut dari terbaru ke terlama)
find "$TEKS_DIR" -mindepth 1 -maxdepth 1 -type d | sort -r | while read -r month_dir; do
    month_name=$(basename "$month_dir")
    echo "## $month_name" >> "$README_FILE"
    echo "" >> "$README_FILE"

    # Cari file .md di folder tersebut
    find "$month_dir" -type f -name "*.md" | sort | while read -r file_path; do
        file_name=$(basename "$file_path" .md)
        link_text=$(echo "$file_name" | tr '-' ' ')
        rel_path="${file_path#$BASE_DIR/}"
        echo "- [$link_text]($rel_path)" >> "$README_FILE"
    done

    echo "" >> "$README_FILE"
done

echo "## Get More Precious Links" >> "$README_FILE"

echo "" >> "$README_FILE"

echo "- [www.rakifsul.my.id](https://www.rakifsul.my.id)" >> "$README_FILE"

echo "✅ README.md berhasil digenerate di $README_FILE"
