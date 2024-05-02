local colors = {
	bg = "#030517",
	bgAlt = "#1e2124",
	bgHighlight = "#3c4048",
	cursor = "#EDF2F6",
	fg = "#FFFFFF",
	grey = "#8894AD",
	blue = "#00C2FF",
	green = "#C0FE3D",
	cyan = "#69FEE3",
	red = "#FF4E4E",
	yellow = "#FEEC4B",
	magenta = "#FF3C77",
	pink = "#FF3CA6",
	orange = "#FFA620",
	purple = "#A347FF",
}

return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			-- Recommended - see "Configuring" below for more config options
			transparent = true,
			italic_comments = true,
			-- hide_fillchars = true,
			borderless_telescope = false,
			terminal_colors = true,
			theme = { colors = colors },
		})
		vim.cmd("colorscheme cyberdream") -- set the colorscheme
	end,
	colors = colors,
}
