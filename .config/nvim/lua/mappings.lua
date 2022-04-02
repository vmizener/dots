local utils = require('utils')
local map = utils.map

-- Hotkeys from plugins are assigned in plugins.lua
-- LSP hotkeys are in lsp.lua

-- Leader is space
utils.apply_globals({ mapleader = ' ' })

-- Editor Controls {{{
    -- Get to normal mode with `jk` or `<Space>`
    map('i', 'jk', '<Esc>', { noremap = true, silent = true })
    map('v', '<Space>', '<Esc>', { noremap = true, silent = true })
    -- Navigate wrapped lines
    map('n', 'j', 'gj', { noremap = true, silent = true })
    map('n', 'k', 'gk', { noremap = true, silent = true })
    -- Indentation with tab key
    map('n', '<Tab>', '>>_', { noremap = true, silent = true })
    map('n', '<S-Tab>', '<<', { noremap = true, silent = true })
    map('v', '<Tab>', '>gv', { noremap = true, silent = true })
    map('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
    -- Quickly close quickfix/loclist windows
    map('n', 'QQ', ':cclose | lclose<CR>', { noremap = true, silent = true })
-- }}}

-- Editor Behavior and Appearance {{{
    -- Center view on search results
    map('n', 'n', 'nzz', { noremap = true, silent = true })
    map('n', 'N', 'Nzz', { noremap = true, silent = true })
    -- Toggle line wrap
    map('n', '<Leader>w', ':set wrap! wrap?<CR>', { noremap = true, silent = true })
    -- Toggle paste mode
    utils.apply_options({ pastetoggle = '<F2>' })
    -- Toggle invisible characters
    map('n', '<Leader>I', ':set list! list?<CR>', { noremap = true, silent = true })
    -- Toggle spell check mode
    map('n', '<F3>', ':set spell! spell?<CR>', { noremap = true, silent = true })
    map('v', '<F3>', '<Esc>:set spell! spell?<CR>gv', { noremap = true, silent = true })
    -- Toggle folding
    map('n', 'z<Space>', 'za', { noremap = true, silent = true })
    map('v', 'z<Space>', 'za', { noremap = true, silent = true })
    -- Use system clipboard
    map('n', '<Leader>y', '"+y', { noremap = true, silent = true })
    map('v', '<Leader>y', '"+y', { noremap = true, silent = true })
    map('n', '<Leader>p', '"+p', { noremap = true, silent = true })
    map('v', '<Leader>p', '"+p', { noremap = true, silent = true })
-- }}}

-- Buffer Management {{{
    map('n', '<Leader>bp', ':bprev<CR>', { noremap = true, silent = true })
    map('n', '<Leader>bn', ':bnext<CR>', { noremap = true, silent = true })
    map('n', '<Leader>bb', ':b#<CR>', { noremap = true, silent = true })
    map('n', '<Leader>bd', ':lclose|bprev|bd #<CR>', { noremap = true })
    map('n', '<Leader>bk', ':lclose|bprev|bd! #<CR>', { noremap = true, silent = true })
-- }}}

-- File Management {{{
    -- Write as root
    map('c', 'w!!', 'w !sudo tee > /dev/null %<CR>')
    -- Open config
    map('n', '<Leader>ec', ':e $MYVIMRC<CR>', { noremap = true, silent = true})
    -- Source config
    map('n', '<Leader>sc', ':source $MYVIMRC<CR>', { noremap = true, silent = true})
-- }}}

-- Mouse Scroll Behavior {{{
    -- (Requires "mouse=a" option)
    --           Scroll Wheel = Up/Down 4 lines
    --   Shift + Scroll Wheel = Up/Down 1 page
    -- Control + Scroll Wheel = Up/Down half page
    --    Meta + Scroll Wheel = Up/Down 1 line
    map('n', '<ScrollWheelUp>',     '4<C-Y>',      { noremap = true, silent = true })
    map('n', '<ScrollWheelDown>',   '4<C-E>',      { noremap = true, silent = true })
    map('n', '<S-ScrollWheelUp>',   '<C-B>',       { noremap = true, silent = true })
    map('n', '<S-ScrollWheelDown>', '<C-F>',       { noremap = true, silent = true })
    map('n', '<C-ScrollWheelUp>',   '<C-U>',       { noremap = true, silent = true })
    map('n', '<C-ScrollWheelDown>', '<C-D>',       { noremap = true, silent = true })
    map('n', '<M-ScrollWheelUp>',   '<C-Y>',       { noremap = true, silent = true })
    map('n', '<M-ScrollWheelDown>', '<C-E>',       { noremap = true, silent = true })
    map('i', '<ScrollWheelUp>',     '<C-O>4<C-Y>', { noremap = true, silent = true })
    map('i', '<ScrollWheelDown>',   '<C-O>4<C-E>', { noremap = true, silent = true })
    map('i', '<S-ScrollWheelUp>',   '<C-O><C-B>',  { noremap = true, silent = true })
    map('i', '<S-ScrollWheelDown>', '<C-O><C-F>',  { noremap = true, silent = true })
    map('i', '<C-ScrollWheelUp>',   '<C-O><C-U>',  { noremap = true, silent = true })
    map('i', '<C-ScrollWheelDown>', '<C-O><C-D>',  { noremap = true, silent = true })
    map('i', '<M-ScrollWheelUp>',   '<C-O><C-Y>',  { noremap = true, silent = true })
    map('i', '<M-ScrollWheelDown>', '<C-O><C-E>',  { noremap = true, silent = true })
-- }}}


-- vim:foldmethod=marker
