return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			-- Recommended - see "Configuring" below for more config options
			transparent = true,
			italic_comments = true,
			hide_fillchars = true,
			borderless_telescope = true,
			terminal_colors = true,
			theme = {
				colors = {
					bg = "#030517", -- Updated to match the darker blue background
					bgAlt = "#1e2124", -- Kept as it is
					bgHighlight = "#3c4048", -- Kept as it is
					cursor = "#ffffff", -- Kept as it is
					fg = "#ffffff", -- Kept as it is
					grey = "#7b8496", -- Kept as it is
					blue = "#00FFFF", -- Kept as it is
					green = "#ecff8d", -- Updated to lean towards yellow
					cyan = "#5ef1ff", -- Kept as it is
					red = "#ff8272", -- Kept as it is
					yellow = "#ffbd5e", -- Updated to be more towards orange
					magenta = "#ff8ffd", -- Kept as it is
					pink = "#ff5ea0", -- Kept as it is
					orange = "#ffbd5e", -- Kept as it is
					purple = "#bd5eff", -- Kept as it is
				},
			},
		})
		vim.cmd("colorscheme cyberdream") -- set the colorscheme
	end,
}
