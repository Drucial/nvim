-- Nvim-Tree Configuration
-- This configuration sets up the nvim-tree.lua plugin, which provides a file explorer
-- sidebar for Neovim.

-- Keymaps:
--   - <leader>ee: Toggle file explorer
--   - <leader>ef: Toggle file explorer on current file
--   - <leader>ec: Collapse file explorer
--   - <leader>er: Refresh file explorer

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local function root_folder_label(root_cwd)
			local icon = "" -- Folder icon
			local folder_name = vim.fn.fnamemodify(root_cwd, ":t")
			local capitalized_folder_name = folder_name:sub(1, 1):upper() .. folder_name:sub(2)
			local full_label = icon .. " " .. capitalized_folder_name

			-- Get the current width of the nvim-tree window
			local tree_width = vim.api.nvim_win_get_width(0)
			local label_length = #full_label
			local padding = math.floor((tree_width - label_length) / 2)
			local spaces = string.rep(" ", math.max(0, padding))

			return spaces .. full_label
		end

		-- Update diagnostic highlight settings in NvimTree
		vim.cmd([[
      highlight NvimTreeRootFolder guifg=#c0fe3d
      highlight NvimTreeGitStagedIcon guifg=#c0fe3d
      highlight NvimCursorLine guifg=#1e1e1e

      highlight NvimTreeDiagnosticErrorIcon guifg=#ff4e4e
      highlight NvimTreeDiagnosticWarnIcon guifg=#feec4b
      highlight NvimTreeDiagnosticInfoIcon guifg=#00c2ff
      highlight NvimTreeDiagnosticHintIcon guifg=#69fee3

      highlight NvimTreeDiagnosticErrorFileHL guifg=#ff4e4e gui=none
      highlight NvimTreeDiagnosticWarnFileHL guifg=#feec4b gui=none
      highlight NvimTreeDiagnosticInfoFileHL guifg=#00c2ff gui=none
      highlight NvimTreeDiagnosticHintFileHL guifg=#69fee3 gui=none

      highlight NvimTreeDiagnosticErrorFolderHL guifg=#ff4e4e gui=none
      highlight NvimTreeDiagnosticWarnFolderHL guifg=#feec4b gui=none
      highlight NvimTreeDiagnosticInfoFolderHL guifg=#00c2ff gui=none
      highlight NvimTreeDiagnosticHintFolderHL guifg=#69fee3 gui=none
    ]])

		nvimtree.setup({
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			diagnostics = {
				enable = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			git = {
				enable = true,
				ignore = false,
			},
			hijack_cursor = true,
			modified = {
				enable = true,
			},
			renderer = {
				group_empty = true,
				highlight_diagnostics = "all",
				highlight_opened_files = "all",
				highlight_modified = "all",
				root_folder_label = root_folder_label,
				icons = {
					diagnostics_placement = "after",
					git_placement = "after",
					padding = " ",
					show = {
						folder_arrow = false,
						bookmarks = false,
						diagnostics = false,
						modified = false,
					},
					glyphs = {
						default = "",
						symlink = "",
						git = {
							unstaged = "*",
							staged = "+",
							unmerged = "⇡",
							renamed = "»",
							untracked = "?",
							deleted = "-",
							ignored = "◌",
						},
						folder = {
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
						},
					},
					web_devicons = {
						folder = {
							color = true,
						},
					},
				},
			},
			select_prompts = true,
			view = {
				cursorline = true,
				signcolumn = "no",
				width = {
					min = 25,
					max = 35,
					padding = 2,
				},
			},
		})

		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<C-n>f", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
		keymap.set("n", "<C-n>x", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<C-n>r", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
