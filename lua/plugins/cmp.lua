return {
    {
        "hrsh7th/nvim-cmp",  -- Completion engine
        commit = "c27370703e798666486e3064b64d59eaf4bdc6d5",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",      -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",        -- Buffer completions
            "hrsh7th/cmp-path",          -- Path completions
            "hrsh7th/cmp-cmdline",       -- Command-line completions
            "L3MON4D3/LuaSnip",          -- Snippet engine
            "saadparwaiz1/cmp_luasnip",  -- Snippet completions
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- Use LuaSnip for snippets
                    end,
                },
                mapping = cmp.mapping.preset.insert({

                    -- Select the [n]ext item
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                    -- More classic ones
                    -- ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu
                    -- ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirm selection
                    -- ["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
                    -- ["<Tab>"] = cmp.mapping.select_next_item(), -- Navigate next
                    -- ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navigate previous
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP completions
                    { name = "buffer" }, -- Buffer completions
                    { name = "path" }, -- Path completions
                    { name = "luasnip" }, -- Snippets
                }),
            })

            -- Enable completion for LSP
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig").phpactor.setup({
                capabilities = capabilities,
            })
        end,
    }
}
