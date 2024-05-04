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
    local keymap = vim.keymap

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for cwd" })
  end,
}
