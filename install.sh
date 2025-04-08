#!/bin/bash
set -e

echo "\n🟢 Starting post-installation setup for LMDE with KDE (Omakub style)..."

# Update and install essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    git curl wget unzip build-essential \
    zsh neofetch fonts-firacode gnome-tweaks \
    vlc gimp htop btop \
    kde-plasma-desktop latte-dock

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "\n🔧 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Starship prompt
if ! command -v starship &> /dev/null; then
    echo "\n🌟 Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Copy config files
mkdir -p ~/.config
cp config/.zshrc ~/.zshrc
mkdir -p ~/.config/starship
cp config/starship.toml ~/.config/starship.toml

# Set Zsh as default shell
chsh -s $(which zsh)

# Install Sweet theme and Tela icons
echo "\n🎨 Installing themes and icons..."
git clone https://github.com/EliverLara/Sweet.git ~/Downloads/Sweet
mkdir -p ~/.local/share/plasma/desktoptheme/
cp -r ~/Downloads/Sweet ~/.local/share/plasma/desktoptheme/

wget -O tela-icon-theme.zip https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
unzip tela-icon-theme.zip -d ~/Downloads/
cd ~/Downloads/Tela-icon-theme-master
./install.sh -d ~/.local/share/icons
cd -

# Apply Sweet theme and Tela icons if lookandfeeltool exists
if command -v lookandfeeltool &> /dev/null; then
    echo "\n🎨 Applying Sweet KDE theme..."
    lookandfeeltool -a Sweet
    kwriteconfig5 --file kdeglobals --group Icons --key Theme Tela

    # Set transparency and blur
    kwriteconfig5 --file kwinrc --group Compositing --key Enabled true
    kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled true
    qdbus org.kde.KWin /KWin reconfigure
fi

# Install Latte Dock layout (optional)
echo "\n🧩 Importing Latte Dock layout..."
mkdir -p ~/.config/latte/
cp kde-configs/latte-layouts/omakub.layout.latte ~/.config/latte/
latte-dock --import-layout ~/.config/latte/omakub.layout.latte --replace &

echo "\n✅ Post-install complete. Please reboot to start KDE Plasma."
echo "\n Powered-by rifeli.dev"