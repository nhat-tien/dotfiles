
require('config.autocmd.highlight_yank')
require('config.autocmd.restore_position_in_last_time_edit')
-- no auto continue comments on new line
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
-- 	callback = function()
-- 		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
-- 	end,
-- })

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "active_cursorline",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local pos = vim.api.nvim_win_get_cursor(0)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local modified = false

        for i, line in ipairs(lines) do
            local trimmed = line:gsub("%s+$", "")
            if trimmed ~= line then
                lines[i] = trimmed
                modified = true
            end
        end

        if modified then
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        end

        vim.api.nvim_win_set_cursor(0, pos)
    end,
})
require('config.autocmd.virtualtext_for_heading')
