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

            -- -- Function to get Poetry virtual environment path
            -- local function get_poetry_venv()
            --     local handle = io.popen("poetry env info --path 2>/dev/null")
            --     if handle then
            --         local venv_path = handle:read("*a"):gsub("%s+", "")  -- trim whitespace
            --         handle:close()
            --         return venv_path
            --     end
            --     return nil
            -- end
            --
            -- -- Detect active environments
            -- local poetry_venv = get_poetry_venv()
            -- local manual_venv = os.getenv("VIRTUAL_ENV")
            -- local venv_path = poetry_venv or manual_venv
            --
            -- -- Configure environment variables only for Poetry
            -- local pylsp_cmd = { "pylsp" }  -- default
            -- if poetry_venv then
            --     vim.env.VIRTUAL_ENV = poetry_venv
            --     vim.env.PATH = poetry_venv .. "/bin:" .. vim.env.PATH
            --     pylsp_cmd = { poetry_venv .. "/bin/pylsp" }
            -- elseif manual_venv then
            --     -- Use existing environment variables from manual activation
            --     pylsp_cmd = { manual_venv .. "/bin/pylsp" }
            -- end

            -- Helper to check executable availability
            local function exe_exists(cmd)
                return vim.fn.executable(cmd) == 1
            end

            -- Conditional plugin enabling
            local black_enabled = exe_exists("black")
            local isort_enabled = exe_exists("isort")
            local flake8_enabled = exe_exists("flake8")
            local mypy_enabled = exe_exists("mypy")

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

            -- Python LSP setup with smart environment detection
            -- lspconfig.pylsp.setup({
            --     cmd = pylsp_cmd,
            --     filetypes = { "python" },
            --     root_dir = util.root_pattern(".git", "pyproject.toml", "setup.py"),
            --     settings = {
            --         pylsp = {
            --             plugins = {
            --                 black = { enabled = black_enabled },
            --                 isort = { enabled = isort_enabled },
            --                 flake8 = { enabled = flake8_enabled },
            --                 mypy = { enabled = mypy_enabled },
            --                 rope_autoimport = { enabled = true },
            --                 pycodestyle = { enabled = false },
            --             },
            --         },
            --     },
            --     capabilities = capabilities,
            --     on_attach = function(client, bufnr)
            --         if client.name == "pylsp" then
            --             client.server_capabilities.documentFormattingProvider = false
            --         end
            --         vim.api.nvim_create_autocmd("BufWritePre", {
            --             buffer = bufnr,
            --             callback = function() vim.lsp.buf.format() end,
            --         })
            --     end,
            --     -- capabilities = capabilities,
            --     -- on_attach = function(client, bufnr)
            --     --     -- Disable formatting from pylsp so that null-ls takes precedence.
            --     --     if client.name == "pylsp" then
            --     --         client.server_capabilities.documentFormattingProvider = false
            --     --     end
            --     --     vim.api.nvim_create_autocmd("BufWritePre", {
            --     --         buffer = bufnr,
            --     --         callback = function() vim.lsp.buf.format() end,
            --     --     })
            --     -- end,
            -- })

            lspconfig.pylsp.setup({
            --     cmd = pylsp_cmd,
            --     filetypes = { "python" },
            --     root_dir = util.root_pattern(".git", "pyproject.toml", "setup.py"),
            --     settings = {
            --         pylsp = {
            --             plugins = {
            --                 pylsp_black = { enabled = black_enabled, line_length = 88 },
            --                 isort = { enabled = isort_enabled },
            --                 -- Option 1: If you want to keep flake8 with a custom line length:
            --                 flake8 = { enabled = flake8_enabled, maxLineLength = 88 },
            --                 -- Option 2: If you want to disable flake8 altogether, uncomment the following line:
            --                 -- flake8 = { enabled = false },
            --                 pycodestyle = { enabled = false },
            --                 mypy = { enabled = mypy_enabled },
            --                 rope_autoimport = { enabled = true },
            --             },
            --         },
            --     },
            --     capabilities = capabilities,
            --     on_attach = function(client, bufnr)
            --         vim.api.nvim_create_autocmd("BufWritePre", {
            --             buffer = bufnr,
            --             callback = function() vim.lsp.buf.format() end,
            --         })
            --     end,
            -- })
        end,
    },
}
