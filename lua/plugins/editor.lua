return {
  -- telescope replaces ctrlp
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "recent" },
      { "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "changed files" },
      { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "search buffer" },
    },
    config = function()
      require("telescope").setup({
        defaults = { layout_strategy = "flex", path_display = { "truncate" } },
      })
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  -- oil replaces NERDTree: a directory is just a buffer you edit
  {
    "stevearc/oil.nvim",
    opts = { view_options = { show_hidden = true } },
    keys = { { "-", "<cmd>Oil<cr>", desc = "open parent directory" } },
    lazy = false,
  },

  -- Pinned to master: nvim-treesitter's `main` branch is the 1.0 rewrite, which
  -- dropped the nvim-treesitter.configs module this setup uses.
  { "nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate",
    opts = {
      ensure_installed = { "python", "javascript", "typescript", "tsx", "lua", "ruby",
        "go", "rust", "json", "yaml", "toml", "bash", "markdown", "markdown_inline",
        "html", "css", "sql", "dockerfile", "gitcommit", "diff" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    main = "nvim-treesitter.configs",
  },

  { "lewis6991/gitsigns.nvim",
    opts = { current_line_blame = false },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "blame line" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "preview hunk" },
      { "]c", "<cmd>Gitsigns next_hunk<cr>", desc = "next hunk" },
      { "[c", "<cmd>Gitsigns prev_hunk<cr>", desc = "prev hunk" },
    },
  },

  { "tpope/vim-fugitive", cmd = { "G", "Git", "Gdiffsplit", "Gblame" } },  -- survivor from 2013
  { "tpope/vim-surround" },
  { "tpope/vim-sleuth" },                     -- detect indentation per file
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "christoomey/vim-tmux-navigator", lazy = false },  -- C-hjkl across nvim and tmux
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
}
