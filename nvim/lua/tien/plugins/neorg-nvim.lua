return {
	"nvim-neorg/neorg",
	ft = "norg",
	cmd = "Neorg",
	dependencies = {
		{
			"nvim-neorg/lua-utils.nvim",
			lazy = true,
		},
		{
			"pysan3/pathlib.nvim",
			lazy = true,
		},
	},
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {
					config = {
						icon_preset = "varied",
						icons = {
							delimiter = {
								horizontal_line = {
									highlight = "@neorg.delimiters.horizontal_line",
								},
							},
							code_block = {
								-- If true will only dim the content of the code block (without the
								-- `@code` and `@end` lines), not the entirety of the code block itself.
								content_only = true,

								-- The width to use for code block backgrounds.
								--
								-- When set to `fullwidth` (the default), will create a background
								-- that spans the width of the buffer.
								--
								-- When set to `content`, will only span as far as the longest line
								-- within the code block.
								width = "content",

								-- Additional padding to apply to either the left or the right. Making
								-- these values negative is considered undefined behaviour (it is
								-- likely to work, but it's not officially supported).
								padding = {
									-- left = 20,
									-- right = 20,
								},

								-- If `true` will conceal (hide) the `@code` and `@end` portion of the code
								-- block.
								conceal = true,

								nodes = { "ranged_verbatim_tag" },
								highlight = "CursorLine",
								-- render = module.public.icon_renderers.render_code_block,
								insert_enabled = true,
							},
						},
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/NotesVaults/mainVault/Neorg-note/",
						},
						default_workspace = "notes",
					},
				},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.integrations.nvim-cmp"] = {},
			},
		})
	end,
}
