return {
    "bngarren/checkmate.nvim",
    ft = "mdtodo", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
        -- your configuration here
        -- or leave empty to use defaults
        metadata = {
         due = {
            style = { fg = "#ed1a1a"
            }
         }
      }
    },

}
