local utils = require('utils')

utils.apply_options({
    encoding = 'utf-8',     -- Okay

    autoindent = true,      -- Automatic indentation
    smartindent = true,     -- Detect language-based indentation levels
    breakindent = true,     -- Indent line-breaks to align with code
    colorcolumn = '80,120', -- Draw rulers at columns 80 & 120
    confirm = true,         -- Confirm quit if there're unsaved changes
    expandtab = true,       -- Fill tabs with spaces
    foldlevelstart = 99,    -- Open files with open folds
    hidden = true,          -- Don't require writing buffers before hiding them
    history = 500,          -- MORE history
    hlsearch = true,        -- Highlight search results
    incsearch = true,       -- Do incremental search
    ignorecase = true,      -- Do case-insensitive search...
    smartcase = true,       -- ...unless capital letters are used
    modeline = true,        -- MORE modeline
    mouse = 'a',            -- MORE mouse
    backup = false,         -- No bak files please
    joinspaces = false,     -- No extra space after '.' when joining lines
    swapfile = false,       -- No swap file
    wrap = false,           -- No line wrap please (as default)
    writebackup = false,    -- No bak files even before writing
    number = true,          -- Show absolute line numbers on left
    relativenumber = true,  -- Show relative line numbers on left (overrides number except on current line)
    scrolloff = 10,         -- Leave lines above/below cursor
    shiftwidth = 4,         -- Set indentation depth to 4 columns
    sidescroll = 1,         -- Ensure smooth side-scrolling
    sidescrolloff = 1,      -- Don't select edge characters while side-scrolling
    softtabstop = 4,        -- Backspacing over 4 spaces like over tabs
    splitbelow = true,      -- Always split below current buffer
    splitright = true,      -- Always split right of current buffer
    tabstop = 4,            -- Set tabular length to 4 columns
    termguicolors = true,   -- Enable RGB color in the TUI
    textwidth = 0,          -- Do not automatically wrap text
    timeoutlen = 250,       -- Use less timeout?
    ttimeoutlen = 10,       -- Keycode timeouts?  Who the what?
    undolevels = 500,       -- MOAR undo
    updatetime = 500,       -- Check file status every half second (e.g. for git line markers)
    virtualedit = 'block',  -- Allow selecting over non-existant characters in visual block mode

    -- Use vertical diff splits by default
    diffopt = 'internal,filler,vertical',
    -- View sessions should save appropriate things (not local options!)
    viewoptions = 'cursor,folds,slash,unix',
    -- See all the characters
    list = true,
    listchars = 'tab:→ ,nbsp:␣,trail:·,extends:⟩,precedes:⟨',
    showbreak = '↪ ',
    -- Enable auto-completion menu
    completeopt = "menuone,noselect"
})

-- Automatically show absolute numbering while in insert mode
vim.cmd([[
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
]])

-- Determine python3 provider
if vim.env.VIRTUAL_ENV then
    vim.cmd [[
        let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
    ]]
else
    vim.cmd [[
        let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
    ]]
end

