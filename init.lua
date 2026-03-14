-- Load leader key (needed early)
-- It's in separate file to make integration with WezTerm
require("config.leader")

-- Load base settings from separate file
require("config.settings")

-- Load custom user settings if they exist
-- This file should be placed in lua/custom/settings.lua and is ignored by git
local custom_settings_path = vim.fn.stdpath('config') .. '/lua/custom/settings.lua'
if vim.fn.filereadable(custom_settings_path) == 1 then
    -- Use pcall for safety, in case the user's file has errors
    local ok, err = pcall(require, 'custom.settings')
    if not ok then
        vim.notify("Error loading custom/settings.lua:\n" .. tostring(err), vim.log.levels.ERROR)
    end
end

-- Load project-local .nvim.lua before plugins so globals like
-- vim.g.disabled_tools are available when plugin configs run
local nvim_lua = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(nvim_lua) == 1 then
    dofile(nvim_lua)
end

-- Load Plugins Manager (lazy.nvim) and setup plugins
require("config.lazy")
