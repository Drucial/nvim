local function configure()
	local dashboard = require("alpha.themes.dashboard")
	local colorscheme = require("drucial/plugins/colorscheme")

	-- Now you can access the colors table
	local colors = colorscheme.colors

	-- Define custom highlight groups with colors from your theme
	vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = colors.blue })
	vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = colors.green })
	vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = colors.cyan })
	vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = colors.green })
	vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = colors.blue })

	dashboard.section.header.type = "group"
	dashboard.section.header.val = {
		{
			type = "text",
			val = [[  Y88b Y88  888'Y88   e88 88e   Y88b Y88  ]],
			opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" },
		},
		{
			type = "text",
			val = [[   Y88b Y8  888 ,'Y  d888 888b   Y88b Y8  ]],
			opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" },
		},
		{
			type = "text",
			val = [[  b Y88b Y  888C8   C8888 8888D b Y88b Y  ]],
			opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" },
		},
		{
			type = "text",
			val = [[  8b Y88b   888 ",d  Y888 888P  8b Y88b   ]],
			opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" },
		},
		{
			type = "text",
			val = [[  88b Y88b  888,d88   "88 88"   88b Y88b  ]],
			opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" },
		},
		-- [[-------------  *  --------------]],
		-- [[ Y8b Y88888P  888      e   e     ]],
		-- [[  Y8b Y888P   888     d8b d8b    ]],
		-- [[   Y8b Y8P    888    e Y8b Y8b   ]],
		-- [[    Y8b Y     888   d8b Y8b Y8b  ]],
		-- [[     Y8P      888  d888b Y8b Y8b ]],
	}

	dashboard.section.buttons.val = {
		dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
		dashboard.button("g", "󰷾 " .. " Find text", ":Telescope live_grep <CR>"),
		dashboard.button("b", " " .. " File browser", ":NvimTreeFocus <CR>"),
		dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
		dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
		dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
		dashboard.button("q", " " .. " Quit", ":qa<CR>"),
	}

	return dashboard.config
end

return {
	"goolord/alpha-nvim",
	lazy = true,
	event = "VimEnter",
	config = function(_, dashboard)
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(configure())
	end,
}
