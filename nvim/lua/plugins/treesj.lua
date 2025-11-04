return {
   "Wansmer/treesj",
   keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
   },
   opts = {
   },
   config = function()
      local lang_utils = require('treesj.langs.utils')

      local langs = {
         c_sharp = {
            argument_list = lang_utils.set_preset_for_args(),
            attribute_argument_list = lang_utils.set_preset_for_args(),
            parameter_list = lang_utils.set_preset_for_args(),
            initializer_expression = lang_utils.set_preset_for_list(),
            element_binding_expression = lang_utils.set_preset_for_list(),
            block = lang_utils.set_preset_for_statement(),
         },
      }

      require("treesj").setup({
         use_default_keymaps = false,
         max_join_length = 150,
         langs = langs
      })
   end
}
