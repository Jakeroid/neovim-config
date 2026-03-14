# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A modular Neovim configuration using `lazy.nvim` as the plugin manager. Primary languages targeted: **PHP** and **Python**.

## Boot / Load Order

`init.lua` controls the load sequence — order matters:

1. `config/leader.lua` — leader key (Space), loaded first for WezTerm integration
2. `config/settings.lua` — base editor options and keymaps
3. `lua/custom/settings.lua` — optional user overrides (git-ignored), loaded with `pcall`
4. `.nvim.lua` (project root) — sets `vim.g.disabled_tools` before plugins load
5. `config/lazy.lua` — bootstraps and initializes lazy.nvim

## Plugin Organization

- `lua/plugins/` — one file per plugin, each returns a lazy.nvim plugin spec
- `lua/custom/plugins/` — git-ignored directory; files here are auto-discovered and merged into the plugin spec
- `lazy-lock.json` — locked plugin versions, commit changes to this file when updating plugins

## Per-Project Tool Control (`.nvim.lua`)

Projects can disable specific tools by creating a `.nvim.lua` in the project root **before** plugins load:

```lua
vim.g.disabled_tools = { "flake8", "mypy", "pyright" }
```

Disableable tools: `"php-cs-fixer"`, `"black"`, `"isort"`, `"flake8"`, `"mypy"`, `"pyright"`

All tools are also guarded by `vim.fn.executable()` — if the binary isn't on `$PATH`, the tool is skipped automatically.

## User Customization (Git-Ignored)

- `lua/custom/settings.lua` — overrides after base settings (e.g., disable relative numbers)
- `lua/custom/plugins/*.lua` — additional plugins in lazy.nvim spec format

Both locations are listed in `.gitignore` so users can extend the config without merge conflicts.

## Key Architecture Decisions

- **Conditional LSP loading:** `phpactor` and `pyright-langserver` are only attached if the executable exists on the system.
- **none-ls for formatting/linting:** `php-cs-fixer` (PSR12), `black` (88 chars), `isort`, `flake8`, `mypy` — all conditional on executables.
- **Treesitter folding** is configured; native folds use `expr` method.
- `barbecue.nvim` is present but intentionally disabled (`enabled = false`).

## Important Keymaps

| Key | Action |
|-----|--------|
| `<leader>tt` / `<leader>tc` | Toggle / close nvim-tree |
| `<leader>ff` | Telescope: find files |
| `<leader>fg` | Telescope: live grep (with args) |
| `<leader>fb` | Telescope: buffers |
| `<leader>fu` | Telescope: undo history |
| `<leader>y/Y` | Yank to system clipboard |
| `<leader>p` | Paste from system clipboard |
| `<leader>rn` | LSP rename |
| `<leader>ca` | LSP code actions |
| `<leader>?` | which-key: show buffer keymaps |
