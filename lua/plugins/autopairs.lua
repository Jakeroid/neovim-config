return {
    "windwp/nvim-autopairs",
    commit = "3d02855468f94bf435db41b661b58ec4f48a06b7", -- Bind commit for the security reasons
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,  -- Enable Treesitter integration
        })
    end
}
