# LMDE Post-Install Script (Omakub Style)

This project contains a post-install script to transform Linux Mint Debian Edition (LMDE) into a beautiful and productive KDE Plasma environment inspired by [Omakub](https://omakub.org).

## Features
- Installs KDE Plasma on LMDE
- Adds developer tools and essential packages
- Sets up Zsh + Oh My Zsh
- Installs Starship prompt
- Adds aliases for `kubectl` and `git`
- Downloads and installs Sweet theme and Tela icons
- Includes structure to install themes, fonts, wallpapers

## Requirements
- Clean LMDE installation
- Internet connection

## How to Use
```bash
git clone https://github.com/YOUR-USERNAME/lmde-postinstall.git
cd lmde-postinstall
chmod +x install.sh
./install.sh
```

## To Do
- Add automated theme/icon application (via `lookandfeeltool`)
- Add blur/transparency setup
- Add KDE config import script

## License
MIT License