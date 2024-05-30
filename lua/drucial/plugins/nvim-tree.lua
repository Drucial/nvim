-- Nvim-Tree Configuration
-- This configuration sets up the nvim-tree.lua plugin, which provides a file explorer
-- sidebar for Neovim.

local function root_folder_label(root_cwd)
  local icon = "" -- Folder icon
  local folder_name = vim.fn.fnamemodify(root_cwd, ":t")
  folder_name = folder_name:gsub("[-_]", " ")

  local capitalized_folder_name = folder_name:gsub("(%a)([%w]*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)

  return icon .. " " .. capitalized_folder_name
end

local function start_cursor_on_second_line()
  vim.defer_fn(function()
    local bufname = vim.fn.bufname()
    if string.find(bufname, "NvimTree_") then
      vim.api.nvim_win_set_cursor(0, { 2, 0 })
    end
  end, 100)
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local nvim_tree_api = require("nvim-tree.api")
    local Event = nvim_tree_api.events.Event

    nvim_tree_api.events.subscribe(Event.TreeOpen, function()
      start_cursor_on_second_line()
    end)

    nvimtree.setup({
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      git = {
        enable = true,
        ignore = false,
      },
      filters = {
        enable = true,
        custom = {
          "node_modules",
          "^.git$",
          ".pytest_cache",
          ".idea",
          ".DS_Store",
          "venv",
          ".venv",
          "env",
          "__pycache__",
          "*.swp",
          "*.swo",
          "*.bak",
          "*.tmp",
          "logs",
          "*.log",
          "cache",
        },
      },
      hijack_cursor = true,
      modified = {
        enable = true,
      },
      renderer = {
        group_empty = true,
        highlight_diagnostics = "all",
        highlight_opened_files = "all",
        highlight_modified = "all",
        indent_markers = {
          enable = true,
          inline_arrows = false,
          icons = {
            corner = "⎩",
            edge = "⎥",
            item = "⎬",
            bottom = "─",
            none = " ",
          },
        },
        root_folder_label = root_folder_label,
        icons = {
          diagnostics_placement = "after",
          git_placement = "after",
          padding = " ",
          show = {
            folder_arrow = false,
            bookmarks = false,
            diagnostics = false,
            modified = false,
          },
          glyphs = {
            default = "",
            symlink = "",
            git = {
              unstaged = "*",
              staged = "+",
              unmerged = "⇡",
              renamed = "»",
              untracked = "?",
              deleted = "-",
              ignored = "◌",
            },
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
            },
          },
          web_devicons = {
            folder = {
              color = false,
            },
          },
        },
      },
      select_prompts = true,
      view = {
        cursorline = true,
        signcolumn = "no",
        width = {
          min = 25,
          max = 35,
          padding = 2,
        },
      },
    })

    local wk = require("which-key")
    wk.register({
      ["n"] = {
        name = "+ Nav",
        f = { "<cmd>NvimTreeFindFile<CR>", "Open nav on file" },
        x = { "<cmd>NvimTreeCollapse<CR>", "Collapse nav" },
        r = { "<cmd>NvimTreeRefresh<CR>", "Refresh nav" },
      },
    }, { prefix = "<leader>" })

    wk.register({
      ["<C-n>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle nav" },
    })
  end,
}
