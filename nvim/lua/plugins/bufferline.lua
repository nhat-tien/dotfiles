return {
   "akinsho/bufferline.nvim",
   event = "BufReadPre",
   enabled = true,
   version = "*",
   dependencies = "nvim-tree/nvim-web-devicons",
   opts = {
      options = {
         offsets = {
            {
               filetype = "NvimTree",
               text = "File Explorer",
               highlight = "Directory",
               separator = true, -- use a "true" to enable the default, or set your own character
            },
         },
         indicator = {
            style = "none",
         },
         diagnostics = "nvim_lsp",
         diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
               local sym = e == "error" and " " or (e == "warning" and " " or "")
               s = s .. n .. sym
            end
            return s
         end,
      },
   }
}
