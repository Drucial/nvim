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

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set(
      "n",
      "<leader>fsb",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      { desc = "Find string in buffer" }
    )
  end,
}
