---@type MappingsTable

local M = {}
local opts = {}
-- Toggle mouse function
function TOGGLE_MOUSE()
  if vim.o.mouse == 'a' then
      local nvim_tree_view = require('nvim-tree.view')
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
      vim.wo.relativenumber = true
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


M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = {  nowait = true } },

    --  format with conform
    -- ["<leader>fm"] = { function() require("conform").format() end, "formatting",},
    ["<C-W><Left>"] = { "<cmd>vertical resize -10<CR>", "Shrink window horizontally" , opts},
    ["<C-W><Right>"] = { "<cmd>vertical resize +10<CR>", "Expand window horizontally" , opts},
    ["<C-W><Up>"] = { "<cmd>resize +10<CR>", "Expand window vertically" , opts},
    ["<C-W><Down>"] = { "<cmd>resize -10<CR>", "Shrink window vertically" , opts},

    ["<F2>"] = { "<cmd>lua TOGGLE_MOUSE()<CR>", "Toggle mouse support" , opts},

    ["<A-Up>"] = { ":m .-2<CR>==", "Move line up" , opts},
    ["<A-Down>"] = { ":m .+1<CR>==", "Move line down" , opts},

    ["<C-Z>"] = { "u", "Undo" , opts},
    ["<C-Y>"] = { "<C-R>", "Redo" , opts},

    ["<A-f>"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting", opts
    },

    ["<leader>o"] = { "<cmd>lua TOGGLE_GIT_SYMBOLES()<CR>", "Symbols & git Outline " , opts},
    ["<leader>gs"] = { "<cmd>lua TOGGLE_SYMBOLES()<CR>", "Symbols Outline " , opts},
    ["<leader>gg"] = { "<cmd>lua TOGGLE_GIT()<CR>", "Symbols Outline " , opts},

    ["<C-v>"] = { '"+p', "Paste from clipboard" , opts},
    ["<C-q>"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Switch between source and header" , opts},

    ["<BS>"] = { 'hx', "Backspace delete" , opts},

    -- spectre
    ["<C-S-h>"] = { "<cmd>lua require('spectre').toggle()<CR>", "Toggle Spectre" },
    ["<C-h>"] = { "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", "Search on current file" },

    -- Set a breakpoint with F9
    ["<S-F5>"] = { "<cmd>lua require('dap').reverse_continue()<CR>", "Reverse !!" },
    ["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "Continue / Start" },
    ["<F6>"] = { "<cmd>lua require('dap').run_last()<CR>", "Run Last" },

    ["<F7>"] = { "<cmd>lua require('dap').down()<CR>", "Go down stack" },
    ["<F8>"] = { "<cmd>lua require('dap').up()<CR>", "Go up stack" },

    ["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    -- Step over with F10
    ["<F10>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
    ["<S-F10>"] = { "<cmd>lua require('dap').goto_()<CR>", "Go to line" },
    ["<A-F10>"] = { "<cmd>lua require('dap').run_to_cursor()<CR>", "Go to line ignore breakpoints" },
    -- Step into with F11
    ["<F11>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
    ["<S-F11>"] = { "<cmd>lua require('dap').step_out()<CR>", "Open REPL" },
    -- Open REPL with F12
    ["<F12>"] = { "<cmd>lua require('dap').repl.open()<CR>", "Open REPL" },

    
  },
  i = {  -- Insert mode mappings
    ["<C-Z>"] = { "<C-O>u", "Undo",opts },
    ["<C-Y>"] = { "<C-O>:redo<CR>", "Redo" ,opts},
  },
  v = {
    ["<A-f>"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting", opts
    },

    ["<Tab>"] = { ">gv", "indent",opts},
    ["<S-Tab>"] = { "<gv", "reverse indent",opts},

    ["<A-Up>"] = { ":move '<-2<CR>gv-gv", "Move text up" ,opts},
    ["<A-Down>"] = { ":move '>+1<CR>gv-gv", "Move text down" ,opts},

    ["<C-A-Up>"] = { ":'<,'>y<CR>:'<-1pu<CR>gv=gv", "Copy text up" ,opts},
    ["<C-A-Down>"] = { ":'<,'>y<CR>:pu!<CR>gv=gv", "Copy text down" ,opts},

    ["<C-c>"] = { '"+y', "Copy to clipboard" ,opts},
    ["<C-x>"] = { '"+x', "Cut to clipboard" ,opts},
    ["<C-Z>"] = { "<C-O>u", "Undo",opts },
    ["<C-Y>"] = { "<C-O>:redo<CR>", "Redo" ,opts},

    ["<BS>"] = { '"d', "Backspace delete" ,opts},

        -- testing

    ["<C-h"] = { "<esc><cmd>lua require('spectre').open_visual()<CR>", "Search current word" },
  },
  t = {
      ["<C-v>"] = { "<C-\\><C-N>\"+p", "Paste from clipboard" ,opts },
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

    ["<C-p>"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all",opts },
    ["<C-A-f>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" ,opts},
    ["<C-f>"] = { "<cmd> Telescope buffers <CR>", "Find buffers" ,opts},
    ["<A-p>"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" ,opts},
 
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
