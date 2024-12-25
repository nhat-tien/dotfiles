return {
	"mfussenegger/nvim-jdtls",
   enabled = function ()
      return require("tien.core.setuplang").isNeed("java")
   end,
	ft = "java",
}
