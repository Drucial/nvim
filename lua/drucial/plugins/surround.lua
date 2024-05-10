-- Configuration for nvim-surroun
-- This configuration sets up the nvim-surround plugin, which provides intuitive
-- mappings to quickly add, change, and delete surroundings in your code.

-- Plugin Functionality:
--   - Add, change, and delete surroundings such as parentheses, brackets, quotes, etc.
--   - Supports various types of surroundings, including single and double quotes, parentheses, brackets, etc.

-- Keymaps:
--   - <leader>tw: Surround word with a tag
--     Example: surround*ing -> <leader>twp -> <p>surrounding</p>
--
--   - <leader>tl: Surround entire line with a tag
--     Example: *this is a line -> <leader>tlp -> <p>this is a line</p>
--
--   - <leader>ts: Surround to line end
--     Example: this is a *string -> <leader>ts" -> "this is a string"
--
--   - <leader>td: Delete surrounding
--     Example: (delete* this) -> <leader>td) -> delete this
--
--   - <leader>tq: Change surrounding
--     Example: 'old* text' -> <leader>tq"' -> "old text"
--
--   - <leader>tt: Change surrounding tag/type
--     Example: <p>HTML* content</p> -> <leader>ttdiv -> <div>HTML content</div>
--
--   - <leader>tlt: Surround entire line tightly
--     Example: *this is a whole line -> <leader>tlt# -> #this is a whole line#
--
--   - <leader>tpt: Surround paragraph with a tag and indent
--     Example: *a paragraph -> <leader>tptp -> <p>
--                                       a paragraph
--                                      </p>
--   - <leader>tst in visual mode: Surround selection with a tag
--     Example: Select "this text", press <leader>tstt -> <t>this text</t>

return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = function()
		require("nvim-surround").setup()

		vim.cmd([[
      nmap <leader>tw ysiw
      nmap <leader>tl yss
      nmap <leader>ts ys$
      nmap <leader>td ds
      nmap <leader>tq cs
      nmap <leader>tt cst
      nmap <leader>tlt ysst
      nmap <leader>tpt ySipt
      vmap <leader>tst St
    ]])

		-- Setup which-key descriptions
		local wk = require("which-key")
		wk.register({
			["t"] = {
				name = "+Surround", -- Group name for all surround-related mappings
				w = "Wrap word in specified character",
				l = "Surround entire line with specified character",
				s = "Surround to line end with specified character",
				d = "Delete surrounding characters/tags",
				q = "Change surrounding characters/tags",
				t = "Change surrounding tag/type",
				lt = "Surround entire line tightly with specified character",
				pt = "Surround paragraph with tag and indent",
				st = "Surround selection with specified tag in visual mode",
			},
		}, { prefix = "<leader>" })
	end,
}
