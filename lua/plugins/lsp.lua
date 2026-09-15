-- The built-in LSP client replaces YouCompleteMe, syntastic, flake8 and
-- Pydiction from the old vimrc — all four, with one config.
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim",
        opts = { ensure_installed = { "pyright", "ruff", "ts_ls", "lua_ls", "gopls", "jsonls", "yamlls" } } },
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local b = { buffer = ev.buf }
          -- the old vimrc bound <leader>g to YcmCompleter GoToDefinition
          vim.keymap.set("n", "<leader>g", vim.lsp.buf.definition, b)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, b)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, b)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, b)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, b)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, b)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, b)
          vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, b)
        end,
      })
      vim.diagnostic.config({ virtual_text = { prefix = "●" }, severity_sort = true })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
}
