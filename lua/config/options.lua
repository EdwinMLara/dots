-- ========================================================================== --
--                              BASIC EDITOR OPTIONS                          --
-- ========================================================================== --

--[[
  Neovim configuration for fundamental editor behavior.
  These settings affect how the editor looks and behaves.
]]

local opt = vim.opt

-- ========================================================================== --
-- LINE NUMBERS: Show line numbers and relative numbers                      --
-- ========================================================================== --

-- Show absolute line number for current line
-- (Line 1, 2, 3... at the start of each line)
opt.number = true

-- Show relative line numbers for all other lines
-- (Makes it easy to see how many lines to jump with 5j, 10k, etc.)
opt.relativenumber = true

-- ========================================================================== --
-- MOUSE: Enable mouse interaction                                           --
-- ========================================================================== --

-- "a" means all modes - enables mouse for:
-- - Normal mode: Click to move cursor
-- - Visual mode: Click and drag to select
-- - Insert mode: Click to move cursor
opt.mouse = "a"

-- ========================================================================== --
-- CLIPBOARD: System clipboard integration                                    --
-- ========================================================================== --

-- unnamedplus: Use system clipboard for yank/paste
-- On macOS this uses pbcopy/pbpaste automatically
-- Now you can yank in Neovim and paste in other apps
opt.clipboard = "unnamedplus"

-- ========================================================================== --
-- TABS AND INDENTATION: Configure spacing                                    --
-- ========================================================================== --

-- Tab key produces 2 spaces (for display)
opt.tabstop = 2

-- Auto-indent uses 2 spaces
opt.shiftwidth = 2

-- Convert tabs to spaces (recommended for most projects)
opt.expandtab = true

-- ========================================================================== --
-- SEARCH: Smart case handling                                                --
-- ========================================================================== --

-- Ignore case when searching (so "hello" matches "Hello", "HELLO", etc.)
opt.ignorecase = true

-- But if you type an uppercase letter, become case-sensitive
-- (so "Hello" only matches "Hello", not "hello")
opt.smartcase = true

-- ========================================================================== --
-- LEADER KEY: The prefix for custom keybindings                              --
-- ========================================================================== --

-- Space is the most common leader key (easy to reach with thumb)
vim.g.mapleader = " "

-- ========================================================================== --
-- DIAGNOSTICS: Error and warning display                                     --
-- ========================================================================== --

-- Always show the sign column (prevents layout shift when errors appear)
opt.signcolumn = "yes"

-- Configure diagnostic signs (shown in the sign column)
-- These symbols appear next to lines with errors/warnings
vim.diagnostic.config({
  signs = {
    text = {
      -- ✘ = Error (red)
      [vim.diagnostic.severity.ERROR] = "✘",
      -- ⚠ = Warning (yellow)
      [vim.diagnostic.severity.WARN] = "⚠",
      -- ➤ = Hint (blue/green)
      [vim.diagnostic.severity.HINT] = "➤",
      -- ℹ = Information (blue)
      [vim.diagnostic.severity.INFO] = "ℹ",
    },
  },
})

-- ========================================================================== --
-- COLORS: True color support (24-bit)                                         --
-- ========================================================================== --

-- Enable true colors in terminal (required for modern themes)
-- This makes colors look correct in tmux and terminal emulators
opt.termguicolors = true

-- ========================================================================== --
-- PERFORMANCE: Speed and responsiveness                                       --
-- ========================================================================== --

-- Milliseconds to wait before triggering events
-- Lower = faster but more CPU usage
-- 300-400 is a good balance for most users
opt.updatetime = 300

-- Keep cursor centered vertically while scrolling
-- Shows context above and below while moving through code
opt.scrolloff = 8

-- Keep cursor centered horizontally in split windows
opt.sidescrolloff = 8

-- ========================================================================== --
-- BUFFERS: Buffer management                                                  --
-- ========================================================================== --

-- Allow switching to unsaved buffers without saving first
-- Enables :bnext/:bprev even with unsaved changes
opt.hidden = true

-- ========================================================================== --
-- EDITING: Smart editing options                                             --
-- ========================================================================== --

-- Enable automatic wrapping at textwidth (for comments, etc.)
opt.textwidth = 80

-- ========================================================================== --
-- SPELL CHECK: Spelling suggestions                                          --
-- ========================================================================== --

-- Enable spell checking
-- Useful for writing documentation, commit messages, markdown
opt.spell = true

-- Language for spell checking (US English)
opt.spelllang = { "en_us" }
