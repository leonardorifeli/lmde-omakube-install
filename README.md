# LMDE Post-Install Script (Omakub Style)

This project contains a post-install script to transform Linux Mint Debian Edition (LMDE) into a beautiful and productive KDE Plasma environment inspired by [Omakub](https://omakub.org).

## Features
- Installs KDE Plasma on LMDE
- Adds developer tools and essential packages
- Sets up Zsh + Oh My Zsh
- Installs Starship prompt
- Adds aliases for `kubectl` and `git`
- Downloads and installs Sweet theme and Tela icons
- Applies KDE theme and icons using `lookandfeeltool`
- Enables blur and window transparency effects via `kwriteconfig5`
- Installs Latte Dock and imports pre-defined layout
- Includes structure to install themes, fonts, wallpapers

## Requirements
- Clean LMDE installation
- Internet connection

## How to Use
```bash
git clone https://github.com/leonardorifeli/lmde-omakube-install.git
cd lmde-omakube-install
chmod +x install.sh
./install.sh
```

## To Do
- Add optional Latte Dock layout variations
- Add wallpaper auto-setup
- Add more KDE customizations (hotkeys, window rules, etc)

## License
MIT License