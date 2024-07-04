local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<leader>q', '<cmd>close<cr>', opts)
map('n', '<leader>v', '<cmd>vsplit<cr>', opts)
map('n', '<leader>h', '<cmd>split<cr>', opts)

-- Resize with arrows
map('n', '<C-Up>', ':resize +2<CR>', opts)
map('n', '<C-Down>', ':resize -2<CR>', opts)
map('n', '<C-Left>', ':vertical resize +2<CR>', opts)
map('n', '<C-Right>', ':vertical resize -2<CR>', opts)

--- Visual Block --
-- Move text up and down
map('x', 'J', ":m '>+1<CR>gv=gv", opts)
map('x', 'K', ":m '<-2<CR>gv=gv", opts)
map('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- diagnostics and stuff
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- disable arrows
vim.keymap.set('n', '<left>', '<cmd>echo "use h to move!!"<cr>')
vim.keymap.set('n', '<right>', '<cmd>echo "use l to move!!"<cr>')
vim.keymap.set('n', '<up>', '<cmd>echo "use k to move!!"<cr>')
vim.keymap.set('n', '<down>', '<cmd>echo "use j to move!!"<cr>')
