#!/bin/bash

# Crear el enlace para Tmux
echo "Configurando Tmux..."
ln -sf ~/.config/nvim/tmux/tmux.conf ~/.tmux.conf

# Instalar dependencias de Homebrew
echo "Instalando dependencias desde el Brewfile..."
brew bundle --file=~/.config/nvim/Brewfile

echo "¡Todo listo! Reinicia tu terminal."
