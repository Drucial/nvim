vim.api.nvim_create_user_command("FormatAllFiles", function()
  vim.api.nvim_command("!find . -name '*.lua' -exec stylua -- {} +")
end, {})

vim.api.nvim_create_user_command("Qb", function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.cmd("q")
	if #vim.fn.win_findbuf(bufnr) == 0 then
		vim.cmd("bd " .. bufnr)
	end
end, {})
