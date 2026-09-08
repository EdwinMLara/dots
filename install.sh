#!/bin/bash

# Crear el enlace para Tmux
echo "Configurando Tmux..."
ln -sf ~/.config/nvim/tmux/tmux.conf ~/.tmux.conf

# Instalar TPM (gestor de plugins de tmux) si no existe
if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "Instalando TPM (tmux plugin manager)..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Instalar dependencias de Homebrew
echo "Instalando dependencias desde el Brewfile..."
brew bundle --file=~/.config/nvim/Brewfile

echo "¡Todo listo! Reinicia tu terminal."
