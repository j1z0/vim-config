-- ~/.config/nvim/init.lua  ->  ~/.dotfiles/nvim/init.lua
--
-- Replaces the 2013 Vundle config. What carried over: leader=space, line
-- numbers, no swapfiles, PEP8 indentation, solarized with a light/dark toggle.
-- What didn't: Vundle, YouCompleteMe, syntastic, flake8, Pydiction, NERDTree,
-- ctrlp — all superseded by treesitter, the built-in LSP client, and telescope.

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ---------------------------------------------------------------- options --
local o = vim.opt
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true
o.termguicolors = true
o.swapfile = false            -- "I don't like swap files" (2013, still true)
o.undofile = true             -- better than swapfiles: persistent undo
o.backup = false
o.updatetime = 200
o.timeoutlen = 400
o.scrolloff = 8
o.sidescrolloff = 8
o.splitright = true
o.splitbelow = true
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"
o.expandtab = true
o.shiftwidth = 4              -- PEP8 default; per-language overrides below
o.tabstop = 4
o.softtabstop = 4
o.smartindent = true
o.wrap = false
o.clipboard = "unnamedplus"
o.mouse = "a"
o.confirm = true
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99              -- open by default; za still folds
o.background = (vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):match("Dark")) and "dark" or "light"

-- --------------------------------------------------------------- keymaps --
local map = vim.keymap.set
map("n", "<leader>w", "<cmd>w<cr>", { desc = "write" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlight" })
map("n", "<space>", "za", { desc = "toggle fold" })          -- kept from 2013
map("n", "<leader>bg", function()                             -- was togglebg F5
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, { desc = "toggle light/dark" })
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "leave terminal mode" })

-- ------------------------------------------------------------- filetypes --
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact",
              "json", "yaml", "html", "css", "lua", "ruby" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function() vim.bo.textwidth = 100 end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})

-- ----------------------------------------------------------------- lazy ----
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "solarized" } },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
