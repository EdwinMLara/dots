-- ========================================================================== --
--                             CONFIGURACIÓN BÁSICA                           --
-- ========================================================================== --

local opt = vim.opt

-- Numeración de líneas (híbrida: actual + relativas para saltos rápidos)
opt.number = true
opt.relativenumber = true

-- Habilitar el mouse para scrolls y clicks rápidos
opt.mouse = "a"

-- Sincronizar el portapapeles con macOS (unnamedplus usa pbcopy/pbpaste por defecto)
opt.clipboard = "unnamedplus"

-- Configuración de tabs: indentación de dos espacios
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Búsqueda inteligente: ignora mayúsculas a menos que las escriba
opt.ignorecase = true
opt.smartcase = true

-- Tecla leader: espacio es la más usada
vim.g.mapleader = " "
