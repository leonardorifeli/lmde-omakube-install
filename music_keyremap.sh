#!/bin/bash

# Instala as dependências
echo "Instalando dependências..."
sudo apt update
sudo apt install -y xbindkeys playerctl

# Cria o arquivo de configuração do xbindkeys, caso não exista
echo "Configurando xbindkeys..."

CONFIG_FILE="$HOME/.xbindkeysrc"

if [ ! -f "$CONFIG_FILE" ]; then
    touch "$CONFIG_FILE"
fi

# Adiciona as configurações no arquivo .xbindkeysrc
cat <<EOL > "$CONFIG_FILE"
# Tecla Pause -> Play/Pause
"xbindkeys --release --no-window --display=:0"
    m:0x0 + c:0x73
    Exec playerctl play-pause

# Tecla PgUp -> Next
"xbindkeys --release --no-window --display=:0"
    m:0x0 + c:0x99
    Exec playerctl next

# Tecla PgDown -> Prev
"xbindkeys --release --no-window --display=:0"
    m:0x0 + c:0x9A
    Exec playerctl previous
EOL

# Inicia o xbindkeys
echo "Iniciando xbindkeys..."
xbindkeys

# Adiciona xbindkeys ao processo de inicialização do sistema
echo "Adicionando xbindkeys à inicialização..."
echo "xbindkeys" >> "$HOME/.profile"

# Finaliza com uma mensagem de sucesso
echo "Configuração concluída. As teclas Pause, PgUp e PgDown agora são teclas de mídia."
