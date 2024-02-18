-- LSP hotkeys are in lsp.lua
local utils = require("utils")
utils.set_map_opts({noremap=true, silent=true})

-- Leader is space
vim.g['mapleader'] = ' '

-- Plugins {{{
    -- Comment
    -- (note that CTRL+/ is equivalent to C-_ in some terminals)
    utils.map('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)', '[Comment] Toggle commenting of current line')
    utils.map('v', '<C-/>', '<Plug>(comment_toggle_linewise_visual)', '[Comment] Toggle commenting of current lines')
    utils.map('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', '[Comment] Toggle commenting of current line')
    utils.map('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', '[Comment] Toggle commenting of current lines')
    -- SymbolsOutline
    utils.map('n', '<Leader>ss', ':SymbolsOutline<CR>', '[SymbolsOutline] Toggle symbols outline pane')
    -- IndentLinesToggle
    utils.map('n', '<Leader>i', ':IndentLinesToggle<CR>', '[IndentLines] Toggle indentation guide')
    -- Fugitive
    utils.map('n', '<Leader>gd', ':Gdiffsplit!<CR>', '[Git] View diff in a split')
    utils.map('n', '<Leader>gD', '<C-w>h<C-w>c', '[Git]')
    --map('n', '<Leader>gc', ':G commit<CR>', opts())
    utils.map('n', '<Leader>gs', ':G status<CR>', '[Git] View status')
    -- Gitsigns
    utils.map('n', '<Leader>gj', ':Gitsigns next_hunk<CR>', '[Git] Next hunk')
    utils.map('n', '<Leader>gk', ':Gitsigns prev_hunk<CR>', '[Git] Previous hunk')
    -- Nvim-Tree
    utils.map('n', '<Leader>t', ':NvimTreeToggle<CR>', '[NvimTree] Toggle file tree')
    -- Telescope
    utils.map('n', '<Leader>of', ':Telescope find_files hidden=true<CR>', '[Telescope] File browser (show hidden)')
    utils.map('n', '<Leader>oF', ':Telescope find_files cwd=~ hidden=true<CR>', '[Telescope] File browser (from $HOME)')
    utils.map('n', '<Leader>og', ':Telescope live_grep<CR>', '[Telescope] Live grep')
    utils.map('n', '<Leader>ob', ':Telescope buffers<CR>', '[Telescope] Buffers')
    utils.map('n', '<Leader>oh', ':Telescope help_tags<CR>', '[Telescope] Help tags')

    utils.map('n', '<Leader>od', ':Telescope diagnostics<CR>', '[Telescope] Diagnostics')
    utils.map('n', '<Leader>ca', ':lua vim.lsp.buf.code_action()<CR>', '[Telescope] Code actions')
    utils.map('v', '<Leader>ca', ':lua vim.lsp.buf.code_action()<CR>', '[Telescope] Code actions')
    -- WhichKey
    utils.map('n', '<Leader>?', ':WhichKey<CR>', '[WhichKey] Open WhichKey')
-- }}}

-- Editor Controls {{{
    -- Get to normal mode with `jk` or `<Space>`
    utils.map('i', 'jk', '<Esc>', '')      -- Escape insert mode
    utils.map('v', '<Space>', '<Esc>', '') -- Escape visual mode with <Space>
    -- Navigate wrapped lines
    utils.map('n', 'j', 'gj', '')
    utils.map('n', 'k', 'gk', '')
    -- Indentation with tab key
    utils.map('n', '<Tab>', '>>_', 'Indent current line')
    utils.map('n', '<S-Tab>', '<<', 'De-indent current line')
    utils.map('v', '<Tab>', '>gv', 'Indent current line')
    utils.map('v', '<S-Tab>', '<gv', 'De-indent current line')
    -- Quickly close quickfix/loclist windows
utils.    map('n', 'QQ', ':cclose | lclose<CR>', "Close quickfix/loclist")
-- }}}

-- Editor Behavior and Appearance {{{
    -- Center view on search results
    utils.map('n', 'n', 'nzz', 'Focus next search result')
    utils.map('n', 'N', 'Nzz', 'Focus previous search result')
    -- Toggle line wrap
    utils.map('n', '<Leader>w', ':set wrap! wrap?<CR>', "Toggle line wrap")
    -- Toggle paste mode
    vim.o['pastetoggle'] = '<F2>'
    -- Toggle invisible characters
    utils.map('n', '<Leader>I', ':set list! list?<CR>', "Toggle invisible characters")
    -- Toggle spell check mode
    utils.map('n', '<F3>', ':set spell! spell?<CR>', "Toggle spell check")
    utils.map('v', '<F3>', '<Esc>:set spell! spell?<CR>gv', "Toggle spell check")
    -- Toggle folding
    utils.map('n', 'z<Space>', 'za', 'Toggle folding')
    utils.map('v', 'z<Space>', 'za', 'Toggle folding')
    -- Use system clipboard
    utils.map('x', '<Leader>y', require('osc52').copy_visual, '')
    utils.map('n', '<Leader>p', '"+p', 'Paste from system clipboard')
    utils.map('v', '<Leader>p', '"+p', 'Paste from system clipboard')
-- }}}

-- Buffer Management {{{
    utils.map('n', '<Leader>bp', ':bprev<CR>', '')
    utils.map('n', '<Leader>bn', ':bnext<CR>', '')
    utils.map('n', '<Leader>bb', ':b#<CR>', '')
    utils.map('n', '<Leader>bd', ':lclose|bprev|bd #<CR>', '')
    utils.map('n', '<Leader>bk', ':lclose|bprev|bd! #<CR>', '')
-- }}}

-- File Management {{{
    -- Write as root
    vim.cmd([[cnoreabbrev w!! lua require('utils').sudo_write()]])
    -- Open config
    utils.map('n', '<Leader>ec', ':e $MYVIMRC<CR>', 'Open config')
    -- Source config
    utils.map('n', '<Leader>sc', ':source $MYVIMRC<CR>', 'Source config')
-- }}}

-- Mouse Scroll Behavior {{{
    -- (Requires "mouse=a" option)
    --           Scroll Wheel = Up/Down 4 lines
    --   Shift + Scroll Wheel = Up/Down 1 page
    -- Control + Scroll Wheel = Up/Down half page
    --    Meta + Scroll Wheel = Up/Down 1 line
    utils.map('n', '<ScrollWheelUp>',     '4<C-Y>',      'Scroll 4 lines up')
    utils.map('n', '<ScrollWheelDown>',   '4<C-E>',      'Scroll 4 lines down')
    utils.map('n', '<S-ScrollWheelUp>',   '<C-B>',       'Scroll 1 page up')
    utils.map('n', '<S-ScrollWheelDown>', '<C-F>',       'Scroll 1 page down')
    utils.map('n', '<C-ScrollWheelUp>',   '<C-U>',       'Scroll half page up')
    utils.map('n', '<C-ScrollWheelDown>', '<C-D>',       'Scroll half page down')
    utils.map('n', '<M-ScrollWheelUp>',   '<C-Y>',       'Scroll 1 line up')
    utils.map('n', '<M-ScrollWheelDown>', '<C-E>',       'Scroll 1 line down')

    utils.map('i', '<ScrollWheelUp>',     '<C-O>4<C-Y>', 'Scroll 4 lines up')
    utils.map('i', '<ScrollWheelDown>',   '<C-O>4<C-E>', 'Scroll 4 lines down')
    utils.map('i', '<S-ScrollWheelUp>',   '<C-O><C-B>',  'Scroll 1 page up')
    utils.map('i', '<S-ScrollWheelDown>', '<C-O><C-F>',  'Scroll 1 page down')
    utils.map('i', '<C-ScrollWheelUp>',   '<C-O><C-U>',  'Scroll half page up')
    utils.map('i', '<C-ScrollWheelDown>', '<C-O><C-D>',  'Scroll half page down')
    utils.map('i', '<M-ScrollWheelUp>',   '<C-O><C-Y>',  'Scroll 1 line up')
    utils.map('i', '<M-ScrollWheelDown>', '<C-O><C-E>',  'Scroll 1 line down')
-- }}}


-- vim:foldmethod=marker
