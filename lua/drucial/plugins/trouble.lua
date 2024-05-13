-- Configuration for folke/trouble.nvim
-- This configuration sets up the trouble.nvim plugin, which provides a comprehensive
-- interface for managing and navigating diagnostics, quickfix lists, and more.
--
-- Keymaps:
--  - <leader>xx: Open/close trouble list
--  - <leader>xw: Open trouble workspace diagnostics
--  - <leader>xd: Open trouble document diagnostics
--  - <leader>xq: Open trouble quickfix list
--  - <leader>xl: Open trouble location list
--  - <leader>xt: Open todos in trouble

return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	config = function()
		require("trouble").setup({
			auto_preview = false,
			auto_fold = true,
			auto_close = true,
			use_diagnostic_signs = true,
		})

		local wk = require("which-key")
		wk.register({
			["x"] = {
				name = "+ Trouble",
				x = { "<cmd>TroubleToggle<CR>", "Open trouble list" },
				w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Open trouble workspace diagnostics" },
				d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Open trouble document diagnostics" },
				q = { "<cmd>TroubleToggle quickfix<CR>", "Open trouble quickfix list" },
				l = { "<cmd>TroubleToggle loclist<CR>", "Open trouble location list" },
				t = { "<cmd>TodoTrouble<CR>", "Open todos in trouble" },
			},
		}, { prefix = "<leader>" })
	end,
}
