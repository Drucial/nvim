-- Lualine Configuration
-- This configuration sets up the lualine.nvim plugin, which provides a customizable
-- statusline for Neovim.
--
-- Lualine Sections:
--   a: Displays the current mode, such as Normal, Insert, Visual, etc.
--   b: Displays the current git repository name and branch, limited to 20 characters.
--   c: Additional buffer information, such as line number, column number, etc.
--   x: Custom section to display lazy updates count, file size, and file type.
--      - filesize: Displays the size of the current file.
--      - filetype: Displays the file type (e.g., lua, python).

local cached_git_repo = nil

local git_repo = function()
  if cached_git_repo ~= nil then
    return cached_git_repo
  end

  local output = vim.fn.systemlist("git rev-parse --show-toplevel")
  if vim.tbl_isempty(output) then
    cached_git_repo = ""
  else
    cached_git_repo = vim.fn.fnamemodify(output[1], ":t")
  end

  return cached_git_repo
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local colorscheme = require("drucial/plugins/colorscheme")
    local colors = colorscheme.colors

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.cyan, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bgAlt, fg = colors.grey },
        c = { bg = colors.bg, fg = colors.grey },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bgAlt, fg = colors.grey },
        c = { bg = colors.bg, fg = colors.grey },
      },
      visual = {
        a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bgAlt, fg = colors.grey },
        c = { bg = colors.bg, fg = colors.grey },
      },
      command = {
        a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bgAlt, fg = colors.grey },
        c = { bg = colors.bg, fg = colors.grey },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bgAlt, fg = colors.grey },
        c = { bg = colors.bg, fg = colors.grey },
      },
      inactive = {
        a = { bg = colors.bg, fg = colors.grey, gui = "bold" },
        b = { bg = colors.bgAlt, fg = colors.grey },
        c = { bg = colors.bg, fg = colors.grey },
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
        component_separators = { left = "⟩", right = "⟨" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { git_repo, "branch", {
          "filename",
          path = 4,
        } },
        lualine_c = { "diff", "diagnostics" },
        lualine_x = { "filesize" },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
    })
  end,
}
