-- add yours here!
local options = {
  backup = false, -- creates a backup file
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
  expandtab = true, -- convert tabs to spaces
  cursorline = true, -- highlight the current line
  relativenumber = true, -- set relative numbered lines
  number = true,
  scrolloff = 10, -- minimal number of screen lines to keep above and below the cursor
  signcolumn = 'yes', -- the one containing the numbers and changes since last commit and shit to the left
  linebreak = true, -- companion to wrap, don't split words
  showmode = true,
  splitbelow = true,
  splitright = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
