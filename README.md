# Jakeroid a.k.a. Ivan K. Neovim Config

This Neovim setup uses `lazy.nvim` for plugin management. It's configured for modern development with features like:

*   **Appearance:** `material.nvim` theme, `lualine` statusline, `barbecue` code context.
*   **Navigation/Finding:** `nvim-tree` file explorer, `telescope` fuzzy finder.
*   **Editing:** `autopairs`, `treesitter` for syntax, `which-key` hints.
*   **Code Intelligence (PHP/Python focused):**
    *   Uses `nvim-lspconfig` for LSP features (diagnostics, go-to-definition).
    *   Uses `none-ls` for formatting (`php-cs-fixer`, `black`, `isort`) and linting (`mypy`, `flake8`).
    *   Uses `nvim-cmp` for autocompletion (LSP, buffer, path, snippets).
*   **Key Feature:** Both LSP servers (`phpactor`, `pyright`) and `none-ls` formatters/linters are **conditionally loaded** only if their corresponding external tools are detected on the system, making the configuration robust even if some tools aren't installed. Python formatting is explicitly delegated to `none-ls`.

## Custom Configuration

This configuration supports user-specific overrides without modifying the core files tracked by Git.

1.  **Create the Custom Directory:**
    *   Inside your Neovim configuration directory (`~/.config/nvim/` or similar), create a `lua/custom/` directory.
    *   This directory (`lua/custom/`) is automatically ignored by Git (as defined in `.gitignore`).

2.  **Override Core Settings:**
    *   To override general Neovim settings (options, autocommands, globals, etc.), create a file named `lua/custom/settings.lua`.
    *   Any Lua code placed here will be executed *after* the base `lua/config/settings.lua` but *before* plugins are loaded.
    *   **Example `lua/custom/settings.lua`:**
        ```lua
        -- Disable relative line numbers
        vim.opt.relativenumber = false

        -- Add a custom global variable
        vim.g.my_custom_setting = true

        -- Add a custom autocommand
        vim.api.nvim_create_autocmd('BufEnter', {
          pattern = '*.md',
          command = 'echo "Entering a Markdown file!"',
        })
        ```

3.  **Add or Override Plugins:**
    *   To add new plugins or modify the configuration of existing ones managed by `lazy.nvim`, create `.lua` files inside `lua/custom/plugins/`.
    *   Each `.lua` file in this directory should return a standard `lazy.nvim` plugin specification (a table or a list of tables).
    *   These specifications will be merged with the base plugin configurations. For overrides, `lazy.nvim` often merges options (`opts = {...}`), allowing you to change specific settings without redefining the entire plugin setup.
    *   **Example `lua/custom/plugins/my_extra_plugin.lua` (Adding a new plugin):**
        ```lua
        return {
          "some-author/some-plugin.nvim",
          config = function()
            require("some-plugin").setup()
          end,
        }
        ```
    *   **Example `lua/custom/plugins/telescope_override.lua` (Overriding existing plugin options):**
        ```lua
        return {
          "nvim-telescope/telescope.nvim",
          -- Only specify the options you want to change or add
          opts = {
            defaults = {
              -- Override the default file ignore patterns
              file_ignore_patterns = { ".git/", "node_modules/", "__pycache__/" },
            },
          },
        }
        ```

Any files placed in `lua/custom/` will automatically be loaded if they exist, allowing you to tailor the configuration to your specific needs without creating conflicts with future updates from the main repository.
