-- Configuration for nvim-surround
-- This configuration sets up the nvim-surround plugin, which provides intuitive
-- mappings to quickly add, change, and delete surroundings in your code.

-- Plugin Functionality:
--   - Add, change, and delete surroundings such as parentheses, brackets, quotes, etc.
--   - Supports various types of surroundings, including single and double quotes, parentheses, brackets, etc.

-- Example Keymaps ( "*" denotes the cursor position ):
--   - surr*ound_words: Surround words with parentheses. Example: ysiw) (surround_words)
--   - *make strings: Make strings by surrounding text with double quotes. Example: ys$" "make strings"
--   - [delete ar*ound me!]: Delete text surrounding cursor within brackets. Example: ds] delete around me!
--   - remove <b>HTML t*ags</b>: Remove HTML tags around text. Example: dst remove HTML tags
--   - 'change quot*es': Change single quotes to double quotes. Example: cs'" "change quotes"
--   - <b>or tag* types</b>: Change text to h1 tag. Example: csth1<CR> <h1>or tag types</h1>
--   - delete(functi*on calls): Delete parentheses around text. Example: dsf delete function calls

return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = true,
}
