" Autoformat on write
autocmd BufWritePre *.py if exists(":Black") | silent execute ":Black" | endif
