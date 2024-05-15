-- Global colorscheme configuration
-- These colors will be used in the global colorscheme configuration.
-- They are utilized to set the colors of the dashboard and other elements.
-- The colors are set using the vim.api.nvim_set_hl functions.
--
-- Example:
--    vim.api.nvim_set_hl("Normal", "guibg=" .. colors.bg)
--    This sets the background color for Normal mode to the specified value.
--    You can adjust this example to set other colors or attributes as needed.

local colors = {
  bg = "#030517",
  bgAlt = "#1e2124",
  bgTransparent = "#030517" .. "00",
  bgHighlight = "#283037",
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

local highlights = {
  -- Global
  NormalFloat = { bg = colors.bg },
  FloatBorder = { bg = colors.bg, fg = colors.grey },
  Substitute = { bg= colors.bgHighlight, fg = colors.yellow },
  IncSearch = { bg = colors.bgHighlight, fg = colors.magenta },
  Search = { bg = colors.bgHighlight, fg = colors.magenta },
  CurSearch = { bg = colors.magenta, fg = colors.bgHighlight },

  -- LazyGit
  LazyGitFloat = { bg = colors.bg },
  LazyGitBorder = { fg = colors.grey },

  -- GitSigns
  GitSignsCurrentLineBlame = { fg = colors.grey },

  -- Telescope
  TelescopeNormal = { bg = colors.bg },
  TelescopeBorder = { bg = colors.bg, fg = colors.grey },

  -- nvim-tree
  NvimTreeRootFolder = { fg = colors.green },
  NvimTreeGitStagedIcon = { fg = colors.green },
  NvimTreeIndentMarker = { fg = colors.grey },
  NvimTreeModifiedIcon = { fg=colors.yellow },
  NvimTreeModifiedFileHL = { fg=colors.yellow },
  NvimTreeModifiedFolderHL = { fg=colors.yellow },

  NvimTreeDiagnosticErrorIcon = { fg = colors.red },
  NvimTreeDiagnosticWarnIcon = { fg = colors.yellow },
  NvimTreeDiagnosticInfoIcon = { fg = colors.blue },
  NvimTreeDiagnosticHintIcon = { fg = colors.cyan },

  NvimTreeDiagnosticErrorFileHL = { fg = colors.red },
  NvimTreeDiagnosticWarnFileHL = { fg = colors.yellow },
  NvimTreeDiagnosticInfoFileHL = { fg = colors.blue },
  NvimTreeDiagnosticHintFileHL = { fg = colors.cyan },
}

return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      borderless_telescope = false,
      terminal_colors = true,
      theme = {
        colors = colors,
      },
    })
    -- Set the colorscheme
    vim.cmd("colorscheme cyberdream")

    -- Apply highlight customizations
    for group, attrs in pairs(highlights) do
      local namespace = attrs.ns or 0
      vim.api.nvim_set_hl(namespace, group, attrs)
    end
  end,
  colors = colors,
}
