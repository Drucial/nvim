-- Configuration for nvim-surroun
-- This configuration sets up the nvim-surround plugin, which provides intuitive
-- mappings to quickly add, change, and delete surroundings in your code.

return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = function()
		require("nvim-surround").setup()
		vim.cmd([[
      nmap <leader>sw ysiw
      nmap <leader>sl yss
      nmap <leader>slt ysst
      nmap <leader>se ys$
      nmap <leader>set ys$t
      nmap <leader>sp ysip
      nmap <leader>spt ySipt
      nmap <leader>sd ds
      nmap <leader>sc cs
      nmap <leader>sct cst
      vmap <leader>st St
      vmap <leader>ss S
    ]])

		local wk = require("which-key")
		wk.register({
			["s"] = {
				name = "+ Surround",
				w = "Surround word with characters",
				["l"] = {
          name = "+ Surround line with characters/tag",
          t = "Surround entire line with tag",
        },
				e = "Surround to line end with characters",
        ["p"] = {
          name = "+ Surround paragraph with character/tag",
          t = "Surround paragraph with tag",
        },
				d = "Delete surrounding characters/tags",
				["c"] = {
          name = "+ Change surrounding characters/tag",
          t = "Change surrounding tag",
        },
			},
		}, { prefix = "<leader>" })

    wk.register({
      ["s"] = {
        name = "+ Surround selection with specified character",
        t = { "Surround selection with tag" },
      }
    }, { prefix = "<leader>", mode = "v" })
	end,
}
