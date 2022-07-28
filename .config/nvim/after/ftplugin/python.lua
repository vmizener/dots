-- Autoformat on write
vim.api.nvim_create_augroup('PythonConfig', {})
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.py',
    callback = function ()
        if vim.fn.exists(":Black") then
            vim.cmd('silent execute ":Black"')
        end
    end,
    group = 'PythonConfig'
})
--    -- Warn if python is missing required package
--    vim.fn.system({'pip', 'show', 'black'})
--    if vim.v['shell_error'] == 1 then
--        vim.api.nvim_echo({{"Python is missing 'black' package; install with `pip install black`", "WarningMsg"}}, true, {})
--    end
