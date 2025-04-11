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

## Code Intelligence and Formatting

This configuration utilizes several plugins working together to provide robust code intelligence (LSP), formatting, linting, and autocompletion. A key feature is that it checks for the presence of required external tools and language servers before attempting to configure them, preventing errors if they are not installed.

### Language Server Protocol (LSP) - `nvim-lspconfig`

*   **Plugin:** `neovim/nvim-lspconfig`
*   **File:** `lua/plugins/lsp.lua`
*   **Role:** Manages Language Server Protocol clients for features like diagnostics, code actions, go-to-definition, etc.
*   **Configuration:**
    *   Conditionally sets up servers based on executable presence (`vim.fn.executable`). Currently configured for:
        *   PHP: `phpactor` (checks for `phpactor` executable).
        *   Python: `pyright` (checks for `pyright-langserver` executable).
    *   Displays a `vim.notify` warning if a configured LSP server's executable is not found.
    *   Integrates with `nvim-cmp` by providing completion capabilities (obtained via `cmp_nvim_lsp` and passed during server setup).
    *   Enables format-on-save for PHP via `phpactor` *if* `phpactor` is installed and supports formatting.
    *   Explicitly *disables* formatting capabilities for `pyright` to defer Python formatting to `none-ls`.

### Formatting & Linting - `none-ls`

*   **Plugin:** `nvimtools/none-ls.nvim`
*   **File:** `lua/plugins/none-ls.lua`
*   **Role:** Runs external formatters and linters, integrating them into the LSP ecosystem (e.g., for format-on-save, diagnostics).
*   **Configuration:**
    *   Conditionally registers sources based on executable presence (`vim.fn.executable`). Currently configured for:
        *   PHP Formatting: `php-cs-fixer`
        *   Python Formatting: `black`, `isort`
        *   Python Diagnostics: `mypy`, `flake8`
        *   Python Code Actions: Built-in `refactoring`
    *   This setup ensures Neovim doesn't error if tools like `black` or `flake8` are missing.
    *   Handles formatting for Python files (e.g., on save, if configured via an autocmd or manually triggered).

### Autocompletion - `nvim-cmp`

*   **Plugin:** `hrsh7th/nvim-cmp`
*   **File:** `lua/plugins/cmp.lua`
*   **Role:** Provides the autocompletion user interface and engine.
*   **Configuration:**
    *   Sources suggestions from:
        *   LSP (via `cmp-nvim-lsp`)
        *   Buffers (`cmp-buffer`)
        *   File paths (`cmp-path`)
        *   Command line (`cmp-cmdline`)
        *   Snippets (`LuaSnip` via `cmp_luasnip`)
    *   Uses standard keybindings like `<C-n>`/`<C-p>` for navigating suggestions.
    *   Relies on `lua/plugins/lsp.lua` to correctly configure LSP servers with the necessary capabilities for completion.

This layered approach ensures that language features and formatting/linting tools are only activated when available, making the configuration more portable and resilient.
