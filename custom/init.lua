
-- Rest of your init.lua configurations...

-- Function to set indentation
local function set_indentation()
    vim.opt.tabstop = 4        -- Number of spaces that a <Tab> in the file counts for
    vim.opt.shiftwidth = 4     -- Size of an indent
    vim.opt.expandtab = true   -- Use spaces instead of tabs
    vim.opt.smartindent = true -- Insert indents automatically
end

-- Set indentation for specific filetypes
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"python", "c", "cpp", "cuda"},
    callback = set_indentation
})

