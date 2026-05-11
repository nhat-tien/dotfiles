local ns_id = vim.api.nvim_create_namespace("vh_markdown_headers")

local function check_markdown_line_extmark(bufnum, linenum, linestr)
    if linestr:match("^#") then
        vim.api.nvim_buf_set_extmark(bufnum, ns_id, linenum, 0, {
            virt_lines = { {} },
            virt_lines_above = true,
        })

    elseif linestr:match("^- ") or linestr:match("^[ ]*- ") then
        vim.api.nvim_buf_set_extmark(bufnum, ns_id, linenum, 0, {
            virt_text = { {"  ", ""} },
            virt_text_pos = "inline",
            -- sign_text = "a"
        })
    end
end
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "markdown",
    callback = function(args)
        vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

        local lines = vim.api.nvim_buf_get_lines(args.buf, 1, -1, false)
        for i, line in ipairs(lines) do
            check_markdown_line_extmark(args.buf, i, line)
        end
    end,
})

vim.api.nvim_create_autocmd({"TextChanged", "InsertLeave"}, {
    pattern = "*.md",
    callback = function(args)
        local curlinenum = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_clear_namespace(0, ns_id, curlinenum-1, curlinenum)

        check_markdown_line_extmark(args.buf, curlinenum-1, vim.fn.getline("."))
    end,
})