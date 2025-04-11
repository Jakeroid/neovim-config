return {
    {
        "nvim-telescope/telescope.nvim",
        commit = "814f102cd1da3dc78c7d2f20f2ef3ed3cdf0e6e4",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- Required by Telescope
            {
                "nvim-telescope/telescope-fzf-native.nvim",  -- FZF support
                build = "make",  -- Compiles the native FZF sorter
            },
            "debugloop/telescope-undo.nvim",
        },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
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
            require("telescope").setup {
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git/", "dist/", "venv/" },
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            ["<C-q>"] = "send_selected_to_qflist",
                        },
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
                },
            }
            require("telescope").load_extension("fzf")  
            require("telescope").load_extension("undo")
        end,
    }
}
