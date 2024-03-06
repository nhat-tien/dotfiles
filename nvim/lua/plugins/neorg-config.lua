return {
   load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.dirman"] = { -- Manages Neorg workspaces
         config = {
            workspaces = {
               notes = "~/NotesVaults/journal",
            },
         },
      },
      ["core.integrations.treesitter"] = {},
      ["core.integrations.nvim-cmp"] = {},
      ["core.completion"] = {
         config = {
            engine = "nvim-cmp",
         }
      },
   },
}
