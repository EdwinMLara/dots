-- ========================================================================== --
--                             KEYBOARD SHORTCUTS (KEYMAPS)                   --
-- ========================================================================== --

--[[
  This file defines custom keyboard shortcuts.
  Key concepts:
  - <leader>: The leader key (set to Space in options.lua)
  - <c-?>: Ctrl + key (e.g., <c-h> is Ctrl+h)
  - n, v, i, t: Normal, Visual, Insert, Terminal modes
  - silent: Don't show the command in the status bar
  - buffer: Apply only to the current buffer
]]

local keymap = vim.keymap

-- ========================================================================== --
-- GENERAL KEYMAPS                                                           --
-- ========================================================================== --

-- Open floating terminal with Space + t
keymap.set(
  "n",
  "<leader>t",
  ":ToggleTerm<CR>",
  { desc = "Open floating terminal" }
)

-- Open the built-in file explorer (Netrw)
keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Open file explorer" })

-- ========================================================================== --
-- COMMENT KEYMAPS - Toggle comments                                         --
-- ========================================================================== --

--[[
  Neovim has built-in comment toggling (since 0.10):
  - gcc : Toggle comment on current line (normal mode)
  - gc  : Toggle comment on selected lines (visual mode)

  Extra convenience mappings using the leader key:
  - <leader>/ in normal mode: toggle comment on current line
  - <leader>/ in visual mode: toggle comment on the selection
]]

-- Toggle comment on current line
keymap.set("n", "<leader>/", function()
  vim.cmd("normal! gcc")
end, { desc = "Toggle comment on line" })

-- Toggle comment on selected lines
keymap.set("v", "<leader>/", function()
  vim.cmd("normal! gc")
end, { desc = "Toggle comment on selection" })

-- ========================================================================== --
-- SAVE AND QUIT KEYMAPS                                                     --
-- ========================================================================== --

-- Quick save - write current file
keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save file" })

-- Save and quit
keymap.set("n", "<leader>wq", ":write<CR>:quit<CR>", { desc = "Save and quit" })
keymap.set("n", "<leader>qa", ":quitall<CR>", { desc = "Quit all" })
keymap.set("n", "<leader>qwa", ":write<CR>:quitall<CR>", { desc = "Save and quit all" })

-- Force quit (discard changes)
keymap.set("n", "<leader>q!", ":quit!<CR>", { desc = "Force quit (discard changes)" })

-- ========================================================================== --
-- SPLIT WINDOW KEYMAPS                                                      --
-- ========================================================================== --

-- Create horizontal split (side by side vertically)
keymap.set("n", "<leader>h", ":split<CR>", { desc = "Horizontal split" })

-- Create vertical split (stacked horizontally)
keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })

-- Close current split
keymap.set("n", "<leader>c", ":close<CR>", { desc = "Close split" })

-- ========================================================================== --
-- HARP00N KEYMAPS - Quick file navigation                                   --
-- ========================================================================== --

--[[
  Harpoon lets you mark files and jump to them quickly.
  Think of it as bookmarking your most-used files.

  Default keybindings:
  - <leader>a  : Mark current file (add to harpoon)
  - <leader>hh: Open the harpoon menu (see all marked files)
  - <leader>1-4: Jump directly to mark 1-4
  - <leader>n : Jump to next mark
  - <leader>p : Jump to previous mark

  From the menu:
  - Enter: Jump to selected file
  - d: Remove mark
  - <c-d>: Remove mark
  - <c-v>: Open in vertical split
  - <c-x>: Open in horizontal split
  - <c-t>: Open in new tab
  - q/Esc: Close menu
]]

-- Mark the current file for quick access
keymap.set(
  "n",
  "<leader>a",
  require("harpoon.mark").add_file,
  { desc = "Mark file for harpoon" }
)

-- Open harpoon menu showing all marked files
keymap.set(
  "n",
  "<leader>hh",
  require("harpoon.ui").toggle_quick_menu,
  { desc = "Open harpoon menu" }
)

-- Jump directly to specific marks (1-4)
keymap.set(
  "n",
  "<leader>1",
  function() require("harpoon.ui").nav_file(1) end,
  { desc = "Harpoon: Jump to mark 1" }
)
keymap.set(
  "n",
  "<leader>2",
  function() require("harpoon.ui").nav_file(2) end,
  { desc = "Harpoon: Jump to mark 2" }
)
keymap.set(
  "n",
  "<leader>3",
  function() require("harpoon.ui").nav_file(3) end,
  { desc = "Harpoon: Jump to mark 3" }
)
keymap.set(
  "n",
  "<leader>4",
  function() require("harpoon.ui").nav_file(4) end,
  { desc = "Harpoon: Jump to mark 4" }
)

-- Navigate to next/previous mark in the list
keymap.set(
  "n",
  "<leader>n",
  require("harpoon.ui").nav_next,
  { desc = "Harpoon: Next mark" }
)
keymap.set(
  "n",
  "<leader>p",
  require("harpoon.ui").nav_prev,
  { desc = "Harpoon: Previous mark" }
)

-- ========================================================================== --
-- LSP KEYMAPS - Language Server features                                     --
-- ========================================================================== --

--[[
  These keybindings only work when an LSP server is attached to a buffer.
  They provide code intelligence features like:
  - gd: Go to definition
  - K: Show hover documentation
  - <leader>rn: Rename symbol
  - etc.

  The function is called when an LSP attaches, so keymaps are buffer-local.
]]

local function lspattach(bufnr)
  -- Silent: don't echo commands, buffer: only this buffer
  local opts = { buffer = bufnr, silent = true }

  -- Go to definition/declaration/implementation/references
  keymap.set("n", "gd", vim.lsp.buf.definition, opts)      -- Definition
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts)      -- Declaration
  keymap.set("n", "gr", vim.lsp.buf.references, opts)       -- References
  keymap.set("n", "gi", vim.lsp.buf.implementation, opts)  -- Implementation

  -- Documentation and hints
  keymap.set("n", "K", vim.lsp.buf.hover, opts)                   -- Hover docs
  keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)  -- Function signature

  -- Code actions
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)   -- Rename symbol
  keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions

  -- Diagnostics navigation
  keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)       -- Previous error
  keymap.set("n", "]d", vim.diagnostic.goto_next, opts)       -- Next error
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Show error float
  keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts) -- Location list
end

-- Export lspattach so lsp.lua can require() it
return { lspattach = lspattach }
