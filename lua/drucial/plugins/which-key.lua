-- Configuration for folke/which-key.nvim
-- This configuration sets up the which-key.nvim plugin, which provides
-- a visual interface to help you discover and remember key mappings in Neovim.

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		local wk = require("which-key")

		wk.register({
			["<leader>"] = {
				name = "Leader",
				["c"] = {
					name = "Code",
				},
				["d"] = {
					name = "Debugging",
				},
				["e"] = {
					name = "Explorer",
				},
				["f"] = {
					name = "Find",
				},
				["g"] = {
					name = "Comments",
				},
				["h"] = {
					name = "GitSigns",
				},
				["l"] = {
					name = "LazyGit",
				},
				["w"] = {
					name = "Sessions",
				},
				["x"] = {
					name = "Trouble",
				},
			},
		})
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		window = {
			border = "rounded",
			position = "bottom",
			margin = { 1, 0, 1, 0 },
			padding = { 1, 0, 1, 0 },
		},
	},
}
