return {
  "ziontee113/icon-picker.nvim",
  config = function()
    require("icon-picker").setup({ disable_legacy_commands = true })

    local wk = require("which-key")
    wk.register({
      ["i"] ={ "<cmd>IconPicker<cr>", "Icon Picker" },
    }, { prefix = "<leader>" })

    wk.register({
      ["<C-e>"] = { "<cmd>IconPickerInsert<cr>", "Insert Icon" },
    }, { mode = "i" })
  end,
}
