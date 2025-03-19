#!/bin/bash

FONT_DIR="$HOME/.local/share/fonts"

# Function to install missing package i.e. unzip
install_package() {
    local package=$1

    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt install -y "$package"
    elif command -v yum &>/dev/null; then
        sudo yum install -y "$package"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$package"
    elif command -v pacman &>/dev/null; then
        sudo pacman -Sy --noconfirm "$package"
    elif command -v zypper &>/dev/null; then
        sudo zypper install -y "$package"
    else
        echo "Unsupported package manager. Please install $package manually."
        exit 1
    fi
}

# Install unzip
if ! command -v unzip &>/dev/null; then
    echo "unzip is not installed. Installing..."
    install_package unzip
fi

# Ensure font directory exists
mkdir -p "$FONT_DIR"

# List of font URLs
urls=(
    "https://www.omicronlab.com/download/fonts/kalpurush.ttf"
    "https://www.omicronlab.com/download/fonts/kalpurush%20ANSI.ttf"
    "https://www.omicronlab.com/download/fonts/Siyamrupali.ttf"
    "https://www.omicronlab.com/download/fonts/Siyam%20Rupali%20ANSI.ttf"
    "https://www.omicronlab.com/download/fonts/AponaLohit.ttf"
    "https://www.omicronlab.com/download/fonts/SolaimanLipi_20-04-07.ttf"
    "https://www.omicronlab.com/download/fonts/Bangla.ttf"
    "https://www.omicronlab.com/download/fonts/AdorshoLipi_20-07-2007.ttf"
    "https://www.omicronlab.com/download/fonts/BenSen.ttf"
    "https://www.omicronlab.com/download/fonts/BenSenHandwriting.ttf"
    "https://www.omicronlab.com/download/fonts/Nikosh.ttf"
    "https://www.omicronlab.com/download/fonts/NikoshBAN.ttf"
    "https://www.omicronlab.com/download/fonts/NikoshGrameen.ttf"
    "https://www.omicronlab.com/download/fonts/NikoshLightBan.ttf"
    "https://www.omicronlab.com/download/fonts/akaashnormal.ttf"
    "https://www.omicronlab.com/download/fonts/mitra.ttf"
    "https://www.omicronlab.com/download/fonts/sagarnormal.ttf"
    "https://www.omicronlab.com/download/fonts/muktinarrow.ttf"
    "https://www.omicronlab.com/download/fonts/Mukti_1.99_PR.ttf"
    "https://www.omicronlab.com/download/fonts/Lohit_14-04-2007.ttf"
    "https://okkhor52.com/download/Ekushey_Mukto.zip"
    "https://okkhor52.com/download/Ekushey_Sornaly%20.zip"
    "https://okkhor52.com/download/Ekushey_Lal_Salu.zip"
    "https://okkhor52.com/download/Ekushey_Bangla_Kolom.zip"
    "https://okkhor52.com/download/Ekushey_Amar_Bangla.zip"
    "https://okkhor52.com/download/Charukola.zip"
    "https://okkhor52.com/download/RuposhiBangla.zip"
)

# Download each file
for url in "${urls[@]}"; do
    file_name=$(basename "$url")  # Extract file name from URL
    file_path="$FONT_DIR/$file_name"  # Save in fonts directory

    # Check if font already exists
    if [[ -f "$file_path" ]]; then
        echo "Skipping $file_name (already exists)."
        continue
    fi

    echo "Downloading $file_name..."
    wget -c "$url" -O "$file_path" --no-check-certificate

    # Check file type and extract if necessary
    if [[ "$file_name" == *.zip ]]; then
        echo "Extracting $file_name..."
        unzip -o "$file_path" -d "$FONT_DIR/"
        rm "$file_path"  # Remove ZIP file after extraction
    fi
done

# Refresh font cache
echo "Updating font cache..."
fc-cache -fv

echo "Font installation complete!"

