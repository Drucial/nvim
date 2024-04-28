return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		local colorscheme = require("drucial/plugins/colorscheme")
		local colors = colorscheme.colors

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.grey },
				c = { bg = colors.bg, fg = colors.grey },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.grey },
				c = { bg = colors.bg, fg = colors.grey },
			},
			visual = {
				a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.grey },
				c = { bg = colors.bg, fg = colors.grey },
			},
			command = {
				a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.grey },
				c = { bg = colors.bg, fg = colors.grey },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.grey },
				c = { bg = colors.bg, fg = colors.grey },
			},
			inactive = {
				a = { bg = colors.bg, fg = colors.grey, gui = "bold" },
				b = { bg = colors.bg, fg = colors.grey },
				c = { bg = colors.bg, fg = colors.grey },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
