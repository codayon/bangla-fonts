#!/bin/bash

FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

urls=(
    "https://www.omicronlab.com/download/fonts/muktinarrow.ttf"
    "https://www.omicronlab.com/download/fonts/Mukti_1.99_PR.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSansBengali/full/ttf/NotoSansBengali-Light.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSansBengali/full/ttf/NotoSansBengali-Medium.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSansBengali/full/ttf/NotoSansBengali-Bold.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSansBengali/full/ttf/NotoSansBengaliUI-Light.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSansBengali/full/ttf/NotoSansBengaliUI-Medium.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSansBengali/full/ttf/NotoSansBengaliUI-Bold.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSerifBengali/full/ttf/NotoSerifBengali-Light.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSerifBengali/full/ttf/NotoSerifBengali-Medium.ttf"
    "https://raw.githubusercontent.com/notofonts/notofonts.github.io/main/fonts/NotoSerifBengali/full/ttf/NotoSerifBengali-Bold.ttf"
)

# Download each file
for url in "${urls[@]}"; do
    file_name=$(basename "$url")     # Extract file name from URL
    file_path="$FONT_DIR/$file_name" # Save in fonts directory

    # Check if font already exists
    if [[ -f "$file_path" ]]; then
        echo "Skipping $file_name (already exists)."
        continue
    fi

    echo "Downloading $file_name..."
    wget -c --tries=3 "$url" -O "$file_path" --no-check-certificate
done

# Refresh font cache
if command -v fc-cache &>/dev/null; then
    echo "Updating font cache..."
    fc-cache -fv
else
    echo "fc-cache command not found. Skipping font cache update."
fi

echo "Font installation complete!"
