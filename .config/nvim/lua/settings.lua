local options = {
    encoding = 'utf-8',     -- Okay

    autoindent = true,      -- Automatic indentation
    smartindent = true,     -- Detect language-based indentation levels
    cmdheight = 0,          -- Hide the commandline by default
    background = 'dark',    -- Use dark colorscheme for background.  Options: 'dark', 'light'
    breakindent = true,     -- Indent line-breaks to align with code
    confirm = true,         -- Confirm quit if there're unsaved changes
    expandtab = true,       -- Fill tabs with spaces
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
    completeopt = "menuone,preview,noselect",
    -- Set terminal title
    title = true,
    titlelen = 40,
    titlestring = "%f%=%<(%l/%L:%P)",  -- See "statusline" help for item defs
    -- Configure folding
    foldlevelstart = 99,  -- Open files with open folds
    foldmethod = 'expr',
    foldexpr = 'nvim_treesitter#foldexpr()',  -- Use treesitter for folding rules
}
for k, v in pairs(options) do vim.o[k] = v end

-- local globals = {
--     -- Allow syntax highlighting of embedded language in markdown files
--     markdown_fenced_languages = {
--         "lua", "python", "yaml"
--     },
-- }
-- for k, v in pairs(globals) do vim.g[k] = v end


-- Automatically show absolute numbering while in insert mode
vim.api.nvim_create_augroup('InsertRelNum', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', { command = 'set norelativenumber', group = 'InsertRelNum'})
vim.api.nvim_create_autocmd('InsertLeave', { command = 'set relativenumber', group = 'InsertRelNum' })

-- Highlight characters in column 90 and columns 120+
vim.api.nvim_create_augroup('ColorCol', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
    command = 'highlight ColorColumn ctermbg=darkred guibg=darkred',
    group = 'ColorCol'
})
vim.api.nvim_create_autocmd('ColorScheme', {
    command = 'match ColorColumn /\\%>89v.*\\%<91v/',
    group = 'ColorCol'
})
vim.api.nvim_create_autocmd('ColorScheme', {
    command = '2match ColorColumn /\\%>120v/',
    group = 'ColorCol'
})

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

