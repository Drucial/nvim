-- LSP Configuration
-- This configuration sets up language servers for various filetypes using nvim-lspconfig,
-- along with additional configurations for diagnostics and key mappings.

-- Mason NVIM and Mason LSP Configuration
-- These plugins provide enhanced support for Mason files and integrate with nvim-lspconfig
-- to configure language servers.

-- Keymaps:
--   - <leader>d: Open diagnostic float window for current line
--   - <leader>rs: Restart LSP servers
--   - gR: Open references in Telescope
--   - gD: Go to declaration
--   - gd: Go to definitions in Telescope
--   - K: Show hover information
--   - <leader>ca: Trigger code actions

-- Auto Commands:
--   - CursorHold and CursorHoldI: Open float diagnostic window on cursor hold

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
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { silent = true, desc = "Restart LSP servers" })
			vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { silent = true, desc = "Find references" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Go to declaration" })
			vim.keymap.set(
				"n",
				"gd",
				"<cmd>Telescope lsp_definitions<CR>",
				{ silent = true, desc = "Go to definition" }
			)
			vim.keymap.set("n", "<leader>ci", vim.lsp.buf.hover, { silent = true, desc = "Show hover information" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "Trigger code actions" })
		end,
	},
}
