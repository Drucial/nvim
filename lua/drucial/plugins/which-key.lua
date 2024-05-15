-- Configuration for folke/which-key.nvim
-- This configuration sets up the which-key.nvim plugin, which provides
-- a visual interface to help you discover and remember key mappings in Neovim.

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")

		wk.setup({
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
		})

		wk.register({
			["<leader>"] = {
				["+"] = { "<C-a>", "Increment number" },
				["-"] = { "<C-x>", "Decrement number" },
        ["c"] = { name = "+ Code" },
        ["g"] = {
          name = "+ Git",
          g = { "<cmd>LazyGit<cr>", "Open lazy git" },
        },
				["w"] = {
					name = "+ Workspace/Window",
					e = { "<C-w>=", "Make splits equal size" },
					h = { "<C-w>s", "Split window horizontally" },
					m = { "<cmd>MaximizerToggle<CR>", "Maximize/minimize a split" },
					v = { "<C-w>v", "Split window vertically" },
					x = { "<cmd>close<CR>", "Close current split" },
				},
				["r"] = { ":luafile %<CR>", "Source current Lua file" },
				["f"] = {
					x = { ":nohl<CR>", "Clear search highlights" },
				},
			},
			["x"] = { '"_x', "Delete character without yanking" },
		})
	end,
}
