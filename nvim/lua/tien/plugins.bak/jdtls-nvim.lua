return {
	"mfussenegger/nvim-jdtls",
   enabled = function ()
      return require("tien.core.setup_lang").isNeed("java")
   end,
	ft = "java",
}
