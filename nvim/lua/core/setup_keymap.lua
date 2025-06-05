local keymaps = require("config.keymaps").keymaps
local user_command = require("config.keymaps").user_command
local opts = require("config.keymaps").opts
local leader = require("config.keymaps").mapleader
local localleader = require("config.keymaps").maplocalleader

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
					keymap.fn,
					vim.tbl_deep_extend("force", opts, {
                  desc = keymap.desc,
                  remap = keymap.remap,
               })
				)
			end
		end
	end
end

local function create_user_cmd(keymap_table)
	for _, value in pairs(keymap_table) do
		vim.api.nvim_create_user_command(value.command, value.fn, { desc = value.desc })
	end
end

create_keymap(keymaps)
create_user_cmd(user_command)

