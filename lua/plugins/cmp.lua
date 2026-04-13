-- ========================================================================== --
--                         CMP - CODE COMPLETION                               --
-- ========================================================================== --

--[[
  nvim-cmp provides code completion with LSP integration.
  It shows suggestions as you type, with fuzzy matching and snippets.
]]

return {
  -- nvim-cmp: Main completion engine
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- LSP completion source
      "hrsh7th/cmp-nvim-lsp",
      -- LuaSnip snippets
      "saadparwaiz1/cmp_luasnip",
      -- Cmdline completion
      "hrsh7th/cmp-cmdline",
      -- Buffer completion (words in current file)
      "hrsh7th/cmp-buffer",
      -- Path completion
      "hrsh7th/cmp-path",
    },
    config = function()
      require("config.cmp")
    end,
  },

  -- LuaSnip: Snippet engine for cmp
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      require("luasnip").setup({
        -- Enable friendly snippet keys (Tab to jump)
        enable_autosnippets = true,
      })
    end,
  },

  -- Friendly snippets collection
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
