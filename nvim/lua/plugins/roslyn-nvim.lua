-- return {}
return {
   "seblyng/roslyn.nvim",
   ft = { "cs", "razor" },
   dependencies = {
      "tris203/rzls.nvim",
      config = true,
   },
   opts = {},
   config = function()
      vim.lsp.enable("roslyn")
   end
}
