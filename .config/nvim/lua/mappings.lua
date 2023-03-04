-- Hotkeys from plugins are assigned in plugins.lua
-- LSP hotkeys are in lsp.lua

-- Leader is space
vim.g['mapleader'] = ' '

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Plugins {{{
    -- SymbolsOutline
    map('n', '<Leader>ss', ':SymbolsOutline<CR>', opts)
    -- IndentLinesToggle
    map('n', '<Leader>i', ':IndentLinesToggle<CR>')
    -- Fugitive
    map('n', '<Leader>gd', ':Gdiffsplit!<CR>', opts)
    map('n', '<Leader>gD', '<C-w>h<C-w>c', opts)
    --map('n', '<Leader>gc', ':G commit<CR>', opts)
    map('n', '<Leader>gs', ':G status<CR>', opts)
    -- Gitsigns
    map('n', '<Leader>gj', ':Gitsigns next_hunk<CR>', opts)
    map('n', '<Leader>gk', ':Gitsigns prev_hunk<CR>', opts)
    -- Telescope
    map('n', '<Leader>ot', ':Telescope file_browser<CR>', opts)
    map('n', '<Leader>of', ':Telescope find_files hidden=true<CR>', opts)
    map('n', '<Leader>oF', ':Telescope find_files cwd=~ hidden=true<CR>', opts)
    map('n', '<Leader>og', ':Telescope live_grep<CR>', opts)
    map('n', '<Leader>ob', ':Telescope buffers<CR>', opts)
    map('n', '<Leader>oh', ':Telescope help_tags<CR>', opts)

    map('n', '<Leader>od', ':Telescope diagnostics<CR>', opts)
    map('n', '<Leader>ca', ':Telescope lsp_code_actions<CR>', opts)
    map('v', '<Leader>ca', ':Telescope lsp_range_code_actions<CR>', opts)
-- }}}

-- Editor Controls {{{
    -- Get to normal mode with `jk` or `<Space>`
    map('i', 'jk', '<Esc>', opts)
    map('v', '<Space>', '<Esc>', opts)
    -- Navigate wrapped lines
    map('n', 'j', 'gj', opts)
    map('n', 'k', 'gk', opts)
    -- Indentation with tab key
    map('n', '<Tab>', '>>_', opts)
    map('n', '<S-Tab>', '<<', opts)
    map('v', '<Tab>', '>gv', opts)
    map('v', '<S-Tab>', '<gv', opts)
    -- Quickly close quickfix/loclist windows
    map('n', 'QQ', ':cclose | lclose<CR>', opts)
-- }}}

-- Editor Behavior and Appearance {{{
    -- Center view on search results
    map('n', 'n', 'nzz', opts)
    map('n', 'N', 'Nzz', opts)
    -- Toggle line wrap
    map('n', '<Leader>w', ':set wrap! wrap?<CR>', opts)
    -- Toggle paste mode
    vim.o['pastetoggle'] = '<F2>'
    -- Toggle invisible characters
    map('n', '<Leader>I', ':set list! list?<CR>', opts)
    -- Toggle spell check mode
    map('n', '<F3>', ':set spell! spell?<CR>', opts)
    map('v', '<F3>', '<Esc>:set spell! spell?<CR>gv', opts)
    -- Toggle folding
    map('n', 'z<Space>', 'za', opts)
    map('v', 'z<Space>', 'za', opts)
    -- Use system clipboard
    map('x', '<Leader>y', require('osc52').copy_visual)
    map('n', '<Leader>p', '"+p', opts)
    map('v', '<Leader>p', '"+p', opts)
-- }}}

-- Buffer Management {{{
    map('n', '<Leader>bp', ':bprev<CR>', opts)
    map('n', '<Leader>bn', ':bnext<CR>', opts)
    map('n', '<Leader>bb', ':b#<CR>', opts)
    map('n', '<Leader>bd', ':lclose|bprev|bd #<CR>', opts)
    map('n', '<Leader>bk', ':lclose|bprev|bd! #<CR>', opts)
-- }}}

-- File Management {{{
    -- Write as root
    vim.cmd([[cnoreabbrev w!! lua utils.sudo_write()]])
    -- Open config
    map('n', '<Leader>ec', ':e $MYVIMRC<CR>', opts)
    -- Source config
    map('n', '<Leader>sc', ':source $MYVIMRC<CR>', opts)
-- }}}

-- Mouse Scroll Behavior {{{
    -- (Requires "mouse=a" option)
    --           Scroll Wheel = Up/Down 4 lines
    --   Shift + Scroll Wheel = Up/Down 1 page
    -- Control + Scroll Wheel = Up/Down half page
    --    Meta + Scroll Wheel = Up/Down 1 line
    map('n', '<ScrollWheelUp>',     '4<C-Y>',      opts)
    map('n', '<ScrollWheelDown>',   '4<C-E>',      opts)
    map('n', '<S-ScrollWheelUp>',   '<C-B>',       opts)
    map('n', '<S-ScrollWheelDown>', '<C-F>',       opts)
    map('n', '<C-ScrollWheelUp>',   '<C-U>',       opts)
    map('n', '<C-ScrollWheelDown>', '<C-D>',       opts)
    map('n', '<M-ScrollWheelUp>',   '<C-Y>',       opts)
    map('n', '<M-ScrollWheelDown>', '<C-E>',       opts)
    map('i', '<ScrollWheelUp>',     '<C-O>4<C-Y>', opts)
    map('i', '<ScrollWheelDown>',   '<C-O>4<C-E>', opts)
    map('i', '<S-ScrollWheelUp>',   '<C-O><C-B>',  opts)
    map('i', '<S-ScrollWheelDown>', '<C-O><C-F>',  opts)
    map('i', '<C-ScrollWheelUp>',   '<C-O><C-U>',  opts)
    map('i', '<C-ScrollWheelDown>', '<C-O><C-D>',  opts)
    map('i', '<M-ScrollWheelUp>',   '<C-O><C-Y>',  opts)
    map('i', '<M-ScrollWheelDown>', '<C-O><C-E>',  opts)
-- }}}


-- vim:foldmethod=marker
