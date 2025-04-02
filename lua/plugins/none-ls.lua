return {
    {
        "nvimtools/none-ls.nvim",
        commit = "d5953304ba8505490ce4f9f0ca9505a658e803c2",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            -- Require the flake8 module from the extras plugin
            local flake8 = require("none-ls.diagnostics.flake8")
            
            null_ls.setup({
                sources = {
                    -- PHP Formatter
                    null_ls.builtins.formatting.phpcsfixer.with({
                        command = "php-cs-fixer",
                        args = { "fix", "--using-cache=no", "--rules=@PSR12", "$FILENAME" },
                    }),

                    -- Python Formatters
                    null_ls.builtins.formatting.black.with({
                        extra_args = { "--fast", "--line-length", "88" },
                    }),
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.diagnostics.mypy,

                    -- Flake8 Diagnostics using the extras module
                    flake8.with({
                        extra_args = { "--max-line-length", "88" },
                    }),

                    -- Python Code Actions (Fix issues)
                    null_ls.builtins.code_actions.refactoring,
                },
            })
        end,
    },
}
