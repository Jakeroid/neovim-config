return {
    "nvim-tree/nvim-tree.lua",
    commit = "c09ff35de503a41fa62465c6b4ae72d96e7a7ce4",
    lazy = false,                      -- Load immediately at startup
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Provides file type icons
    },
    config = function()
        require("nvim-tree").setup({

            -- Core Behavior
            hijack_netrw = true,       -- Replace netrw with nvim-tree
            auto_reload_on_write = true, -- Auto-refresh when files are saved

            -- File and CWD Behavior
            sync_root_with_cwd = true, -- Keep tree root synced with current working directory

            -- Diagnostics (Errors/Warnings)
            diagnostics = {
                enable = true,         -- Show LSP diagnostics
                icons = {
                    -- Use the same icons as defined in lua/config/settings.lua
                    hint = "",        -- nf-oct-light_bulb
                    info = "",        -- nf-fa-info
                    warning = "",     -- nf-fa-warning / nf-fa-exclamation_triangle
                    error = "",        -- nf-fa-times
                },
            },

            -- File Focus Behavior
            update_focused_file = {
                enable = true,         -- Highlight/focus file when buffer changes
                update_root = true,    -- Update tree root when focusing files
                ignore_list = {},      -- Files to ignore in focus updates
            },

            -- View Layout
            view = {
                width = 50,            -- Sidebar width in columns
                side = "left",         -- Position: "left" or "right"
                number = false,        -- Disable line numbers
                relativenumber = false,-- Disable relative line numbers
                signcolumn = "yes",    -- Show sign column (for diagnostics/git)
            },

            -- Visual Rendering
            renderer = {
                icons = {
                    glyphs = {
                        folder = {     -- Folder arrow symbols
                            arrow_closed = "▶", -- Closed folder
                            arrow_open = "▼",   -- Open folder
                        },
                    },
                },
            },

            -- Git Integration
            git = {
                enable = true,         -- Show git status icons
                ignore = false,        -- Don't ignore git files
                timeout = 700,         -- Git process timeout (ms)
            },

            -- File Open Behavior
            actions = {
                open_file = {
                    quit_on_open = false, -- Keep tree open after file open
                    window_picker = {
                        enable = false,    -- Allow choosing window to open in
                    },
                },
            },

            -- Filter Configuration: hide specific directories/files
            filters = {
                custom = {
                    "__pycache__",
                    ".DS_Store",
                    ".git$",           -- Hide .git directory (exact match)
                    ".ropeproject",
                    ".mypy_cache",
                    ".aider*",
                    ".pytest_cache",  -- Hide .pytest_cache directory (exact match)
                },
            },
        })

        -- Keybindings
        vim.keymap.set("n", "<leader>tt", ":NvimTreeFocus<CR>", {
            noremap = true,
            silent = true,
            desc = "Toggle File Explorer",
        })

        vim.keymap.set("n", "<leader>tc", ":NvimTreeClose<CR>", {
            noremap = true,
            silent = true,
            desc = "Close File Explorer"
        })
    end,
}
