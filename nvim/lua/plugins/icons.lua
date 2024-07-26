return {
    "ziontee113/icon-picker.nvim",
   lazy = true,
   cmd = {
      "IconPickerYank"
   },
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })
    end
}
