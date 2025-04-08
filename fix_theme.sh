#!/bin/bash
set -e

function fix_sweet_theme() {
  echo -e "\n🎨 Fixing Sweet theme installation..."

  echo "🔍 Checking for installed Sweet Look-and-Feel themes..."
  installed_theme=$(plasmapkg2 --type lookandfeel --list | grep -i sweet | awk '{print $1}')

  if [[ -n "$installed_theme" ]]; then
    echo "🧹 Removing existing theme: $installed_theme"
    plasmapkg2 --type lookandfeel --remove "$installed_theme"
  fi

  echo "🧼 Cleaning leftover Sweet files..."
  rm -rf ~/.local/share/plasma/look-and-feel/org.kde.sweet*
  rm -rf ~/.local/share/plasma/desktoptheme/Sweet*

  echo "📥 Installing new Sweet Look-and-Feel from archive..."
  SWEET_ARCHIVE="/tmp/OAAKDD-Sweet.tar.xz"
  if [[ -f "$SWEET_ARCHIVE" ]]; then
    plasmapkg2 --type lookandfeel -i "$SWEET_ARCHIVE"
    echo "✅ Sweet theme reinstalled successfully!"
  else
    echo "❌ Archive not found at $SWEET_ARCHIVE. Please download Sweet manually."
    echo "Visit https://store.kde.org/p/1270037/ or use 'Obter novos estilos' no KDE."
  fi

  echo -e "\n🧠 Go to System Settings > Appearance and apply the Sweet theme manually."
}

fix_sweet_theme
