return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = function()
            require("nvim-treesitter").update()
        end,
        config = function()
            local parsers = {
                "lua",
                "python",
                "php",
                "sql",
                "javascript",
                "html",
                "css",
            }

            local ts = require("nvim-treesitter")
            if type(ts.install) == "function" then
                ts.install(parsers)
            else
                vim.notify(
                    "nvim-treesitter: legacy checkout detected, run :Lazy sync to switch to main branch",
                    vim.log.levels.WARN
                )
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = parsers,
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                    vim.bo[args.buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
    },
}
