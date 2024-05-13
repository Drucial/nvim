-- Telescope Configuration
-- This configuration sets up the telescope.nvim plugin, which provides a highly extensible
-- and customizable fuzzy finder for Neovim.

-- Default Keymaps:
--   - <C-k>: Move to the previous result.
--   - <C-j>: Move to the next result.
--   - <C-q>: Send selected results to the quickfix list and open the quickfix list window.

-- Custom Keymaps:
--   - <leader>ff: Fuzzy find files in the current working directory.
--   - <leader>fr: Fuzzy find recent files.
--   - <leader>fs: Find strings in the current working directory.
--   - <leader>fc: Find strings under the cursor in the current working directory.

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

    local wk = require("which-key")
    wk.register({
        ["f"] = {
          name = "+ Find",
          f = { "<cmd>Telescope find_files<cr>", "Find files in cwd" },
          r = { "<cmd>Telescope oldfiles<cr>", "Find recent files" },
          s = { "<cmd>Telescope live_grep<cr>", "Find string in cwd" },
          c = { "<cmd>Telescope grep_string<cr>", "Find string under cursor in cwd" },
          b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find string in buffer" },
        },
    }, { prefix = "<leader>" })
	end,
}
