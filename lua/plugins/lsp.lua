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

            -- Define a common on_attach function to avoid repetition
            local function common_on_attach(client, bufnr)
                -- Standard LSP keymaps (add more as needed)
                local opts = { noremap=true, silent=true, buffer=bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- Use Ctrl-k for signature help
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts) -- Formatting handled differently below or by none-ls

                -- Diagnostic keymaps
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- Go to previous diagnostic
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- Go to next diagnostic
                vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts) -- Show diagnostic details in float
                vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts) -- Add diagnostics to location list
            end

            -- --- PHP LSP Setup --- 
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
