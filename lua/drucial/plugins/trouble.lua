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
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
		{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
		{ "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
	},
}
