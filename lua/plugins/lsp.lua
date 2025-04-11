return {
    {
        "neovim/nvim-lspconfig",
        commit = "69d2876c0d40e8714b3a56a02eb16fab3409e960",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            -- Check if cmp-nvim-lsp is available to get capabilities
            local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = cmp_lsp_ok and cmp_nvim_lsp.default_capabilities() or {}

            -- --- PHP LSP Setup ---
            -- Check if the 'phpactor' executable exists before setting up the server
            if vim.fn.executable("phpactor") == 1 then
                lspconfig.phpactor.setup({
                    cmd = { "phpactor", "language-server" },
                    filetypes = { "php" },
                    root_dir = util.root_pattern("composer.json", ".git"),
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        -- Enable formatting on save if server supports it
                        if client.server_capabilities.documentFormattingProvider then
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                -- Use format { async = false } for synchronous format on save
                                -- Filter ensures only phpactor tries to format PHP files via LSP
                                callback = function() vim.lsp.buf.format({ async = false, filter = function(c) return c.name == "phpactor" end }) end,
                            })
                        end
                        -- Add other keymaps or settings specific to PHP LSP here
                    end,
                })
            else
                -- Notify user if phpactor is missing
                vim.notify("LSP: 'phpactor' executable not found. PHP LSP support disabled.", vim.log.levels.WARN)
            end

            -- --- Python LSP Setup ---
            -- Check if the 'pyright-langserver' executable exists before setting up the server
            if vim.fn.executable("pyright-langserver") == 1 then
                lspconfig.pyright.setup({
                    filetypes = { "python" },
                    root_dir = util.root_pattern(".git", "pyproject.toml", "setup.py"),
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        -- Disable pyright's formatter since we use none-ls (black, isort)
                        client.server_capabilities.documentFormattingProvider = false

                        -- Remove the BufWritePre autocmd for pyright formatting,
                        -- as none-ls should handle Python formatting on save.
                        -- Keeping it might lead to conflicts or double formatting attempts.

                        -- Add other keymaps or settings specific to Python LSP here
                    end,
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "workspace",
                                useLibraryCodeForTypes = true,
                            }
                        }
                    }
                })
            else
                -- Notify user if pyright-langserver is missing
                vim.notify("LSP: 'pyright-langserver' executable not found. Python LSP support disabled.", vim.log.levels.WARN)
            end

            -- --- Add setups for other language servers here, wrapped in similar checks ---
            -- Example for Lua (using lua-language-server, often named lua-ls or lua-language-server)
            -- if vim.fn.executable("lua-language-server") == 1 then
            --     lspconfig.lua_ls.setup({
            --         capabilities = capabilities,
            --         on_attach = function(client, bufnr)
            --             -- Lua specific on_attach
            --         end,
            --         settings = {
            --             Lua = {
            --                 runtime = { version = 'LuaJIT' },
            --                 diagnostics = { globals = {'vim'} },
            --                 -- Add other lua_ls settings
            --             }
            --         }
            --     })
            -- else
            --     vim.notify("LSP: 'lua-language-server' executable not found. Lua LSP support disabled.", vim.log.levels.WARN)
            -- end

        end,
    },
}
