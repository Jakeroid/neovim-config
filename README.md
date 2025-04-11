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
