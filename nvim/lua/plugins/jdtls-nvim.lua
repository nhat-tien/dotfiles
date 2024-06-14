return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	ft = {
		"java",
	},
	config = function()
		local config = {
			cmd = { "/home/nhattien/lsp/jdtls/bin/jdtls" },
			root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
			init_options = {
				bundles = {
					vim.fn.glob(
						"/home/nhattien/lsp/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
						true
					),
				},
			},
		}
		require("jdtls").start_or_attach(config)
	end,
}
