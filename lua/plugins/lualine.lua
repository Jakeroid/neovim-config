return {
    "nvim-lualine/lualine.nvim",
    commit = "47f91c416daef12db467145e16bed5bbfe00add8",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for icons
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto", -- Automatically adjusts to the current theme
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_a = { "mode" }, -- Displays the current mode (e.g., NORMAL, INSERT)
                lualine_b = { "branch" }, -- Git branch
                lualine_c = { "filename" }, -- File name
                lualine_x = { "encoding", "fileformat", "filetype" }, -- File info
                lualine_y = { "progress" }, -- Progress percentage
                lualine_z = { "location" }, -- Cursor location
            },
        })
    end,
}
