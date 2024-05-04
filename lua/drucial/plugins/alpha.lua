-- Alpha configuration
-- Alpha manages the dashboard and the lazy plugin loaders.

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	enabled = true,
	init = false,
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local colorscheme = require("drucial/plugins/colorscheme")
		local colors = colorscheme.colors

		-- Set colors for dashboard logos from global colorscheme
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = colors.pink })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = colors.magenta })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = colors.cyan })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = colors.magenta })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = colors.pink })

		-- Dashboard header art
		-- Visualization of dashboard.section.header.val:
		-- [[  Y88b Y88  888'Y88   e88 88e   Y88b Y88    Y8b Y88888P  888      e   e     ]]
		-- [[   Y88b Y8  888 ,'Y  d888 888b   Y88b Y8     Y8b Y888P   888     d8b d8b    ]]
		-- [[  b Y88b Y  888C8   C8888 8888D b Y88b Y      Y8b Y8P    888    e Y8b Y8b   ]]
		-- [[  8b Y88b   888 ",d  Y888 888P  8b Y88b        Y8b Y     888   d8b Y8b Y8b  ]]
		-- [[  88b Y88b  888,d88   "88 88"   88b Y88b        Y8P      888  d888b Y8b Y8b ]]

		dashboard.section.header.type = "group"
		dashboard.section.header.val = {
			{
				type = "text",
				val = [[  Y88b Y88  888'Y88   e88 88e   Y88b Y88    Y8b Y88888P  888      e   e     ]],
				opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = [[   Y88b Y8  888 ,'Y  d888 888b   Y88b Y8     Y8b Y888P   888     d8b d8b    ]],
				opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = [[  b Y88b Y  888C8   C8888 8888D b Y88b Y      Y8b Y8P    888    e Y8b Y8b   ]],
				opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = [[  8b Y88b   888 ",d  Y888 888P  8b Y88b        Y8b Y     888   d8b Y8b Y8b  ]],
				opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = [[  88b Y88b  888,d88   "88 88"   88b Y88b        Y8P      888  d888b Y8b Y8b ]],
				opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" },
			},
		}

		-- Dashboard buttons
		dashboard.section.buttons.val = {
			dashboard.button("e", " " .. " Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("s", " " .. " Restore Session", "<cmd>SessionRestore<cr>"),
			dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
			dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
			dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
			dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
			dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
			dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
		}

		-- Set highlights for dashboard
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end

		-- Set highlights for dashboard sections
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"
		dashboard.opts.layout[1].val = 8
		return dashboard
	end,

	-- Lazy configuration
	config = function(_, dashboard)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(dashboard.opts)

		-- Show lazy stats in the footer
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "⚡ Neovim loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
