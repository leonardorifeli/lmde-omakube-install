#!/bin/bash
set -e

function print_header() {
  echo -e "\n🟢 \033[1mLMDE Post-Install (Omakub Style)\033[0m"
  echo "This script will help you transform LMDE into a KDE Plasma setup inspired by Omakub."
  echo "Powered by Leonardo Rifeli — https://rifeli.dev"
}

function confirm_or_exit() {
  read -p "\nProceed with installation? (y/N): " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "❌ Installation aborted."
    exit 1
  fi
}

function install_base_packages() {
  echo "\n📦 Installing base packages..."
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y \
    git curl wget unzip build-essential \
    zsh neofetch fonts-firacode gnome-tweaks \
    vlc gimp htop btop \
    kde-plasma-desktop latte-dock dconf-cli
}

function install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "\n🔧 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

function install_starship() {
  if ! command -v starship &> /dev/null; then
    echo "\n🌟 Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
  fi
}

function configure_shell() {
  echo "\n⚙️ Configuring shell..."
  mkdir -p ~/.config/starship
  cp config/.zshrc ~/.zshrc
  cp config/starship.toml ~/.config/starship.toml
  chsh -s $(which zsh)
}

function install_themes() {
  echo "\n🎨 Installing themes and icons..."
  git clone https://github.com/EliverLara/Sweet.git ~/Downloads/Sweet
  mkdir -p ~/.local/share/plasma/desktoptheme/
  cp -r ~/Downloads/Sweet ~/.local/share/plasma/desktoptheme/

  wget -O tela-icon-theme.zip https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
  unzip tela-icon-theme.zip -d ~/Downloads/
  cd ~/Downloads/Tela-icon-theme-master && ./install.sh -d ~/.local/share/icons && cd -
}

function apply_kde_config() {
  if command -v lookandfeeltool &> /dev/null; then
    echo "\n🧩 Applying KDE configurations..."
    lookandfeeltool -a Sweet
    kwriteconfig5 --file kdeglobals --group Icons --key Theme Tela
    kwriteconfig5 --file kwinrc --group Compositing --key Enabled true
    kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled true
    qdbus org.kde.KWin /KWin reconfigure

    cp kde-configs/colorschemes/RifeliDark.colors ~/.local/share/color-schemes/
    cp kde-configs/kwinrules/transparency-rule.kwinrule ~/.config/kwinrulesrc.d/
    dconf load /org/gnome/shell/extensions/hot-corners/ < kde-configs/hotcorners/hotcorners.dconf
  fi
}

function apply_wallpaper() {
  echo "\n🖼️ Setting wallpaper..."
  wallpaper_path="$PWD/assets/wallpapers/retro_pc_rifeli.png"
  if [ -f "$wallpaper_path" ]; then
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
      var allDesktops = desktops();
      for (i = 0; i < allDesktops.length; i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = \"org.kde.image\";
        d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
        d.writeConfig(\"Image\", \"file://$wallpaper_path\");
      }"
  fi
}

function setup_latte_dock() {
  echo "\n🚀 Setting up Latte Dock layout..."
  mkdir -p ~/.config/latte/
  cp kde-configs/latte-layouts/omakub.layout.latte ~/.config/latte/
  latte-dock --import-layout ~/.config/latte/omakub.layout.latte --replace &
}

function setup_shortcuts() {
  echo "\n⌨️ Adding global shortcut: Ctrl+Alt+T to open terminal..."
  dbus-send --session \
    --dest=org.kde.kglobalaccel \
    /component/konsole \
    org.kde.kglobalaccel.Component.invokeShortcut \
    string:"NewTab"
}

# Main execution
print_header
confirm_or_exit
install_base_packages
install_oh_my_zsh
install_starship
configure_shell
install_themes
apply_kde_config
apply_wallpaper
setup_latte_dock
setup_shortcuts

echo -e "\n✅ \033[1mInstallation complete! Reboot to start KDE Plasma.\033[0m"
echo -e "\n🔧 Powered by Leonardo Rifeli — https://rifeli.dev"
