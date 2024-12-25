local keymaps = require("tien.core.keymaps").keymaps
local user_command = require("tien.core.keymaps").user_command
local opts = require("tien.core.keymaps").opts
local leader = require("tien.core.keymaps").mapleader
local localleader = require("tien.core.keymaps").maplocalleader

vim.g.mapleader = leader
vim.g.maplocalleader = localleader

local function create_keymap(keymap_table)
	local list_of_mode = {
		normal = "n",
		insert = "i",
		visual = "x",
		terminal = "t",
	}
	for mode, mode_char in pairs(list_of_mode) do
		local list_of_keymap = keymap_table[mode]
		if list_of_keymap ~= nil then
			for _, keymap in pairs(list_of_keymap) do
				vim.keymap.set(
					mode_char,
					keymap.key,
					keymap.func,
					vim.tbl_deep_extend("keep", opts, { desc = keymap.desc })
				)
			end
		end
	end
end

local function create_user_cmd(keymap_table)
	for _, value in pairs(keymap_table) do
		vim.api.nvim_create_user_command(value.command, value.func, { desc = value.desc })
	end
end

create_keymap(keymaps)
create_user_cmd(user_command)

