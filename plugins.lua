local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options

    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },
    {
        "NvChad/nvterm",
        opts = overrides.nvterm,
    },
    -- Install a plugin
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").load_extension("ui-select")
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
            },
        },
        config = function()
            local telescope = require("telescope")
            local lga_actions = require("telescope-live-grep-args.actions")

            telescope.setup {
                extensions = {
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        -- define mappings, e.g.
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        },
                        -- ... also accepts theme settings, for example:
                        theme = "dropdown", -- use dropdown theme
                        -- theme = { }, -- use own theme spec
                        -- layout_config = { mirror=true }, -- mirror preview pane
                    }
                }
            }

            require("telescope").load_extension("live_grep_args")
        end
    },
    {
      'VonHeikemen/searchbox.nvim',
      requires = {
      {'MunifTanjim/nui.nvim'}
      }
    },
    {
        "mg979/vim-visual-multi",
        branch = "master",
        lazy = false
    },
    {
        "github/copilot.vim",
        lazy = false,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        opts = {
          show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
          debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
          disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
          -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
        },
            build = function()
                  vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
            end,
            event = "VeryLazy",
            keys = {
              { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
              { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
              {
                "<leader>ccv",
                ":CopilotChatVisual",
                  mode = "x",
                  desc = "CopilotChat - Open in vertical split",
              },
              {
                "<leader>ccx",
                ":CopilotChatInPlace<cr>",
                mode = "x",
                desc = "CopilotChat - Run in-place code",
              }
            },
        lazy = false,
    },
    {
        "sindrets/diffview.nvim",
    },
    {
        'stevearc/aerial.nvim',
        config = function()
            require "custom.configs.aerial"
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",   -- required
            "sindrets/diffview.nvim",  -- optional - Diff integration
            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup()
            require('telescope').load_extension("projects")
        end,
    },
    {
        "dstein64/nvim-scrollview",
        config = function()
            require("scrollview").setup()
        end,
        lazy = false,
    },
    {
        "nvim-pack/nvim-spectre",
        branch = "master",
    },
    {
        "folke/neodev.nvim",
        config = function()
            require "custom.configs.neodev"
        end,
        branch = "main",
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require "custom.configs.dap"
        end,
        branch = "master",
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require "custom.configs.dapui"
        end,
        requires = { "mfussenegger/nvim-dap" }
    }

    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
}

return plugins
