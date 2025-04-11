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

            -- Table to hold sources that are actually available on the system
            local available_sources = {}

            -- Helper function to check for executable and add source if found
            -- Takes the executable name and the null-ls source configuration
            local function add_source_if_exec_exists(executable, source_config)
                if vim.fn.executable(executable) == 1 then
                    table.insert(available_sources, source_config)
                else
                    -- Optional: Notify the user that a tool is missing
                    -- vim.notify("none-ls: Executable '" .. executable .. "' not found. Skipping.", vim.log.levels.WARN)
                end
            end

            -- PHP Formatter: Check for 'php-cs-fixer'
            add_source_if_exec_exists("php-cs-fixer", null_ls.builtins.formatting.phpcsfixer.with({
                command = "php-cs-fixer",
                args = { "fix", "--using-cache=no", "--rules=@PSR12", "$FILENAME" },
            }))

            -- Python Formatter: Check for 'black'
            add_source_if_exec_exists("black", null_ls.builtins.formatting.black.with({
                extra_args = { "--fast", "--line-length", "88" },
            }))

            -- Python Formatter: Check for 'isort'
            add_source_if_exec_exists("isort", null_ls.builtins.formatting.isort)

            -- Python Diagnostics: Check for 'mypy'
            add_source_if_exec_exists("mypy", null_ls.builtins.diagnostics.mypy)

            -- Flake8 Diagnostics: Check for 'flake8'
            if vim.fn.executable("flake8") == 1 then
                -- Also ensure the extras module can be loaded successfully
                local flake8_ok, flake8 = pcall(require, "none-ls.diagnostics.flake8")
                if flake8_ok then
                    table.insert(available_sources, flake8.with({
                        extra_args = { "--max-line-length", "88" },
                    }))
                else
                    vim.notify("none-ls: Failed to load flake8 source from none-ls-extras.", vim.log.levels.WARN)
                end
            -- else
                -- Optional: Notify the user that flake8 is missing
                -- vim.notify("none-ls: Executable 'flake8' not found. Skipping.", vim.log.levels.WARN)
            end

            -- Python Code Actions (Built-in, doesn't need an external executable check)
            table.insert(available_sources, null_ls.builtins.code_actions.refactoring)

            -- Setup none-ls using only the sources for available tools
            null_ls.setup({
                sources = available_sources,
                -- You might want to enable debug mode temporarily if things aren't working
                -- debug = true,
            })
        end,
    },
}
