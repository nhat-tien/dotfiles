return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	--
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = "default",
			-- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			-- ["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },

			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },

			-- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
			-- ["<C-f>"] = { "scroll_documentation_down", "fallback" },

			-- ["<Tab>"] = { "snippet_forward", "fallback" },
			-- ["<S-Tab>"] = { "snippet_backward", "fallback" },

			cmdline = {
				preset = "none",
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				--   ["<CR>"] = { "accept", "fallback" },
			},
		},
		completion = {
			list = {
            selection = {
               preselect = function(ctx)
                  return ctx.mode ~= "cmdline"
               end,
               auto_insert = function(ctx)
                  return ctx.mode == "cmdline"
               end
            }
			},
			menu = {
				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
		},
		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			-- use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "normal",
		},
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	opts_extend = { "sources.default" },
}
