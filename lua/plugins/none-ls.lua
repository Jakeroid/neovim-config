return {
    {
        "nvimtools/none-ls.nvim",
        -- commit = "d5953304ba8505490ce4f9f0ca9505a658e803c2",
        commit = "3c206dfedf5f1385e9d29f85ffaec7874358592a",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            -- Table to hold sources that are actually available on the system
            local available_sources = {}

            -- Per-project disable list: set in .nvim.lua at project root
            -- Example: vim.g.disabled_python_tools = { "black", "flake8" }
            local disabled = vim.g.disabled_python_tools or {}

            -- Add a source only if the executable exists and the tool is not disabled
            local function add_source(name, source)
                if vim.tbl_contains(disabled, name) then return end
                if vim.fn.executable(name) == 0 then return end
                table.insert(available_sources, source)
            end

            -- PHP Formatter
            add_source("php-cs-fixer", null_ls.builtins.formatting.phpcsfixer.with({
                command = "php-cs-fixer",
                args = { "fix", "--using-cache=no", "--rules=@PSR12", "$FILENAME" },
            }))

            -- Python Formatter: black
            add_source("black", null_ls.builtins.formatting.black.with({
                extra_args = { "--fast", "--line-length", "88" },
            }))

            -- Python Formatter: isort
            add_source("isort", null_ls.builtins.formatting.isort)

            -- Python Diagnostics: mypy (uses pcall to prefer none-ls-extras over builtin)
            if vim.fn.executable("mypy") == 1 and not vim.tbl_contains(disabled, "mypy") then
                local mypy_ok, mypy = pcall(require, "none-ls.diagnostics.mypy")
                if mypy_ok then
                    table.insert(available_sources, mypy)
                else
                    local builtin_mypy = null_ls.builtins.diagnostics.mypy
                    if builtin_mypy then
                        table.insert(available_sources, builtin_mypy)
                    else
                        vim.notify("none-ls: Failed to load mypy source.", vim.log.levels.WARN)
                    end
                end
            end

            -- Python Linter: flake8 (uses pcall to load from none-ls-extras)
            if vim.fn.executable("flake8") == 1 and not vim.tbl_contains(disabled, "flake8") then
                local flake8_ok, flake8 = pcall(require, "none-ls.diagnostics.flake8")
                if flake8_ok then
                    table.insert(available_sources, flake8.with({
                        extra_args = { "--max-line-length", "88" },
                    }))
                else
                    vim.notify("none-ls: Failed to load flake8 source from none-ls-extras.", vim.log.levels.WARN)
                end
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
