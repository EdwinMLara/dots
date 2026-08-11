-- ========================================================================== --
--                        PLUGIN MANAGER (LAZY.NVIM)                          --
-- ========================================================================== --

--[[
  Lazy.nvim is a modern Neovim plugin manager.
  It handles installing, updating, and loading plugins.

  Key concepts:
  - Plugins are defined as Lua tables
  - Lazy loads plugins based on events, commands, or keys
  - { import = "plugins.xxx" } imports plugin files from lua/plugins/

  After adding plugins here, run:
  - :Lazy sync  - Install and sync all plugins
  - :Lazy        - Open Lazy UI
]]

-- Setup lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If lazy.nvim is not installed, clone it from GitHub
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

-- Add lazy.nvim to the runtime path
vim.opt.runtimepath:prepend(lazypath)

-- ========================================================================== --
-- LOAD ALL PLUGINS                                                          --
-- ========================================================================== --

require("lazy").setup({
  -- Import plugin definitions from lua/plugins/
  -- This keeps the main config file clean and organized

  -- LSP plugins: Language Server Protocol support
  -- (mason.nvim, mason-lspconfig, nvim-lspconfig)
  { import = "plugins.lsp" },

  -- Completion plugins: nvim-cmp for code completion
  { import = "plugins.cmp" },

  -- Tool plugins: Developer utilities
  -- (harpoon, telescope, toggleterm, lualine, etc.)
  { import = "plugins.tools" },

  -- ========================================================================== --
  -- THEME: Color scheme                                                       --
  -- ========================================================================== --

  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Load first (higher priority = loaded first)
    config = function()
      -- Apply the colorscheme
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- ========================================================================== --
  -- TREESITTER: Advanced syntax highlighting and text objects               --
  -- ========================================================================== --

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Compile parsers on install
    opts = {
      -- Languages to install parsers for
      ensure_installed = {
        "lua",        -- Lua (Neovim config)
        "javascript", -- JavaScript
        "typescript", -- TypeScript
        "tsx",        -- React/TypeScript
        "go",         -- Go
        "json",       -- JSON
        "html",       -- HTML
        "css",        -- CSS/SCSS
      },
      -- Enable syntax highlighting
      highlight = { enable = true },
      -- Enable auto-indentation
      indent = { enable = true },
    },
  },

  -- ========================================================================== --
  -- GIT: LazyGit - Visual git interface                                      --
  -- ========================================================================== --

  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required utility library
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
  },

  -- ========================================================================== --
  -- TMUX NAVIGATOR: Seamless navigation between Neovim and tmux panes         --
  -- ========================================================================== --

  {
    "christoomey/vim-tmux-navigator",
    -- Only load when these commands are called (lazy loading)
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      -- Ctrl + hjkl to switch between tmux panes and vim splits
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- ========================================================================== --
  -- TELESCOPE: Fuzzy finder for files, text, and more                         --
  -- ========================================================================== --

  {
    "nvim-telescope/telescope.nvim",
    version = "^0.2.0", -- Use latest stable version (0.1.8 was incompatible with modern nvim-treesitter)
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Telescope builtin functions
      local builtin = require("telescope.builtin")

      -- Keybindings for common searches
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep (search text)" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search open buffers (by name)" })
      vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search text in current buffer" })
    end,
  },

  -- ========================================================================== --
  -- TOGGLETERM: Terminal inside Neovim                                       --
  -- ========================================================================== --

  {
    "akinsho/toggleterm.nvim",
    version = "*", -- Use latest version
    config = function()
      require("toggleterm").setup({
        size = 20, -- Terminal height when horizontal
        -- <c-\> opens/closes the terminal
        open_mapping = [[<c-\>]],
        -- Open as floating window (overlay)
        direction = "float",
        -- Rounded border for the floating window
        float_opts = { border = "curved" },
      })
    end,
  },
})
