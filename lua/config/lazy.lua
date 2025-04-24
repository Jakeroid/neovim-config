-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: config.leader and config.settings are now loaded in init.lua before this file

-- Build the plugin specification list
local plugin_specs = {
    -- Import the base plugins first
    { import = "plugins" },
}

-- Check if the custom plugins directory exists (lua/custom/plugins/)
-- This directory should be ignored by git
local custom_plugins_path = vim.fn.stdpath('config') .. '/lua/custom/plugins'
if vim.fn.isdirectory(custom_plugins_path) == 1 then
    -- If the directory exists, add the custom plugins import to lazy's spec
    -- lazy.nvim will automatically load .lua files from lua/custom/plugins/
    table.insert(plugin_specs, { import = "custom.plugins" })
    vim.notify("Loading custom plugins from lua/custom/plugins/", vim.log.levels.INFO)
end

-- Setup lazy.nvim
require("lazy").setup({
    spec = plugin_specs, -- Use the dynamically built spec list
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
