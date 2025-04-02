return {
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "cfc6f2c117aaaa82f19bcce44deec2c194d900ab",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { 
                    "lua", 
                    "python", 
                    "php",
                    "sql",
                    "javascript", 
                    "html", 
                    "css"
                },  
                auto_install = true,
                additional_vim_regex_highlighting = false,
                highlight = { enable = true }, 
                indent = { enable = true }, 
            }
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
    }
}
