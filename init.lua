require("drucial.core")
require("drucial.init")
-- Define a global function to format all Lua files with stylua
_G.format_all_files = function()
	vim.api.nvim_command("!find . -name '*.lua' -exec stylua -- {} +")
end

-- Define a command to trigger the global function
vim.cmd("command! FormatAllFiles lua format_all_files()")
