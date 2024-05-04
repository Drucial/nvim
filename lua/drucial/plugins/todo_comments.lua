-- Todo Comments Configuration
-- This configuration sets up the todo-comments.nvim plugin, which enhances the workflow
-- by providing functionality related to managing and navigating through TODO comments
-- within your codebase.

-- Keymaps:
--   - ]t: Moves the cursor to the next TODO comment.
--   - [t: Moves the cursor to the previous TODO comment.

return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local todo_comments = require("todo-comments")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "]t", function()
			todo_comments.jump_next()
		end, { desc = "Next todo comment" })

		keymap.set("n", "[t", function()
			todo_comments.jump_prev()
		end, { desc = "Previous todo comment" })

		todo_comments.setup()
	end,
}
