return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.1",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- Required by Telescope
            {
                "nvim-telescope/telescope-fzf-native.nvim",  -- FZF support
                build = "make",  -- Compiles the native FZF sorter
            },
            {
                "nvim-telescope/telescope-live-grep-args.nvim" ,
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
            },
            "debugloop/telescope-undo.nvim",
        },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
            { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Show keymaps" },
            { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find commands" },
            { "<leader>fn", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", desc = "Find Neovim config files" },
            { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo Plugin" },
        },
        config = function()
            local telescope = require("telescope")
            local lga_actions = require("telescope-live-grep-args.actions")
            telescope.setup {
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git/", "dist/", "venv/" },
                    mappings = {
                        -- at this point I decided to disabled them in "i"
                        -- i = {
                        --     ["<C-j>"] = "move_selection_next",
                        --     ["<C-k>"] = "move_selection_previous",
                        --     ["<C-q>"] = "send_selected_to_qflist",
                        -- },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,  -- Enable fuzzy search
                        override_generic_sorter = true,  -- Replace default sorter
                        override_file_sorter = true,  -- Faster file sorting
                        case_mode = "smart_case",  -- Ignore case unless uppercase used
                    },
                    undo = {
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        -- define mappings, e.g.
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                                -- freeze the current list and start a fuzzy search in the frozen list
                                -- ["<C-y>"] = lga_actions.to_fuzzy_refine,
                            },
                        },
                        -- ... also accepts theme settings, for example:
                        -- theme = "dropdown", -- use dropdown theme
                        -- theme = { }, -- use own theme spec
                        -- layout_config = { mirror=true }, -- mirror preview pane
                    }
                },
            }
            telescope.load_extension("fzf")  
            telescope.load_extension("undo")
            telescope.load_extension("live_grep_args")
        end,
    }
}
