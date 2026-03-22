-- ========================================================================== --
--                           CONFIGURACIÓN BÁSICA                             --
-- ========================================================================== --

-- Numeración de líneas (híbrida: actual + relativas para saltos rápidos)

vim.opt.number = true
vim.opt.relativenumber = true

-- Hablitar el mouse para scrolls y clicks rapidos
vim.opt.mouse = "a"

-- Sincronizar el portapapeles con macOS (pbcopy/pbpaste)
-- Esto permite que el registro '+' Vim usa el portapeles del sistema 

vim.g.clipboard = {
  name = "macOS-clipboard",
  copy = {
    ["+"] = { "pbcopy" },
    ["*"] = { "pbcopy" },
  },
  paste = {
    ["+"] = { "pbpaste" },
    ["*"] = { "pbpaste" },
  },
  cache_enabled = 0,
}

vim.opt.clipboard = "unnamedplus"

-- Configuracion de tabs identacion de dos espacios
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Busqueda inteligante ignora mayusculas a menos que las escriba
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Telca leader esapcio es las usada
vim.g.mapleader = " "

-- configuracion para abrir el explorador con la motion de espacio e
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Abrir explorador de archivos" })

-- ========================================================================== --
--                         GESTOR DE PLUGINS (LAZY.NVIM)                      --
-- ========================================================================== --

-- instalacion automatica de lazy.nvim si no esta presente
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  }
end

vim.opt.runtimepath:prepend(lazypath)

-- Configuracion de plugins
require("lazy").setup({
  -- TEMA: tokio night
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- PARSER: Treesittier (Resaltado de sintaxis avanzado) 
  {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "javascript",
      "typescript",
      "tsx",
      "go",
      "json",
      "html",
      "css",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
  
 -- GIT: LazyGit (Interfaz visual de Git dentro de Neovim)
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Abrir LazyGit" },
    },
  },

  -- NAVEGACIÓN: Tmux Navigator (Moverse entre Tmux y Neovim con Ctrl+hjkl)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp", "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- BUSCADOR: Telescope (El buscador más potente: archivos, texto, etc.)
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Buscar archivos' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Buscar texto (grep)' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buscar en buffers abiertos' })
    end
  },

  -- TERMINAL: Toggleterm (Ventanas flotantes para servicios)
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]], -- Ctrl + \ para abrir/cerrar
        hide_numbers = true,
        shade_terminals = true,
        direction = 'float',      -- Ventana flotante por defecto
        float_opts = {
          border = 'curved',      -- Bordes redondeados estéticos
        },
      })
    end
  },
  
 }

})
