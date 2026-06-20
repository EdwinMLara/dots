-- ========================================================================== --
--                          TOOL PLUGINS - Developer Utilities                --
-- ========================================================================== --

--[[
  This file contains developer tools and utilities:
  - Harpoon: Quick file bookmarking and navigation
  - Telescope: Fuzzy file/text finder
  - Toggleterm: Embedded terminal
  - nvim-cmp: Code completion
  - mini.pairs: Auto-pair brackets
  - indent-blankline: Visual indentation guides
  - gitsigns: Git diff in gutter
  - lualine: Status line
  - which-key: Keybinding hints popup
]]

return {
  -- plenary: Utility library required by many plugins (harpoon, telescope, etc.)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- ========================================================================== --
  -- HARPOON: File bookmarking and navigation                                  --
  -- ========================================================================== --

  {
    "ThePrimeagen/harpoon",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.harpoon")
    end,
  },

  -- ========================================================================== --
  -- MINI.PAIRS: Auto-pair brackets, quotes, etc.                              --
  -- ========================================================================== --

  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      -- Use default config (auto-pairs like (), [], {}, '', "", etc.)
      require("mini.pairs").setup()
    end,
  },

  -- ========================================================================== --
  -- INDENT-BLANKLINE: Visual indentation guides                                --
  -- ========================================================================== --

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        -- Show indentation guides
        indent = {
          char = "│", -- Vertical line character
        },
        -- Only show guides in code blocks (not empty lines)
        scope = {
          show_start = false,
          show_end = false,
        },
      })
    end,
  },

  -- ========================================================================== --
  -- GITSIGNS: Git diff indicators in the gutter                               --
  -- ========================================================================== --

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        -- Show added/modified/deleted indicators
        signs = {
          add = { text = "│" },     -- Green | for added lines
          change = { text = "│" },  -- Blue | for changed lines
          delete = { text = "_" },  -- Red _ for deleted lines
          topdelete = { text = "‾" }, -- Top deletion marker
          changedelete = { text = "~" }, -- Changed deletion marker
        },
        -- Enable by default
        on_attach = function()
          -- Navigation to next/prev git change
          vim.keymap.set("n", "]g", require("gitsigns").next_hunk)
          vim.keymap.set("n", "[g", require("gitsigns").prev_hunk)
        end,
      })
    end,
  },

  -- ========================================================================== --
  -- LUALINE: Status line at the bottom                                        --
  -- ========================================================================== --

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        -- Hide the default statusline
        options = {
          globalstatus = true,
          -- Component configuration
          component_separators = { left = " ", right = " " },
          section_separators = { left = " ", right = " " },
        },
        -- Statusline sections
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "diff" },
          lualine_x = { "diagnostics" },
          lualine_y = { "filetype" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- ========================================================================== --
  -- TOGGLETERM: Embedded terminal in a floating window                          --
  -- ========================================================================== --

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Open terminal as a floating window (appears on top of the editor)
        float_opts = {
          border = "curved", -- Rounded border style
          width = function()
            return math.floor(vim.o.columns * 0.8) -- 80% of editor width
          end,
          height = function()
            return math.floor(vim.o.lines * 0.7) -- 70% of editor height
          end,
        },
        -- Start terminal in insert mode automatically
        start_in_insert = true,
      })
    end,
  },

  -- ========================================================================== --
  -- WHICH-KEY: Popup showing available keybindings                           --
  -- ========================================================================== --

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        -- Delay before popup appears (milliseconds)
        delay = 300,
        -- Show description with keybinding
        show_keys = true,
      })
    end,
  },
}
