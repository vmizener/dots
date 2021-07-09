-- Autoformat on write
vim.api.nvim_command([[
    autocmd BufWritePre *.py if exists(":Black") | silent execute ":Black" | endif
]])
