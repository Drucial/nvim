-- Auto session configuration
-- This snippet configures the auto-session plugin to save and restore workspace sessions.
--
-- Keymaps:
--   - <leader>wr - Restore last workspace session for current directory
--   - <leader>ws - Save workspace session for current working directory

return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
		})

    local wk = require("which-key")
    wk.register({
      ["w"] = {
        name = "+ Workspace",
        r = { "<cmd>SessionRestore<CR>", "Restore last session" },
        s = { "<cmd>SessionSave<CR>", "Save session" },
      },
    }, { prefix = "<leader>"})
	end,
}
