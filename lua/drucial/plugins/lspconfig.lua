return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "ruby_lsp", "tailwindcss" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })

      vim.diagnostic.config({
        virtual_text = false,
        float = {
          source = "always",
          border = "rounded",
        },
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
      })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
        end,
      })

      vim.keymap.set(
        "n",
        "<leader>d",
        ":lua vim.diagnostic.open_float(nil, {focus=true, scope='line'})<CR>",
        { silent = true }
      )
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { silent = true })
      vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { silent = true })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { silent = true })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
