return {
	"mfussenegger/nvim-jdtls",
   enabled = function ()
      return require("core.setup_lang").isNeed("java")
   end,
	ft = "java",
}
