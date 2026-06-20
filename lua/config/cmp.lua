-- ========================================================================== --
--                         CMP CONFIGURATION - Code Completion                --
-- ========================================================================== --

--[[
  nvim-cmp configuration for code completion.
  Provides auto-completion suggestions from LSP, buffers, and snippets.

  Key concepts:
  - Sources: Where completion comes from (LSP, buffer, snippets)
  - Mappings: Keys to navigate/select completions
  - Formatting: How completions are displayed
]]

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Setup LuaSnip first
luasnip.config.set_config({
  -- Enable Tab to jump to next snippet placeholder
  store_selection_keys = "<Tab>",
})

-- ========================================================================== --
-- CMP SETUP                                                                 --
-- ========================================================================== --

cmp.setup({
  -- Enable completion in all buffers
  enabled = function()
    -- Disable in command mode
    local in_prompt = vim.api.nvim_get_option_value("buftype", {}) == "prompt"
    if in_prompt then
      return false
    end
    -- Enable completion globally
    return true
  end,

  -- Snippet engine (LuaSnip)
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Sources for completion (in priority order)
  sources = {
    -- LSP completion (most important)
    {
      name = "nvim_lsp",
      -- Filter which LSP items to show
      filter = function(entry, ctx)
        local kind = entry:get_completion_item().kind
        -- Hide snippets from LSP (we have LuaSnip for that)
        if kind and kind == "Snippet" then
          return false
        end
        return true
      end,
    },
    -- LuaSnip snippets
    { name = "luasnip" },
    -- Buffer words (words in current file)
    { name = "buffer" },
    -- File paths
    { name = "path" },
  },

  -- How completion menu appears
  window = {
    -- Completion menu
    completion = {
      -- Add border around completion popup
      border = "rounded",
      -- Scrollbar
      scrollbar = "║",
    },
    -- Documentation popup (when hovering completion)
    documentation = {
      border = "rounded",
    },
  },

  -- Keybindings for completion menu
  mapping = {
    -- Select previous/next completion
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),

    -- Scroll documentation
    ["<c-p>"] = cmp.mapping.scroll_docs(-4),
    ["<c-n>"] = cmp.mapping.scroll_docs(4),

    -- Open/close completion menu
    ["<c-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping.confirm({
      -- Automatically confirm top selection
      select = true,
    }),

    -- Snippet expansion (Tab to expand snippet)
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- If popup is visible, navigate
      if cmp.visible() then
        cmp.select_next_item()
      -- If in a snippet, jump to next placeholder
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<s-Tab>"] = cmp.mapping(function(fallback)
      -- If popup is visible, navigate back
      if cmp.visible() then
        cmp.select_prev_item()
      -- If in a snippet, jump to previous placeholder
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  -- Formatting of completion items
  formatting = {
    -- Fields to show: kind, menu, detail
    fields = { "kind", "abbr", "menu" },
    -- Format function (adds icons)
    format = function(_, vim_item)
      -- Add kind icon
      local icons = {
        Text = "󰦃",
        Method = "󰆧",
        Function = "󰆧",
        Constructor = "󰆧",
        Field = "󰜢",
        Variable = "󰀔",
        Class = "󰠱",
        Interface = "󰜢",
        Module = "󰆧",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "󰕳",
        Keyword = "󰌋",
        Snippet = "󰍉",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰕳",
        Folder = "󰉋",
        EnumMember = "󰕳",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "󰕳",
        Operator = "󰆧",
        TypeParameter = "󰅲",
      }
      -- Set icon from kind
      vim_item.kind = icons[vim_item.kind] or ""
      return vim_item
    end,
  },
})

-- ========================================================================== --
-- CMDLINE COMPLETION (for :commands)                                         --
-- ========================================================================== --

cmp.setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
    { name = "path" },
  },
})

-- ========================================================================== --
-- SEARCH COMPLETION (for / and ?)                                           --
-- ========================================================================== --

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
