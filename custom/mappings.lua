---@type MappingsTable
local M = {}
-- Toggle mouse function
function toggle_mouse()
  if vim.o.mouse == 'a' then
      -- Disable mouse support
      vim.o.mouse = ''
      -- Close NvimTree if it's open
      vim.cmd('NvimTreeClose')
      -- Disable line numbers
      vim.wo.number = false
      vim.wo.relativenumber = false
  else
      -- Enable mouse support
      vim.o.mouse = 'a'
      -- Close NvimTree if it's open
      vim.cmd('NvimTreeOpen')
      -- Enable line numbers
      vim.wo.number = true
      vim.wo.relativenumber = true
  end
end



M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    -- ["<leader>fm"] = { function() require("conform").format() end, "formatting",},
    ["<C-W><Left>"] = { "<cmd>vertical resize -10<CR>", "Shrink window horizontally" },
    ["<C-W><Right>"] = { "<cmd>vertical resize +10<CR>", "Expand window horizontally" },
    ["<C-W><Up>"] = { "<cmd>resize +10<CR>", "Expand window vertically" },
    ["<C-W><Down>"] = { "<cmd>resize -10<CR>", "Shrink window vertically" },
    ["<F2>"] = { "<cmd>lua toggle_mouse()<CR>", "Toggle mouse support" },
    ["<A-Up>"] = { ":m .-2<CR>==", "Move line up" },
    ["<A-Down>"] = { ":m .+1<CR>==", "Move line down" },
    ["<C-Z>"] = { "u", "Undo" },
    ["<C-Y>"] = { "<C-R>", "Redo" },
    ["<Leader>fg"] = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Telescope live grep" },
    ["<Leader>fm"] = { "<cmd>lua require('conform').format()<CR>", "Format File" },
    ["<leader>o"] = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" },

  },
  i = {  -- Insert mode mappings
    ["<C-Z>"] = { "<C-O>u", "Undo" },
    ["<C-Y>"] = { "<C-O>:redo<CR>", "Redo" },
  },
  v = {
    ["<Leader>fm"] = { "<cmd>lua vim.lsp.buf.format()<CR>", "Range Format File" }, 
    ["<Tab>"] = { ">gv", "indent"},
    ["<S-Tab>"] = { "<gv", "reverse indent"},
    ["<A-Up>"] = { ":move '<-2<CR>gv-gv", "Move text up" },
    ["<A-Down>"] = { ":move '>+1<CR>gv-gv", "Move text down" },
    ["<C-A-Up>"] = { ":'<,'>y<CR>:'<-1pu<CR>gv=gv", "Copy text up" },
    ["<C-A-Down>"] = { ":'<,'>y<CR>:pu!<CR>gv=gv", "Copy text down" },
  },
}

-- more keybinds!

return M
