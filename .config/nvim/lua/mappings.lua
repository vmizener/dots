-- Hotkeys from plugins are assigned in plugins.lua
-- LSP hotkeys are in lsp.lua

-- Leader is space
vim.g['mapleader'] = ' '

local map = vim.keymap.set
local function opts(t)
    t = t or {}
    local r = { noremap = true, silent = true }
    for k, v in pairs(t) do r[k] = v end
    return r
end

-- Plugins {{{
    -- SymbolsOutline
    map('n', '<Leader>ss', ':SymbolsOutline<CR>', opts({desc='[SymbolsOutline] Toggle symbols outline pane'}))
    -- IndentLinesToggle
    map('n', '<Leader>i', ':IndentLinesToggle<CR>', opts({desc='[IndentLines] Toggle indentation guide'}))
    -- Fugitive
    map('n', '<Leader>gd', ':Gdiffsplit!<CR>', opts({desc='[Git] View diff in a split'}))
    map('n', '<Leader>gD', '<C-w>h<C-w>c', opts())
    --map('n', '<Leader>gc', ':G commit<CR>', opts())
    map('n', '<Leader>gs', ':G status<CR>', opts({desc='[Git] View status'}))
    -- Gitsigns
    map('n', '<Leader>gj', ':Gitsigns next_hunk<CR>', opts({desc='[Git] Next hunk'}))
    map('n', '<Leader>gk', ':Gitsigns prev_hunk<CR>', opts({desc='[Git] Previous hunk'}))
    -- Telescope
    map('n', '<Leader>ot', ':Telescope file_browser<CR>', opts({desc='[Telescope] File browser'}))
    map('n', '<Leader>of', ':Telescope find_files hidden=true<CR>', opts({desc='[Telescope] File browser (show hidden)'}))
    map('n', '<Leader>oF', ':Telescope find_files cwd=~ hidden=true<CR>', opts({desc='[Telescope] File browser (from $HOME)'}))
    map('n', '<Leader>og', ':Telescope live_grep<CR>', opts({desc='[Telescope] Live grep'}))
    map('n', '<Leader>ob', ':Telescope buffers<CR>', opts({desc='[Telescope] Buffers'}))
    map('n', '<Leader>oh', ':Telescope help_tags<CR>', opts({desc='[Telescope] Help tags'}))

    map('n', '<Leader>od', ':Telescope diagnostics<CR>', opts({desc='[Telescope] Diagnostics'}))
    map('n', '<Leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts({desc='[Telescope] Code actions'}))
    map('v', '<Leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts({desc='[Telescope] Code actions'}))
    -- WhichKey
    map('n', '<Leader>?', ':WhichKey', opts({desc='[WhichKey] Open WhichKey'}))
-- }}}

-- Editor Controls {{{
    -- Get to normal mode with `jk` or `<Space>`
    map('i', 'jk', '<Esc>', opts())
    map('v', '<Space>', '<Esc>', opts())
    -- Navigate wrapped lines
    map('n', 'j', 'gj', opts())
    map('n', 'k', 'gk', opts())
    -- Indentation with tab key
    map('n', '<Tab>', '>>_', opts({desc='Indent current line'}))
    map('n', '<S-Tab>', '<<', opts({desc='De-indent current line'}))
    map('v', '<Tab>', '>gv', opts())
    map('v', '<S-Tab>', '<gv', opts())
    -- Quickly close quickfix/loclist windows
    map('n', 'QQ', ':cclose | lclose<CR>', opts({desc="Close quickfix/loclist"}))
-- }}}

-- Editor Behavior and Appearance {{{
    -- Center view on search results
    map('n', 'n', 'nzz', opts({desc='Focus next search result'}))
    map('n', 'N', 'Nzz', opts({desc='Focus previous search result'}))
    -- Toggle line wrap
    map('n', '<Leader>w', ':set wrap! wrap?<CR>', opts({desc="Toggle line wrap"}))
    -- Toggle paste mode
    vim.o['pastetoggle'] = '<F2>'
    -- Toggle invisible characters
    map('n', '<Leader>I', ':set list! list?<CR>', opts({desc="Toggle invisible characters"}))
    -- Toggle spell check mode
    map('n', '<F3>', ':set spell! spell?<CR>', opts({desc="Toggle spell check"}))
    map('v', '<F3>', '<Esc>:set spell! spell?<CR>gv', opts())
    -- Toggle folding
    map('n', 'z<Space>', 'za', opts())
    map('v', 'z<Space>', 'za', opts())
    -- Use system clipboard
    map('x', '<Leader>y', require('osc52').copy_visual)
    map('n', '<Leader>p', '"+p', opts())
    map('v', '<Leader>p', '"+p', opts())
-- }}}

-- Buffer Management {{{
    map('n', '<Leader>bp', ':bprev<CR>', opts())
    map('n', '<Leader>bn', ':bnext<CR>', opts())
    map('n', '<Leader>bb', ':b#<CR>', opts())
    map('n', '<Leader>bd', ':lclose|bprev|bd #<CR>', opts())
    map('n', '<Leader>bk', ':lclose|bprev|bd! #<CR>', opts())
-- }}}

-- File Management {{{
    -- Write as root
    vim.cmd([[cnoreabbrev w!! lua utils.sudo_write()]])
    -- Open config
    map('n', '<Leader>ec', ':e $MYVIMRC<CR>', opts({desc='Open config'}))
    -- Source config
    map('n', '<Leader>sc', ':source $MYVIMRC<CR>', opts({desc='Source config'}))
-- }}}

-- Mouse Scroll Behavior {{{
    -- (Requires "mouse=a" option)
    --           Scroll Wheel = Up/Down 4 lines
    --   Shift + Scroll Wheel = Up/Down 1 page
    -- Control + Scroll Wheel = Up/Down half page
    --    Meta + Scroll Wheel = Up/Down 1 line
    map('n', '<ScrollWheelUp>',     '4<C-Y>',      opts({desc='Scroll 4 lines up'}))
    map('n', '<ScrollWheelDown>',   '4<C-E>',      opts({desc='Scroll 4 lines down'}))
    map('n', '<S-ScrollWheelUp>',   '<C-B>',       opts({desc='Scroll 1 page up'}))
    map('n', '<S-ScrollWheelDown>', '<C-F>',       opts({desc='Scroll 1 page down'}))
    map('n', '<C-ScrollWheelUp>',   '<C-U>',       opts({desc='Scroll half page up'}))
    map('n', '<C-ScrollWheelDown>', '<C-D>',       opts({desc='Scroll half page down'}))
    map('n', '<M-ScrollWheelUp>',   '<C-Y>',       opts({desc='Scroll 1 line up'}))
    map('n', '<M-ScrollWheelDown>', '<C-E>',       opts({desc='Scroll 1 line down'}))
    map('i', '<ScrollWheelUp>',     '<C-O>4<C-Y>', opts())
    map('i', '<ScrollWheelDown>',   '<C-O>4<C-E>', opts())
    map('i', '<S-ScrollWheelUp>',   '<C-O><C-B>',  opts())
    map('i', '<S-ScrollWheelDown>', '<C-O><C-F>',  opts())
    map('i', '<C-ScrollWheelUp>',   '<C-O><C-U>',  opts())
    map('i', '<C-ScrollWheelDown>', '<C-O><C-D>',  opts())
    map('i', '<M-ScrollWheelUp>',   '<C-O><C-Y>',  opts())
    map('i', '<M-ScrollWheelDown>', '<C-O><C-E>',  opts())
-- }}}


-- vim:foldmethod=marker
