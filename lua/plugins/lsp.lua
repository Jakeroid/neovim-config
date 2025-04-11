return {
    {
        "neovim/nvim-lspconfig",
        commit = "69d2876c0d40e8714b3a56a02eb16fab3409e960",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            -- Check if cmp-nvim-lsp is available
            local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = cmp_lsp_ok and cmp_nvim_lsp.default_capabilities() or {}

            -- PHP LSP setup remains unchanged
            lspconfig.phpactor.setup({
                cmd = { "phpactor", "language-server" },
                filetypes = { "php" },
                root_dir = util.root_pattern("composer.json", ".git"),
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function() vim.lsp.buf.format() end,
                        })
                    end
                end,
            })

            lspconfig.pyright.setup({
                filetypes = { "python" },
                root_dir = util.root_pattern(".git", "pyproject.toml", "setup.py"),
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- We'll use none-ls for formatting, so disable pyright's formatter
                    if client.name == "pyright" then
                        client.server_capabilities.documentFormattingProvider = false
                    end
                    
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format() end,
                    })
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

        end,
    },
}
