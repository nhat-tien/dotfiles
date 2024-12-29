if require("tien.core.setuplang").isNeed("java") then
	local config = {
		cmd = { "/home/nhattien/lsp/jdtls/bin/jdtls" },
		root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
		setting = {
			java = {
				-- Setup automatical package import oranization on file save
				saveActions = {
					organizeImports = true,
				},
				-- Customize completion options
				completion = {
					-- Set the order in which the language server should organize imports
					importOrder = {
						"java",
						"jakarta",
						"javax",
						"com",
						"org",
					},
				},
				codeGeneration = {
					-- When generating toString use a json format
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					-- When generating hashCode and equals methods use the java 7 objects method
					hashCodeEquals = {
						useJava7Objects = true,
					},
					-- When generating code use code blocks
					useBlocks = true,
				},
				-- enable code lens in the lsp
				referencesCodeLens = {
					enabled = true,
				},
				-- enable inlay hints for parameter names,
				inlayHints = {
					parameterNames = {
						enabled = "all",
					},
				},
			},
		},
		handlers = {
			["language/status"] = function(_, result)
				-- Print or whatever.
			end,
			-- ["$/progress"] = function(_, result, ctx)
			--    -- disable progress updates.
			-- end,
		},
		init_options = {
			bundles = {
				vim.fn.glob(
					"/home/nhattien/lsp/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
				),
			},
		},
		on_attach = function()
			-- Setup the java debug adapter of the JDTLS server
			-- require("jdtls.dap").setup_dap()

			-- Find the main method(s) of the application so the debug adapter can successfully start up the application
			-- Sometimes this will randomly fail if language server takes to long to startup for the project, if a ClassDefNotFoundException occurs when running
			-- the debug tool, attempt to run the debug tool while in the main class of the application, or restart the neovim instance
			-- Unfortunately I have not found an elegant way to ensure this works 100%
			-- require("jdtls.dap").setup_dap_main_class_configs()

			-- Enable jdtls commands to be used in Neovim
			require("jdtls.setup").add_commands()
		end,
	}

	require("jdtls").start_or_attach(config)
end
