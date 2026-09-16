# nvim-config

Neovim config: `lazy.nvim`, treesitter, and the built-in LSP client.

```sh
git clone https://github.com/j1z0/vim-config.git ~/code/vim-config
~/code/vim-config/install.sh
```

Linked to `~/.config/nvim`. Your existing config is moved aside, not deleted.

## What carried over from the Vundle config

`<leader>` is space, line numbers on, no swapfiles (persistent undo instead),
PEP8 indentation for Python and 2 spaces for JS/TS, `za` folding on space, and
solarized with a light/dark toggle on `<leader>bg`. `<leader>g` still goes to
the definition under the cursor — it was `YcmCompleter GoToDefinitionElseDeclaration`,
now it's `vim.lsp.buf.definition`.

## What replaced what

| Was | Now |
|---|---|
| Vundle | lazy.nvim |
| YouCompleteMe, supertab | blink.cmp + the built-in LSP client |
| syntastic, vim-flake8, Pydiction | LSP diagnostics (pyright + ruff) |
| NERDTree, vim-nerdtree-tabs | oil.nvim — a directory is a buffer you edit |
| ctrlp | telescope |
| SimpylFold, indentpython | treesitter folds and indentation |
| vim-colors-solarized + `togglebg` | solarized.nvim + auto-dark-mode.nvim, which follows macOS |
| vim-fugitive | kept — it was always right |

## Keys

```
space ff / fg     find file / live grep      -         file browser (oil)
space fb / fr     buffers / recent           space fs  changed files
gd or space g     go to definition           gr        references
K                 hover docs                 space rn  rename
space ca          code actions               space e   show diagnostic
space fm          format                     ]c / [c   next / previous git hunk
space bg          toggle light/dark          space     toggle fold
C-h C-j C-k C-l   move between splits, and across the boundary into tmux panes
```

## Notes

- Treesitter is pinned to its `master` branch. The `main` branch is the 1.0
  rewrite, which drops the `nvim-treesitter.configs` module this config uses.
- `auto-dark-mode.nvim` polls macOS appearance, so `set background` follows the
  system with no external helper.
