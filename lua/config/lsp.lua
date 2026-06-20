-- ========================================================================== --
--                         LSP SERVER CONFIGURATION                           --
-- ========================================================================== --

--[[
  This file configures LSP servers and sets up diagnostic display.
  Uses Neovim 0.11+ native vim.lsp.config() API.

  Key concepts:
  - vim.lsp.config("*") : Applies settings to ALL servers
  - vim.lsp.config("server_name") : Applies settings to specific server
  - vim.lsp.enable("server_name", true) : Enables a server to start automatically
]]

-- ========================================================================== --
-- DIAGNOSTICS: Configure how errors/warnings appear in the editor         --
-- ========================================================================== --

vim.lsp.config("*", {
  -- Diagnostics are the red squiggly lines under errors
  diagnostics = {
    -- Show underline under problematic code
    underline = true,
    -- Update diagnostics while typing (set to true for instant feedback)
    update_in_insert = false,
    -- Show virtual text (characters after the line)
    virtual_text = {
      spacing = 4, -- Space between text and line
      source = "if_many", -- Show source if multiple servers report it
      prefix = "●", -- Character shown before the message
    },
    -- Minimum severity to display (WARN and above)
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
    -- Show signs in the sign column (✘ for error, ⚠ for warn, etc.)
    signs = true,
  },

  -- Capabilities for completion (used by nvim-cmp when added)
  -- This tells the LSP what features Neovim supports
  capabilities = require("cmp_nvim_lsp").default_capabilities(),

  -- Called when an LSP server attaches to a buffer
  -- Sets up keybindings for that buffer only
  on_attach = function(client, bufnr)
    require("config.keymaps").lspattach(bufnr)
  end,
})

-- ========================================================================== --
-- LUA LANGUAGE SERVER: For Neovim config development                        --
-- ========================================================================== --

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      -- Use LuaJIT (what Neovim uses internally)
      runtime = { version = "LuaJIT" },
      -- Tell Lua that 'vim' is a global variable (Neovim API)
      diagnostics = {
        globals = { "vim" },
      },
      -- Make Neovim's API available for autocomplete in Lua files
      workspace = {
        library = vim.fn.has("nvim-0.10") == 1 and {
          "${3rd}/luv/library",      -- LuaJIT's uv bindings
          "${3rd}/busted/library",   -- Testing framework
          "${3rd}/luassert/library", -- Assertion library
        } or nil,
        -- Don't ask about third-party plugins
        checkThirdParty = false,
      },
      -- Disable telemetry (no usage data sent)
      telemetry = { enable = false },
    },
  },
})

-- ========================================================================== --
-- TYPECRIPT/JAVASCRIPT LANGUAGE SERVER                                       --
-- ========================================================================== --

vim.lsp.config("ts_ls", {
  settings = {
    -- Inlay hints show type information inline in code
    -- e.g., function(param: string) instead of just function(param)
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
  -- Don't auto-format on save (let Prettier/Eslint handle it)
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    require("config.keymaps").lspattach(bufnr)
  end,
})

-- ========================================================================== --
-- ENABLE SERVERS: Start these LSP servers automatically                    --
-- ========================================================================== --

-- These servers will start automatically when you open a file of that type
-- No need to manually start them
vim.lsp.enable("lua_ls", true)
vim.lsp.enable("ts_ls", true)
vim.lsp.enable("pyright", true)
vim.lsp.enable("gopls", true)
vim.lsp.enable("rust_analyzer", true)
vim.lsp.enable("clangd", true)
vim.lsp.enable("html", true)
vim.lsp.enable("cssls", true)
vim.lsp.enable("jsonls", true)
vim.lsp.enable("yamlls", true)
