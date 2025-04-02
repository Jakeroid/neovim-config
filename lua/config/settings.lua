-- Enable mouse --  
vim.opt.mouse = 'a'

-- Don't show "Show Mode" since I have status line plugin
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Clear highlights on search when pressing <Esc> in normal mode
-- --  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Show max line length (as PEP8, but with Black recomendation) -- 
vim.opt.colorcolumn = "88"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Row numbers --
vim.wo.number = true
vim.wo.relativenumber = true

-- Tabulation and Indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true   -- Ignore case when searching
vim.opt.incsearch = true    -- Show matches while typing
vim.opt.smartcase = true    -- Override ignorecase if search pattern contains uppercase
vim.opt.hlsearch = true     -- Highlight search matches

-- Show Tabline -- 
vim.opt.showtabline = 2

-- Fold by default --
vim.opt.foldlevelstart = 99

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { 
        clear = true 
    }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Yank to system clipboard
vim.keymap.set({'n','v'}, '<leader>y', '"+y', { noremap = true, desc = "Yank to clipboard" })
vim.keymap.set('n', '<leader>Y', '"+Y', { noremap = true, desc = "Yank line to clipboard" })

-- Delete to system clipboard
vim.keymap.set({'n','v'}, '<leader>d', '"+d', { noremap = true, desc = "Delete to clipboard" })
vim.keymap.set('n', '<leader>D', '"+D', { noremap = true, desc = "Delete line to clipboard" })

-- Paste from system clipboard
vim.keymap.set({'n','v'}, '<leader>p', '"+p', { noremap = true, desc = "Paste from clipboard" })

-- Past in insert mode. Prevent auto indent or comments while pasting a multiline block.
-- vim.keymap.set({'i'}, '<leader>p', '<C-r>+', { noremap = true, desc = "Paste from clipboard" })
vim.keymap.set({'i'}, '<leader>p', '<C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>', { noremap = true, desc = "Paste from clipboard" })
