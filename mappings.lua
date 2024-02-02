---@type MappingsTable

local M = {}
local opts = {}
-- Toggle mouse function
function TOGGLE_MOUSE()
  if vim.o.mouse == 'a' then
    -- Disable mouse support
    vim.o.mouse = ''
    -- Close NvimTree if it's open
    vim.cmd('NvimTreeClose')
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    -- Enable mouse support
    vim.o.mouse = 'a'
    -- Enable line numbers
    vim.wo.number = true
    vim.wo.relativenumber = false
    -- Close NvimTree if it's open
    vim.cmd('NvimTreeOpen')
  end
end

function TOGGLE_GIT()
  local neogit = require('neogit')
  -- Check if NeoGit is active
  if neogit.status.started then
    -- Close NeoGit and Symbols Outline if NeoGit is open
    neogit.close()
  else
    neogit.open({ kind = 'split' })
  end
end


function TOGGLE_SYMBOLES()
  local aerial = require('aerial')
  -- Check if NeoGit is active
  if aerial.is_open() then
    -- Close NeoGit and Symbols Outline if NeoGit is open
    aerial.close_all()
  else
    aerial.open_all()
  end
end

function TOGGLE_GIT_SYMBOLES()

  local aerial = require('aerial')
  local neogit = require('neogit')
  if aerial.is_open() then
    aerial.close_all()
    neogit.close()
  else
    aerial.open_all()
    vim.cmd('wincmd l')
    neogit.open({ kind = 'split' })
  end
end

-- Your custom function to highlight the selected word in Normal Mode
function Highlight_selected_word()
  local current_word = vim.fn.expand("<cword>")
  -- Escape special characters in the word
  current_word = vim.fn.escape(current_word, "/\\")
  -- Set the search pattern to the escaped current word
  vim.fn.setreg('/', '\\V' .. current_word)
  vim.cmd('set hlsearch')
  -- Move to the next occurrence
  vim.cmd('normal! n')
end

function OpenSpectreWithQuickfix()
  -- Open Spectre
  require('spectre').open_file_search({ select_word = true })

  -- Open a horizontal split for the quickfix window
  -- Adjust '10' to change the height of the quickfix window
  -- Use 'vsplit' instead of 'split' for a vertical split
  vim.cmd('hor copen')
end

function Get_visual_selection()
  vim.cmd("noau normal! \"vy\"")
  local text = vim.fn.getreg('v')
  -- Remove newlines and escape special characters for grep
  text = text:gsub("\n", ""):gsub("[-[%]{}()*+?.,\\^$|#\\s]", "\\%&")
  return text
end

function Live_grep_current_buffers()
  require('telescope.builtin').live_grep({
    prompt_title = 'Live Grep Current Buffers',
    prompt_prefix = 'Search: ',
    preview_title = 'Preview',
    grep_open_files = true,
    results_title = 'Results',
    layout_strategy = 'vertical',
    layout_config = {
      preview_width = 0.5,
    },
  })
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- Normal mode mappings for window management
    ["<C-W><Left>"] = { "<cmd>vertical resize -10<CR>", "Shrink window horizontally", opts },
    ["<C-W><Right>"] = { "<cmd>vertical resize +10<CR>", "Expand window horizontally", opts },
    ["<C-W><Up>"] = { "<cmd>resize +10<CR>", "Expand window vertically", opts },
    ["<C-W><Down>"] = { "<cmd>resize -10<CR>", "Shrink window vertically", opts },

    -- Normal mode mappings for text manipulation
    ["<A-Up>"] = { ":m .-2<CR>==", "Move line up", opts },
    ["<A-Down>"] = { ":m .+1<CR>==", "Move line down", opts },

    -- Normal mode mappings for clipboard management
    ["<C-v>"] = { '"+p', "Paste from clipboard", opts },
    ["<C-q>"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Switch between source and header" , opts},

    -- Delete last character without cutting in normal mode
    ["<BS>"] = { 'h""x', "Delete back character in normal mode", opts },
    ["<Delete>"] = { '""x', "Delete back character in Visual mode", opts },
    ["<C-a>"] = { "ggVG", "Select all in normal mode", opts },
    ["<A-a>"] = { "V", "Select current line in Normal mode", opts },

    -- Normal mode mappings for undo and redo
    ["<C-Z>"] = { "u", "Undo", opts },
    ["<C-Y>"] = { "<C-R>", "Redo", opts },

    -- Normal mode mappings for lsp formatting
    ["<A-f>"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting", opts
    },

    -- Normal mode mappings for toggling UI elements
    ["<F2>"] = { "<cmd>lua TOGGLE_MOUSE()<CR>", "Toggle mouse support", opts },
    ["<leader>o"] = { "<cmd>lua TOGGLE_GIT_SYMBOLES()<CR>", "Symbols & git Outline", opts },
    ["<leader>gs"] = { "<cmd>lua TOGGLE_SYMBOLES()<CR>", "Symbols Outline", opts },
    ["<leader>gg"] = { "<cmd>lua TOGGLE_GIT()<CR>", "Git Outline", opts },

    -- Normal mode mappings for search and replace
    ["<C-S-h>"] = { "<cmd>lua require('spectre').toggle()<CR>", "Toggle Spectre", opts },
    ["<C-h>"] = { "<cmd>lua OpenSpectreWithQuickfix()<CR>", "Search on current file", opts },

    -- Normal mode mappings for debugging
    ["<S-F5>"] = { "<cmd>lua require('dap').reverse_continue()<CR>", "Reverse !!", opts },
    ["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "Continue / Start", opts },
    ["<F6>"] = { "<cmd>lua require('dap').run_last()<CR>", "Run Last", opts },
    ["<F7>"] = { "<cmd>lua require('dap').down()<CR>", "Go down stack", opts },
    ["<F8>"] = { "<cmd>lua require('dap').up()<CR>", "Go up stack", opts },
    ["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint", opts },
    ["<F10>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step Over", opts },
    ["<S-F10>"] = { "<cmd>lua require('dap').goto_()<CR>", "Go to line", opts },
    ["<A-F10>"] = { "<cmd>lua require('dap').run_to_cursor()<CR>", "Go to line ignore breakpoints", opts },
    ["<F11>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step Into", opts },
    ["<S-F11>"] = { "<cmd>lua require('dap').step_out()<CR>", "Step Out", opts },
    ["<F12>"] = { "<cmd>lua require('dap').repl.open()<CR>", "Open REPL", opts },

    -- Normal mode mappings for diff management
    ["<C-3>"] = { "]c", "Jump to next diff", opts },
    ["<C-1>"] = { "[c", "Jump to previous diff", opts },
    ["<A-Right>"] = { "<cmd>diffget<CR>", "Get change from other buffer", opts },
    ["<A-Left>"] = { "<cmd>diffput<CR>", "Put change to the other buffer", opts },


  },
  i = { -- Insert mode mappings
    ["<C-a>"] = { "<Esc>ggVG", "Select all in Insert mode", opts },
    -- Insert mode mappings for undo, redo, and save
    ["<C-Z>"] = { "<C-O>u", "Undo", opts },
    ["<C-Y>"] = { "<C-O>:redo<CR>", "Redo", opts },
    ["<C-S>"] = { "<Esc>:w<CR>a", "Save in insert mode", opts },

    -- Insert mode mappings for clipboard management
    ["<C-c>"] = { "<C-O>\"+y", "Copy in insert mode", opts },
    ["<C-x>"] = { "<C-O>\"+x", "Cut in insert mode", opts },
    ["<C-v>"] = { "<C-R>+", "Paste in insert mode", opts },
    ["<A-a>"] = { "<Esc>V", "Select current line in Normal mode", opts },
  },

  v = {
    -- Visual mode mappings for text manipulation
    ["<Tab>"] = { ">gv", "indent", opts },
    ["<S-Tab>"] = { "<gv", "reverse indent", opts },
    ["<A-Up>"] = { ":move '<-2<CR>gv-gv", "Move text up", opts },
    ["<A-Down>"] = { ":move '>+1<CR>gv-gv", "Move text down", opts },
    ["<C-A-Up>"] = { ":'<,'>y<CR>:'<-1pu<CR>gv=gv", "Copy text up", opts },
    ["<C-A-Down>"] = { ":'<,'>y<CR>:pu!<CR>gv=gv", "Copy text down", opts },

    -- Visual mode mappings for clipboard management
    ["<C-c>"] = { '"+y', "Copy to clipboard", opts },
    ["<C-x>"] = { '"+x', "Cut to clipboard", opts },
    ["<C-v>"] = { '""x"+p', "Paste from clipboard and replace selection", opts },
    ["<C-Z>"] = { "<C-O>u", "Undo",opts },
    ["<C-Y>"] = { "<C-O>:redo<CR>", "Redo" ,opts},
    ["<A-a>"] = { "V", "Select current line in Normal mode", opts },
    ["<C-a>"] = { "ggVG", "Select all in visual mode", opts },

    -- Visual mode mappings for lsp formatting
    ["<A-f>"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting", opts
    },

    -- Visual mode mappings for diff management
    ["<A-Right>"] = { "<cmd>diffget<CR>", "Get change from other buffer", opts },
    ["<A-Left>"] = { "<cmd>diffput<CR>", "Put change to the other buffer", opts },

    -- Delete selection without cutting in Visual mode
    ["<BS>"] = { '""x', "Delete back character in Visual mode", opts },
    ["<Delete>"] = { '""x', "Delete back character in Visual mode", opts },

    -- Spectre

    ["<C-h>"] = { "<esc><cmd>lua require('spectre').open_visual()<CR>", "Search current word" },
  },
  t = {
    -- Terminal mode mappings for clipboard management
    ["<C-v>"] = { "<C-\\><C-N>\"+pa", "Paste from clipboard and stay in insert mode", opts },
  },
}


M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<C-r>"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },


    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}


M.telescope = {
  plugin = true,

  n = {
    -- find

    ["<leader>p"] = { "<cmd>lua require('telescope').extensions.projects.projects{}<CR>", "Find all", opts },
    ["<C-p>"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all", opts },
    ["<C-A-f>"] = { "<cmd> Telescope live_grep <CR>", "Live grep", opts },
    ["<A-p>"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles", opts },
    ["<C-f>"] = { ":lua Live_grep_current_buffers()<CR>", "Highlight selected word in Normal Mode", opts },

  },
  v = {
    ["<C-f>"] = { "<cmd>lua Highlight_selected_word() <CR>", "Find buffers", opts },

  },
}


M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

  },

  v = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}
-- more keybinds!

return M
