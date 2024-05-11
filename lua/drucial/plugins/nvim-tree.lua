-- Nvim-Tree Configuration
-- This configuration sets up the nvim-tree.lua plugin, which provides a file explorer
-- sidebar for Neovim.

-- Keymaps:
--   - <C-n>: Toggle file explorer
--   - <leader>ef: Toggle file explorer on current file
--   - <leader>ex: Collapse file explorer
--   - <leader>er: Refresh file explorer

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

    -- Update diagnostic highlight settings in NvimTree
    vim.cmd([[
      highlight NvimTreeRootFolder guifg=#c0fe3d
      highlight NvimTreeGitStagedIcon guifg=#c0fe3d
      highlight NvimCursorLine guifg=#ffffff

      highlight NvimTreeDiagnosticErrorIcon guifg=#ff4e4e
      highlight NvimTreeDiagnosticWarnIcon guifg=#feec4b
      highlight NvimTreeDiagnosticInfoIcon guifg=#00c2ff
      highlight NvimTreeDiagnosticHintIcon guifg=#69fee3

      highlight NvimTreeDiagnosticErrorFileHL guifg=#ff4e4e gui=none
      highlight NvimTreeDiagnosticWarnFileHL guifg=#feec4b gui=none
      highlight NvimTreeDiagnosticInfoFileHL guifg=#00c2ff gui=none
      highlight NvimTreeDiagnosticHintFileHL guifg=#69fee3 gui=none

      highlight NvimTreeDiagnosticErrorFolderHL guifg=#ff4e4e gui=none
      highlight NvimTreeDiagnosticWarnFolderHL guifg=#feec4b gui=none
      highlight NvimTreeDiagnosticInfoFolderHL guifg=#00c2ff gui=none
      highlight NvimTreeDiagnosticHintFolderHL guifg=#69fee3 gui=none
    ]])

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
      hijack_cursor = true,
      modified = {
        enable = true,
      },
      renderer = {
        group_empty = true,
        highlight_diagnostics = "all",
        highlight_opened_files = "all",
        highlight_modified = "all",
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
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
            },
          },
          web_devicons = {
            folder = {
              color = true,
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

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", {})
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", {})
    keymap.set("n", "<leader>ex", "<cmd>NvimTreeCollapse<CR>", {})
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", {})

    local wk = require("which-key")
    wk.register({
      ["e"] = {
        name = "+NvimTree",
        f = { "<cmd>NvimTreeFindFile<CR>", "Open explorer on file" },
        x = { "<cmd>NvimTreeCollapse<CR>", "Collapse explorer" },
        r = { "<cmd>NvimTreeRefresh<CR>", "Refresh explorer" },
      },
    }, { prefix = "<leader>" })
  end,
}
