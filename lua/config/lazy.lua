-- ========================================================================== --
--                     GESTOR DE PLUGINS (LAZY.NVIM)                          --
-- ========================================================================== --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  -- TEMA: tokio night
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- PARSER: Treesitter (Resaltado de sintaxis avanzado) 
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "javascript", "typescript", "tsx", "go", "json", "html", "css" },
      highlight = { enable = true },
      indent = { enable = true },
    },
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
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- BUSCADOR: Telescope (Archivos, texto, etc.)
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

  -- TERMINAL: Toggleterm (Ventanas flotantes)
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = 'float',
        float_opts = { border = 'curved' },
      })
    end
  },
})
