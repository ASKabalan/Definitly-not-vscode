-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.api.nvim_set_keymap('n', '<C-W><Left>', '<cmd>vertical resize -10<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-W><Right>', '<cmd>vertical resize +10<CR>', {noremap = true, silent = true})
--
-- Resize window vertically by 5 rows
vim.api.nvim_set_keymap('n', '<C-W><Up>', '<cmd>resize +10<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-W><Down>', '<cmd>resize -10<CR>', {noremap = true, silent = true})

local mouse_enabled = true

function toggle_mouse()
    if mouse_enabled then
        vim.opt.mouse = ''
        mouse_enabled = false
    else
        vim.opt.mouse = 'a'
        mouse_enabled = true
    end
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<F2>', '<cmd>lua toggle_mouse()<CR>', opts)
map('n', '<A-Up>', ':m .-2<CR>==', opts)
map('n', '<A-Down>', ':m .+1<CR>==', opts)
map('x', '<A-Up>', ":move '<-2<CR>gv-gv", opts)
map('x', '<A-Down>', ":move '>+1<CR>gv-gv", opts)
map('x', '<C-A-Up>', ":'<,'>y<CR>:'<-1pu<CR>gv=gv", opts)
map('x', '<C-A-Down>', ":'<,'>y<CR>:pu!<CR>gv=gv", opts)
-- Set Ctrl+Z to undo in normal mode
map('n', '<C-Z>', 'u', opts)
-- Set Ctrl+Z to undo in insert mode
map('i', '<C-Z>', '<C-O>u', opts)
-- Set Ctrl+Y to redo in normal mode
map('n', '<C-Y>', '<C-R>', opts)
-- Set Ctrl+Y to redo in insert mode
map('i', '<C-Y>', '<C-O>:redo<CR>', opts)