-- ========================================================================== --
--                           NEOVIM INITIALIZATION                            --
-- ========================================================================== --

--[[
  This is the entry point for Neovim configuration.
  Files are loaded in order:

  1. options.lua  - Basic editor settings (numbers, tabs, clipboard, etc.)
  2. lazy.lua    - Plugin manager setup and plugin definitions
  3. keymaps.lua - Custom keyboard shortcuts

  The LSP configuration (lsp.lua) is loaded automatically by lsp.lua plugin.
  The Harpoon configuration (harpoon.lua) is loaded by harpoon plugin.
]]

-- Load basic editor options first
-- (line numbers, tabs, clipboard, etc.)
require("config.options")

-- Load the plugin manager (lazy.nvim) and all plugins
-- This installs and loads all plugins defined in lua/plugins/
require("config.lazy")

-- Load custom keyboard shortcuts
-- (harpoon marks, LSP features, Telescope, etc.)
require("config.keymaps")
