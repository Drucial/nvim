-- Configuration for szw/vim-maximizer
-- This configuration sets up the vim-maximizer plugin, which allows you to
-- easily maximize and minimize splits within Neovim.
--
-- Keymaps:
--  - <leader>sm: Maximize/minimize a split

return {
	"szw/vim-maximizer",
	keys = {
		{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
	},
}
