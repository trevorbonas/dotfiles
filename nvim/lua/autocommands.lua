local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
})

api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
    pattern = "*",
    callback = function()
        vim.cmd("normal! zR")
    end,
})
