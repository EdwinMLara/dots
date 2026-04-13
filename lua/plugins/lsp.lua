-- ========================================================================== --
--                         LSP PLUGINS - Language Server Protocol            --
-- ========================================================================== --

--[[
  LSP (Language Server Protocol) provides:
  - Auto-completion
  - Go-to definition/declaration/references
  - Rename and refactoring
  - Hover documentation
  - Error/warning diagnostics

  These three plugins work together:
  - mason.nvim: Installs LSP servers (like installing packages)
  - mason-lspconfig.nvim: Bridges mason and lspconfig
  - nvim-lspconfig: Configures the LSP servers
]]

return {
  -- mason.nvim: Package manager for LSP servers, linters, formatters
  -- Run :Mason to open the UI and install servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason", -- Only load when the Mason command is called
    config = function()
      require("mason").setup()
    end,
  },

  -- mason-lspconfig.nvim: Auto-configures installed LSP servers
  -- Ensures servers installed via Mason are properly linked to lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Load before opening files
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- List of LSP servers to automatically install
        -- Run :MasonInstallAll to install all at once
        ensure_installed = {
          "lua_ls",      -- Lua (for Neovim config development)
          "ts_ls",       -- TypeScript / JavaScript
          "pyright",     -- Python
          "gopls",       -- Go
          "rust_analyzer", -- Rust
          "clangd",      -- C / C++
          "html",        -- HTML
          "cssls",       -- CSS / SCSS / LESS
          "jsonls",      -- JSON
          "yamlls",      -- YAML
        },
      })
    end,
  },

  -- nvim-lspconfig: Quickstart configurations for LSP servers
  -- Provides the setup() function for each language server
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Bridges mason and lspconfig (auto-links installed servers)
      "williamboman/mason-lspconfig.nvim",
      -- Provides completion capabilities for nvim-cmp integration
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Load main LSP configuration (servers, keymaps, diagnostics)
      require("config.lsp")
    end,
  },
}
