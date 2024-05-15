-- LSP Configuration
-- This configuration sets up language servers for various filetypes using nvim-lspconfig,
-- along with additional configurations for diagnostics and key mappings.

-- Mason NVIM and Mason LSP Configuration
-- These plugins provide enhanced support for Mason files and integrate with nvim-lspconfig
-- to configure language servers.

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

			local wk = require("which-key")
			wk.register({
				["c"] = {
					a = { vim.lsp.buf.code_action, "Code actions" },
					d = { "<CMD>Telescope lsp_definitions<CR>", "Go to definition" },
					D = { vim.lsp.buf.declaration, "Go to declaration" },
					I = { vim.lsp.buf.hover, "Show hover info" },
					i = {
						"<cmd>lua vim.diagnostic.open_float(nil, {focus=true, scope='line'})<CR>",
						"Show diagnostics",
					},
					R = { "<cmd>Telescope lsp_references<CR>", "Find references" },
					s = { "<cmd>LspRestart<CR>", "Restart LSP servers" },
				},
			}, { prefix = "<leader>" })
		end,
	},
}
