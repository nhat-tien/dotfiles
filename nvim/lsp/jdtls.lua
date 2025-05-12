return {
   	handlers = {
   		["language/status"] = function(_, result)
   			-- Print or whatever.
   		end,
   		["$/progress"] = function(_, result, ctx)
   			-- disable progress updates.
   		end,
   	},
   	init_options = {
   		bundles = {
   			"/home/nhattien/lsp/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-<version>.jar",
   		},
   	},
}
