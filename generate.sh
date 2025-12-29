#!/bin/bash

# Jalankan dari root repo (rakifsul-ngonten)
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
TEKS_DIR="$BASE_DIR/teks"
README_FILE="$BASE_DIR/README.md"

# Header untuk README
echo "# List of RAKIFSUL Ngonten Blog Posts" > "$README_FILE"
echo "" >> "$README_FILE"

echo "**Pengumuman:**" >> "$README_FILE"
echo "" >> "$README_FILE"
echo "**Kami batal pindah dari GitHub ke substack, tapi kami akan menggunakan keduanya. Jadi, sekarang Anda bisa membaca RAKIFSUL Ngonten di repository ini atau di versi substack-nya dengan nama [RAKIFSUL Lagi Nulis](https://rakifsul.substack.com).**" >> "$README_FILE"

echo "" >> "$README_FILE"

echo "This repository contains my blog posts. If you want to read the English version, right click on your browser, then click \"Translate to English\". " >> "$README_FILE"
echo "" >> "$README_FILE"

# Loop untuk terbaru
echo "## Latest 5 Posts" >> "$README_FILE"
echo "" >> "$README_FILE"

# Ambil semua file .md lalu cek creation date berdasarkan git commit pertama
find "$TEKS_DIR" -type f -name "*.md" \
    | while read -r file_path; do
        # Ambil UNIX timestamp dari commit pertama (file creation)
        created_ts=$(git log --diff-filter=A --follow --format=%at -- "$file_path" 2>/dev/null | tail -n 1)

        # Jika file belum pernah di-commit (misal baru dibuat), fallback ke mtime
        if [[ -z "$created_ts" ]]; then
            created_ts=$(stat -c %Y "$file_path")
        fi

        echo "$created_ts|$file_path"
    done \
    | sort -nr \
    | head -n 5 \
    | while IFS='|' read -r created_ts file_path; do
        file_name=$(basename "$file_path" .md)
        link_text=$(echo "$file_name" | tr '-' ' ')
        rel_path="${file_path#$BASE_DIR/}"
        echo "- [$link_text]($rel_path)" >> "$README_FILE"
    done

echo "" >> "$README_FILE"

# Loop untuk setiap folder
find "$TEKS_DIR" -mindepth 1 -maxdepth 1 -type d | sort | while read -r cat_dir; do
    cat_name=$(basename "$cat_dir")
    echo "## $cat_name" >> "$README_FILE"
    echo "" >> "$README_FILE"

    # Cari file .md di folder tersebut
    find "$cat_dir" -type f -name "*.md" | sort | while read -r file_path; do
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
