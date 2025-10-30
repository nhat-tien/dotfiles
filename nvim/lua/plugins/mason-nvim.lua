-- return {}
return {
   "mason-org/mason.nvim",
   event = "BufReadPre",
   config = function()
      require("mason").setup({
         registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
         },
      })
   end,
}
