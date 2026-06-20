-- ========================================================================== --
--                          HARP00N CONFIGURATION                             --
-- ========================================================================== --

--[[
  Harpoon saves marks per project (git repository or directory).
  These settings control how marks are saved and displayed.
]]

require("harpoon").setup({
  -- Save marks to file when the quick menu is toggled open/closed
  -- Set to false if you want manual saving with :w
  save_on_toggle = true,

  -- Saves the mark file every time a file is added/removed
  -- Recommended: keeps your marks always up to date
  save_on_change = true,

  -- Sends command to terminal immediately when using sendCommand
  -- Usually false because you want to review before sending
  enter_on_sendcmd = false,

  -- Closes tmux windows created by harpoon when closing Neovim
  -- Set to false if you want tmux terminals to persist
  tmux_autoclose_windows = false,

  -- File types that won't show up in the harpoon menu
  -- Keeps the menu clean from harpoon's own buffers
  excluded_filetypes = {
    "harpoon",
  },

  -- Create marks specific to each git branch
  -- Useful when working on multiple branches
  mark_branch = false,

  -- Show harpoon marks in the tabline (optional, at the top)
  -- Set to true if you want a persistent bar showing your marks
  tabline = false,

  -- Text that appears before/after the marks in tabline
  tabline_prefix = "   ",
  tabline_suffix = "   ",

  -- Menu settings (the popup window when pressing <leader>hh)
  menu = {
    -- Width of the menu relative to the current window
    -- Subtract 4 characters for padding and border
    width = vim.api.nvim_win_get_width(0) - 4,
  },
})
