return {
    -- Material Theme 
    { 
        "marko-cerovac/material.nvim", 
        commit = "c8ff153d2c2b22f8b2c9bcce0d741ab55c00cfed",
        name = "material", 
        priority = 1000,
        config = function()

            vim.g.material_style = "deep ocean"

            require('material').setup({

                contrast = {
                    terminal = true, -- Enable contrast for the built-in terminal
                    sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                    floating_windows = true, -- Enable contrast for floating windows
                    cursor_line = true, -- Enable darker background for the cursor line
                    lsp_virtual_text = true, -- Enable contrasted background for lsp virtual text
                    non_current_windows = true, -- Enable contrasted background for non-current windows
                    filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
                },

                styles = { -- Give comments style such as bold, italic, underline etc.
                    comments = { --[[ italic = true ]] },
                    strings = { --[[ bold = true ]] },
                    keywords = { --[[ underline = true ]] },
                    functions = { --[[ bold = true, undercurl = true ]] },
                    variables = {},
                    operators = {},
                    types = {},
                },

                plugins = { -- Uncomment the plugins that you use to highlight them
                    -- Available plugins:
                    -- "coc",
                    -- "colorful-winsep",
                    -- "dap",
                    -- "dashboard",
                    -- "eyeliner",
                    -- "fidget",
                    -- "flash",
                    -- "gitsigns",
                    -- "harpoon",
                    -- "hop",
                    -- "illuminate",
                    -- "indent-blankline",
                    -- "lspsaga",
                    -- "mini",
                    -- "neogit",
                    -- "neotest",
                    -- "neo-tree",
                    -- "neorg",
                    -- "noice",
                    "nvim-cmp",
                    -- "nvim-navic",
                    "nvim-tree",
                    "nvim-web-devicons",
                    -- "rainbow-delimiters",
                    -- "sneak",
                    "telescope",
                    -- "trouble",
                    "which-key",
                    -- "nvim-notify",
                },

                disable = {
                    colored_cursor = false,
                    borders = false,
                    background = false,
                    term_colors = false,
                    eob_lines = false,
                },

                high_visibility = {
                    lighter = false, -- Enable higher contrast text for lighter style
                    darker = false -- Enable higher contrast text for darker style
                },

                lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

                async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

                custom_colors = nil, -- If you want to override the default colors, set this to a function

                custom_highlights = {}, -- Overwrite highlights with your own
            })

            vim.cmd.colorscheme("material")

        end
    },
}
