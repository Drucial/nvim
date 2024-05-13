-- Configuration for gitsigns.lua
-- This configuration sets up the gitsigns.nvim plugin, which provides
-- Git signs (additions, changes, deletions) in the sign column and commands
-- to stage and reset hunks.

-- Keymaps:
--   - ]h: Navigate to the next hunk
--   - [h: Navigate to the previous hunk
--   - <leader>hs: Stage the current hunk
--   - <leader>hr: Reset the current hunk
--   - <leader>hS: Stage all hunks in the current buffer
--   - <leader>hR: Reset all hunks in the current buffer
--   - <leader>hu: Undo staging of the current hunk
--   - <leader>hp: Preview changes in the current hunk
--   - <leader>hb: Blame the line under the cursor
--   - <leader>hB: Toggle line blame for the current line
--   - <leader>hd: Diff the current changes
--   - <leader>hD: Diff the current changes against the previous version
--   - ih: Select the current hunk

local current_line_blame_formatter = function(name, blame_info)
	if blame_info.author == name then
		blame_info.author = "You"
	end

	local text
	if blame_info.author == "Not Committed Yet" then
		text = "Not Committed Yet"
	else
		local current_time = os.time()
		local time_difference = current_time - blame_info["author_time"]
		local date_string
		if time_difference >= 14 * 24 * 60 * 60 then
			date_string = os.date("%b %d", blame_info["author_time"])
			local current_year = tonumber(os.date("%Y", current_time))
			local author_year = tonumber(os.date("%Y", blame_info["author_time"]))
			if current_year ~= author_year then
				date_string = date_string .. ", " .. author_year
			end
		else
			date_string = vim.fn.strftime("%b %d", blame_info["author_time"])
		end
		text = blame_info.author .. " on " .. date_string .. " -> " .. blame_info.summary
	end

	return { { " " .. text, "GitSignsCurrentLineBlame" } }
end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		preview_config = {
			border = "rounded",
		},
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
		},
		current_line_blame_formatter = current_line_blame_formatter,
		current_line_blame_formatter_opts = {
			relative_time = true,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

      local wk = require("which-key")
      wk.register({
          ["g"] = {
            name = "+ Git",
            s = { gs.stage_hunk, "Stage hunk" },
            r = { gs.reset_hunk, "Reset hunk" },
            S = { gs.stage_buffer, "Stage buffer" },
            R = { gs.reset_buffer, "Reset buffer" },
            u = { gs.undo_stage_hunk, "Undo stage hunk" },
            p = { gs.preview_hunk, "Preview hunk" },
            b = { gs.blame_line, "Blame line" },
            B = { gs.toggle_current_line_blame, "Toggle line blame" },
            d = { gs.diffthis, "Diff this" },
            D = { gs.diffthis("~"), "Diff this ~" },
          },
      }, { prefix = "<leader>", buffer = bufnr })

      wk.register({
          ["g"] = {
            name = "+ Git",
            s = { gs.stage_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          }), "Stage hunk" },
            r = { gs.reset_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          }), "Reset hunk" },
          },
      }, {prefix = "<leader>", mode = "v", buffer = bufnr })
			-- Navigation
			map("n", "]h", gs.next_hunk, "Next Hunk")
			map("n", "[h", gs.prev_hunk, "Prev Hunk")
			--
			-- -- Actions
			-- map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			-- map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			-- map("v", "<leader>hs", function()
			-- 	gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			-- end, "Stage hunk")
			-- map("v", "<leader>hr", function()
			-- 	gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			-- end, "Reset hunk")
			--
			-- map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
			-- map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
			-- map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
			-- map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			-- map("n", "<leader>hb", function()
			-- 	gs.blame_line({ full = true })
			-- end, "Blame line")
			-- map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
			-- map("n", "<leader>hd", gs.diffthis, "Diff this")
			-- map("n", "<leader>hD", function()
			-- 	gs.diffthis("~")
			-- end, "Diff this ~")
			--
			-- -- Text object
			-- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
		end,
	},
}
