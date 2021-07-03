" =============================================================================
"  _   _ ______ ______      _______ __  __
" | \ | |  ____/ __ \ \    / /_   _|  \/  |
" |  \| | |__ | |  | \ \  / /  | | | \  / |
" | . ` |  __|| |  | |\ \/ /   | | | |\/| |
" | |\  | |___| |__| | \  /   _| |_| |  | |
" |_| \_|______\____/   \/   |_____|_|  |_|
"
"         _   _ ______ ______      _______ __  __
"        | \ | |  ____/ __ \ \    / /_   _|  \/  |
"        |  \| | |__ | |  | \ \  / /  | | | \  / |
"        | . ` |  __|| |  | |\ \/ /   | | | |\/| |
"        | |\  | |___| |__| | \  /   _| |_| |  | |
"        |_| \_|______\____/   \/   |_____|_|  |_|
"
"                _   _ ______ ______      _______ __  __
"               | \ | |  ____/ __ \ \    / /_   _|  \/  |
"               |  \| | |__ | |  | \ \  / /  | | | \  / |
"               | . ` |  __|| |  | |\ \/ /   | | | |\/| |
"               | |\  | |___| |__| | \  /   _| |_| |  | |
"               |_| \_|______\____/   \/   |_____|_|  |_|
"
" Use with Plug (https://github.com/junegunn/vim-plug)
"
" You may also add any plugins to the plugins list below, then re-source this
" file and run `:PlugInstall` to install all listed plugins
"
" Note that vim-devicons requires fonts to be installed
" See https://github.com/ryanoasis/nerd-fonts
" Make sure your terminal is using the correct font as well
"
" Changelog: {{{
" Mon Mar 02 2020 {{{
"   - Set textwidth to 0 to disable automatically text wrapping
"   - Set foldlevelstart to 99 to open all folds by default
"   - Added hotkey to open an empty buffer in the current window
" }}}
" Mon Feb 06 2020 {{{
"   - Added vim-yaml-folds for YAML folding rules
" }}}
" Mon Jan 27 2020 {{{
"   - Gdiff (fugitive) hotkey now does 3-way split by default
"   - Gdiff (fugitive) will use vertical splits by default
" }}}
" Wed Jan 15 2020 {{{
"   - Added Undotree plugin for undo history visualization
"   - Added a hotkey to toggle invisible characters
" }}}
" Thu Nov 21 2019 {{{
"   - Replaced vim-obsession with vim-stay
"   - Removed automatic view creation logic (now handled by vim-stay)
"   - Removed default foldlevel from this file
" }}}
" Wed Nov 20 2019 {{{
"   - Added Python folding rule plugin 'SimpylFold'
"   - Added FastFold plugin for faster folding
" }}}
" Thu Nov 14 2019 {{{
"   - Changed vim-qf navigation shortcuts to avoid overlap with vim-latex
" }}}
" Wed Nov 13 2019 {{{
"   - Adjusted automatic setup block for clarity; now uses variables
"   - Lengthed section separators
"   - Updated listchars/showbreak characters
"   - Minor typo fixes
" }}}
" Tue Nov 12 2019 {{{
"   - Added a new command for recreating the current view
"   - Added sidescroll settings to ensure smooth side scrolling
"   - Added vim-qf plugin for streamlined quickfix navigation
"   - LanguageClient no longer shows virtual text for diagnostic messages
"   - Renamed some of the setting sections
"   - Removed lingering Neomake configuration
"   - Removed window navigation shortcuts (just use defaults controls now)
"   - Old window navigation shorcuts are now used for quickfix navigation
" }}}
" Tue Nov 05 2019 {{{
"   - Added an automatic setup block
"   - Added LanguageClient plugin for language server protocol (LSP) support
"   - Set textwidth to 120
"   - Increased gitgutter max signs from 500 to 1500
" }}}
" Mon Nov 04 2019 {{{
"   - Categorized plugins
"   - Added deoplete plugin for code completion (testing it out)
"   - Commented out supertab/jedi plugins during test
" }}}
" Thu Oct 31 2019 {{{
"   - Happy Halloween!
"   - Added some ASCII art to the header
"   - Added rulers to columns 80 & 120
"   - Added vim-peekaboo plugin for register previewing
"   - Added vim-startify plugin for fancy startup
"   - Changed read/write to buffer hotkeys from Ctrl-<key> to <Leader><key>
"   - Consolidated UI Settings and Interface Behavior groups
"   - Reorganized terminal settings
"   - Added a couple more lines to the header on plugin installation
" }}}
" Tue Oct 29 2019 {{{
"   - Nerdtree is now bound to '<Leader>ot' to consolidate file finding
"   shortcuts
" }}}
" Mon Oct 28 2019 {{{
"   - Shortcut for opening this file for editing now puts it in a buffer,
"   instead of a tab
"   - Decreased vim 'updatetime' from 4000 (default) to 500 milliseconds
"   - Split up some folds of this file
" }}}
" Wed Oct 23 2019 {{{
"   - Reorganized this file; added fold markers
"   - Added modeline
"   - Copy/paste now goes directly to system clipboard (removed separate hotkey)
"   - Changed tab hotkeys to be consistent with buffer hotkeys
"   - Added nerdcommenter plugin for automatic commenting
"   - Added vim-devicons for pretty filetype icons
" }}}
" Fri Aug 09 2019 {{{
"   - Added virtualedit=block option to allow selecting over non-existant characters
"     in visual block mode
" }}}
" Tue Jul 23 2019 {{{
"   - Buffers are now hidden when out of view (no need to save upon
"     switching buffers views now)
"   - Removed bling/vim-bufferline plugin; removed bufferline at top
"   - Added vim-cool plugin for automatically toggling search highlighting
"   - Added vim-gutentags plugin for automatic ctags management (use with
"     universal-ctags)
" }}}
" Thu Oct 25 2018 {{{
"   - Added toggle key for IndentLine
"   - IndentLine now disabled by default
"   - Commented out Neomake
" }}}
" Fri Jun 01 2018 {{{
"   - Vim-sneak, for sneaky movement
"   - Vim-obsession, for obsessive sessions
" }}}
" Thu May 24 2018 {{{
"   - Automatic views (doesn't run on terminal buffers)
"   - Nowrap now set by default
"   - Supertab now treats `<CR>` as confirmation (instead of inserting one)
"   - Minor symbol changes for Airline
" }}}
" Wed May 23 2018 {{{
"   - Quick edit of this file now resolves symlink rather than hardcodes path
"   - Reorganized the hotkeys section
"   - `Y` now copies to end of line instead of being an alias for `yy`
"   - Added spellcheck options
"   - Clipboard copy/paste expanded
"   - Added hotkey to go to last buffer
"   - Airline symbols added
"       - Requires a supported font
"       - https://github.com/source-foundry/Hack
"   - Added Gitgutter hotkeys to jump between hunks
" }}}
" Mon May 21 2018 {{{
"   - Quick folding is now z<Space>
"   - Increased keymap timeout to 500 (up from 250)
"   - Quick edit of this file now looks for itself in ~/.dotfiles
"   - Quick edit of this file now puts itself in a new tab
" }}}
" Thu May 17 2018 {{{
"   - Added Gitgutter
"   - Added IndentLine
" }}}
" Tue May 15 2018 {{{
"   - Added system clipboard copy/paste
"   - Reduced keymap timeouts
"   - Escape visual mode with `<Space>` now instead of `jk`
"   - Minor terminal stuff improvements
" }}}
" Mon May 14 2018 {{{
"   - Added more shortcuts for Neomake and location list manipulation
"   - Added terminal stuff
"   - Added window movement shortcuts
"   - Removed autochdir (it broke some plugins and I don't need it)
"   - Closing buffers no longer closes windows they're in
" }}}
" Fri May 11 2018 {{{
"   - Added Nerdtree, buffer hotkeys, filetype detection, tab key behavior
" }}}
" Thu May 10 2018 {{{
"   - Created!
"   - https://github.com/adibis/nvim/blob/master/init.vim
"   - http://nerditya.com/code/guide-to-neovim/
"   - https://gist.github.com/subfuzion/7d00a6c919eeffaf6d3dbf9a4eb11d64
" }}}
" }}}
" =============================================================================
" Automatic Setup {{{
    let plugged_autoload = '~/.vim/autoload/plug.vim'
    if empty(glob(plugged_autoload))
        let plugged_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        execute '!curl -fLo '.plugged_autoload.' --create-dirs '.plugged_url
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        unlet plugged_url
    endif
    unlet plugged_autoload
" }}}
" Load Plugins {{{
call plug#begin('~/.config/nvim/plugged')
    " UI Appearance & Interface {{{
        " Airline provides a better status line and a tab bar
        Plug 'bling/vim-airline'
        " Gruvbox is a colorscheme for vim
        Plug 'morhetz/gruvbox'
        " IndentLine provides an indentation guide
        Plug 'Yggdroot/indentLine'
        " Peekaboo displays a preview window of register contents
        Plug 'junegunn/vim-peekaboo'
        " Startify is a fancy start page for vim
        Plug 'mhinz/vim-startify'
        " Vim-cool smartly toggles search highlighting automatically
        Plug 'romainl/vim-cool'
        " Vim-css-color is a color-code highlighting plugin
        Plug 'ap/vim-css-color'
    " }}}
    " Workflow Features {{{
        " Ctrl-P is a fuzzy file finder tool
        Plug 'kien/ctrlp.vim'
        " FastFold for fast folds
        Plug 'Konfekt/FastFold'
        " Fugitive is a Git wrapper for vim
        Plug 'tpope/vim-fugitive'
        " Gitgutter shows a Git diff in the sign column asynchronously
        Plug 'airblade/vim-gitgutter'
        " Gutentags automatically maintains ctags for an open project (use with
        " universal-ctags for an up-to-date ctags implementation)
        " Plug 'ludovicchabant/vim-gutentags'
        " Nerdcommenter is for automatically commenting lines
        Plug 'scrooloose/nerdcommenter'
        " Nerdtree is a directory preview tool
        Plug 'scrooloose/nerdtree'
        " Undotree displays an interactive undo history tree
        Plug 'mbbill/undotree'
        " Vim-latex is vim latex, obviously
        Plug 'vim-latex/vim-latex', { 'for': 'tex' }
        " Vim-qf streamlines using the quickfix window
        Plug 'romainl/vim-qf'
        " Vim-sneak is a convenient motion command
        Plug 'justinmk/vim-sneak'
        " Vim-stay provides automatic view/session management
        Plug 'zhimsel/vim-stay'
    " }}}
    " Language & Completion {{{
        " Autoformatter for Python
        Plug 'psf/black'
        " Syntax with vim-polyglot
        Plug 'sheerun/vim-polyglot'
        " Completion with deoplete
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        " Language with LanguageClient-neovim (LSP)
        Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
        " Folding rules for Python
        Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
        " Folding rules for YAML
        Plug 'pedrohdz/vim-yaml-folds'
    " }}}
    " Bonus Extras {{{
        " Vim-Plugged itself (for help docs)
        Plug 'junegunn/vim-plug'
        " Add custom filetype glyphs to various Vim plugins
        " !! Must be loaded last !!
        Plug 'ryanoasis/vim-devicons'
    " }}}
call plug#end()
" }}}
" =============================================================================
" General Settings {{{
        set encoding=utf-8      " Okay

        set autoindent          " Automatic indentation
        set breakindent         " Indent line-breaks to align with code
        set colorcolumn=80,120  " Draw rulers at columns 80 & 120
        set confirm             " Confirm quit if there're unsaved changes
        set expandtab           " Fill tabs with spaces
        set foldlevelstart=99   " Open files with open folds
        set hidden              " Don't require writing buffers before hiding them
        set history=500         " MORE history
        set hlsearch            " Highlight search results
        set incsearch           " Do incremental search
        set ignorecase          " Do case-insensitive search...
        set smartcase           " ...unless capital letters are used
        set modeline            " MORE modeline
        set mouse=a             " MORE mouse
        set nobackup            " No bak files please
        set nojoinspaces        " No extra space after '.' when joining lines
        set noswapfile          " No swap file
        set nowrap              " No line wrap please (as default)
        set nowritebackup       " No bak files even before writing
        set number              " Show absolute line numbers on left
        set relativenumber      " Show relative line numbers on left (overrides number except on current line)
        set scrolloff=10        " Leave lines above/below cursor
        set shiftwidth=4        " Set indentation depth to 4 columns
        set sidescroll=1        " Ensure smooth side-scrolling
        set sidescrolloff=1     " Don't select edge characters while side-scrolling
        set softtabstop=4       " Backspacing over 4 spaces like over tabs
        set splitbelow          " Always split below current buffer
        set splitright          " Always split right of current buffer
        set tabstop=4           " Set tabular length to 4 columns
        set textwidth=0         " Do not automatically wrap text
        set timeoutlen=250      " Use less timeout?
        set ttimeoutlen=10      " Keycode timeouts?  Who the what?
        set undolevels=500      " MOAR undo
        set updatetime=500      " Check file status every half second (e.g. for git line markers)
        set virtualedit=block   " Allow selecting over non-existant characters in visual block mode

        filetype on         " Detect filetypes
        filetype plugin on  " Run plugins for specific filetypes
        filetype indent on  " Use indent files for specific filetypes

        " Copy and paste to system clipboard (may require X)
        set clipboard=unnamedplus
        " Use vertical diff splits by default
        set diffopt+=vertical
        " View sessions should save appropriate things (not local options!)
        set viewoptions=cursor,folds,slash,unix
        " See all the characters
        set list
        set listchars=tab:→\ ,nbsp:␣,trail:·,extends:⟩,precedes:⟨
        set showbreak=↪\    " Line wrap indicator
" }}}
" Controls and Custom Shortcuts {{{
        let mapleader=','   " Use ',' as the leader key
        " Toggle Editor Settings {{{
            " Toggle line wrap
            nnoremap <silent> <Leader>w :set wrap! wrap?<CR>
            " Toggle paste mode
            set pastetoggle=<F2>
            " Toggle invisible characters
            nnoremap <silent> <Leader>I :set list! list?<CR>
            " Toggle spell check mode
            nnoremap <silent> <F3> :set spell! spell?<CR>
            vnoremap <silent> <F3> <Esc>:set spell! spell?<CR>gv
            " Toggle folding
            nnoremap z<Space> za
            vnoremap z<Space> za
        " }}}
        " Editor Controls {{{
            " Get to normal mode with `jk` or `<Space>`
            inoremap jk <Esc>
            vnoremap <Space> <Esc>
            " Navigate wrapped lines
            nnoremap j gj
            nnoremap k gk
            " Indentation with tab key
            " (See deoplete settings)
            nnoremap <Tab> >>_
            nnoremap <S-Tab> <<
            vnoremap <Tab> >gv
            vnoremap <S-Tab> <gv
            " Clear search
            nmap <silent> <Leader>/ :nohlsearch<CR>
            " Center view on search results
            noremap n nzz
            noremap N Nzz
        " }}}
        " Editor View Navigation {{{
            " Buffers {{{
                " Navigate buffers
                nnoremap <Leader>bp  :bprev<CR>
                nnoremap <Leader>bn  :bnext<CR>
                nnoremap <Leader>bb  :b#<CR>
                " Close/Kill buffers (without closing windows)
                nnoremap <silent> <Leader>bd :lclose\|bprev\|bd #<CR>
                nnoremap <silent> <Leader>bk :lclose\|bprev\|bd! #<CR>
            " }}}
            " Tabs {{{
                nnoremap <Leader>tp  :tabprev<CR>
                nnoremap <Leader>tn  :tabnext<CR>
                nnoremap <Leader>te  :tabedit<Space>
                nnoremap <Leader>tN  :tabnew<CR>
                nnoremap <Leader>tm  :tabmove<Space>
                nnoremap <Leader>td  :tabclose<CR>
            " }}}
            " Windows {{{
                tnoremap <C-w>h <C-\><C-n><C-w>h
                tnoremap <C-w>j <C-\><C-n><C-w>j
                tnoremap <C-w>k <C-\><C-n><C-w>k
                tnoremap <C-w>l <C-\><C-n><C-w>l
            " }}}
            " Terminals {{{
                " Open a terminal
                nnoremap <silent> <Leader>tt :terminal<CR>i
                nnoremap <silent> <Leader>tv :vnew<CR><Esc>:terminal<CR>i
                nnoremap <silent> <Leader>th :new<CR><Esc>:terminal<CR>:resize 10<CR>i
                " Escape a terminal
                tnoremap <Esc> <C-\><C-n>
                " Close a terminal
                tnoremap <C-x> <C-\><C-n>:b#\|bd! #<CR>
            " }}}
        " }}}
        " Reading & Writing Files {{{
            " Open a new unamed buffer in the current window
            nnoremap <Leader>oe :enew<CR>
            " Copy and paste from an external buffer file
            vnoremap <Leader>y :w! ${HOME}/.vbuf<CR>
            nnoremap <Leader>y :.w! ${HOME}/.vbuf<CR>
            nnoremap <Leader>p :r ${HOME}/.vbuf<CR>
            " Write the current file with sudo permission
            cmap w!! w !sudo tee > /dev/null %

            " Open this configuration file for editing
            nnoremap <silent> <Leader>ec :edit $MYVIMRC<CR>
            " Source this configuration file
            nnoremap <silent> <Leader>sc :source $MYVIMRC<CR>

            " Add the 'reloadview' command for completely recreating the current view
            function! ReloadView()
                " Get the full filepath of the current buffer
                let path = fnamemodify(bufname('%'), ':p')
                " Modify the filepath to match vim's odd view naming scheme:
                "   1. Use '~' for the home path
                "   2. '=' -> '=='
                "   3. '/' -> '=+'
                if !empty($HOME)
                    let viewpath = path
                else
                    let viewpath = substitute(path, '^'.$HOME, '\~', '')
                endif
                let viewpath = substitute(viewpath, '=', '==', 'g')
                let viewpath = substitute(viewpath, '/', '=+', 'g') . '='
                " Append the view directory
                let viewpath = &viewdir.'/'.viewpath
                " Delete the file
                call delete(viewpath)
                " Close the current buffer
                execute "noautocmd bdelete"
                " Reopen the file
                execute "edit ".path
                " Report success
                echo "Reloaded: ".path
            endfunction
            command! Reloadview call ReloadView()
            cabbrev reloadview <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'Reloadview' : 'reloadview')<CR>

        " }}}
        " Mouse Scroll Behavior {{{
            "           Scroll Wheel = Up/Down 4 lines
            "   Shift + Scroll Wheel = Up/Down 1 page
            " Control + Scroll Wheel = Up/Down half page
            "    Meta + Scroll Wheel = Up/Down 1 line
            noremap <ScrollWheelUp>      4<C-Y>
            noremap <ScrollWheelDown>    4<C-E>
            noremap <S-ScrollWheelUp>    <C-B>
            noremap <S-ScrollWheelDown>  <C-F>
            noremap <C-ScrollWheelUp>    <C-U>
            noremap <C-ScrollWheelDown>  <C-D>
            noremap <M-ScrollWheelUp>    <C-Y>
            noremap <M-ScrollWheelDown>  <C-E>
            inoremap <ScrollWheelUp>     <C-O>4<C-Y>
            inoremap <ScrollWheelDown>   <C-O>4<C-E>
            inoremap <S-ScrollWheelUp>   <C-O><C-B>
            inoremap <S-ScrollWheelDown> <C-O><C-F>
            inoremap <C-ScrollWheelUp>   <C-O><C-U>
            inoremap <C-ScrollWheelDown> <C-O><C-D>
            inoremap <M-ScrollWheelUp>   <C-O><C-Y>
            inoremap <M-ScrollWheelDown> <C-O><C-E>
        " }}}
" }}}
" Interface Appearance & Behavior {{{
        " General Behavior {{{
            " Automatically show absolute numbering only when in insert mode
            autocmd InsertEnter * :set norelativenumber
            autocmd InsertLeave * :set relativenumber
        " }}}
        " Terminal Behavior {{{
            " Start insert mode when entering a terminal
            autocmd BufWinEnter,WinEnter term://* startinsert
            " Don't automatically unload terminal buffers
            silent! autocmd TermOpen * set bufhidden=hide
        " }}}
    " Colorscheme {{{
        set bg=dark
        colorscheme gruvbox
    " }}}
" }}}
" Plugin Settings {{{
    " Airline {{{
        let g:airline_powerline_fonts = 1

        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#fnamemod = ':t'
        let g:airline#extensions#tabline#left_sep = ''
        let g:airline#extensions#tabline#left_alt_sep = ''
        let g:airline#extensions#tabline#right_sep = ''
        let g:airline#extensions#tabline#right_alt_sep = ''
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''

        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif
        "let g:airline_symbols.branch = ''
        let g:airline_symbols.branch = 'ᚠ'
        let g:airline_symbols.readonly = ''
        "let g:airline_symbols.linenr = '☰'
        "let g:airline_symbols.linenr = ''
        let g:airline_symbols.linenr = '㏑'
        "let g:airline_symbols.maxlinenr = '㏑'
        let g:airline_symbols.maxlinenr = ''
        let g:airline_symbols.paste = 'PASTE'
        "let g:airline_symbols.paste = 'Þ'
        let g:airline_symbols.spell = 'Ꞩ'
    " }}}
    " CtrlP {{{
        " Prompt for where to open files after a <C-o>
        let g:ctrlp_arg_map = 1
        " Open file menu
        nnoremap <Leader>oo :CtrlP<CR>
        " Open buffer menu
        nnoremap <Leader>ob :CtrlPBuffer<CR>
        " Open most recently used files
        nnoremap <Leader>of :CtrlPMRUFiles<CR>
    " }}}
    " Deoplete {{{
        let g:deoplete#enable_at_startup = 1
        " Enable tab completion
        inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
        imap <expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"
        " Close previews after completion
        autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    " }}}
    " DevIcons {{{
        set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ 11
    " }}}
    " FastFold {{{
        let g:fastfold_savehook = 0
    " }}}
    " Fugitive / Gitgutter {{{
        nnoremap <Leader>gc :Gcommit<CR>
        nnoremap <Leader>gd :Gdiff!<CR>
        nnoremap <Leader>gf :Gfetch<CR>
        nnoremap <Leader>gl :Gpull<CR>
        nnoremap <Leader>gp :Gpush<CR>
        nnoremap <Leader>gs :Gstatus<CR>
        nnoremap <Leader>gw :Gwrite<CR>

        nnoremap <Leader>gj :GitGutterNextHunk<CR>
        nnoremap <Leader>gk :GitGutterPrevHunk<CR>

        let g:gitgutter_max_signs = 1500
    " }}}
    " Gutentags {{{
        "let g:gutentags_cache_dir = expand('$HOME/.cache/gutentags')
        "let g:gutentags_resolve_symlinks = 1
        "let g:gutentags_trace = 1
        "" Write tags to a '.tags' file instead of 'tags'
        "let g:gutentags_ctags_tagfile = '.tags'
        "" Make sure '.tags' is still recognized as a tags file by vim
        "augroup TagFileType
        "    autocmd!
        "    autocmd BufNewFile,BufRead *.tags set syntax=tags
        "augroup END
    " }}}
    " IndentLine {{{
        " The default char is pretty good too but we about that UNICODE LIFE
        let g:indentLine_char = '┆'
        " Disable by default
        let g:indentLine_enabled = 0
        " Toggle IndentLine
        nnoremap <Leader>i :IndentLinesToggle<CR>
    " }}}
    " LanguageClient {{{
        " Shortcuts {{{
            nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
            nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
        " }}}
        " Settings {{{
            " Don't display in-line errors
            let g:LanguageClient_useVirtualText = 0
        " }}}
        " Language Servers {{{
            " Assign language servers
            " (see https://langserver.org/)
            let g:LanguageClient_serverCommands = {}
            " Python:
            " palantir/python-language-server
            " pip3 install --upgrade python-language-server
            let g:LanguageClient_serverCommands.python =
                \ ['pyls']
        " }}}
    " }}}
    " Nerdcommenter {{{
        " Include a space after comment delimiters
        let g:NERDSpaceDelims = 1
        " Align left by default
        let g:NERDDefaultAlign = 'left'
    " }}}
    " Nerdtree {{{
        " Toggle the tree
        nnoremap <silent> <Leader>ot :NERDTreeToggle<CR>
    " }}}
    " Quickfix {{{
        " Toggle the location/quickfix window, keep focus on current buffer
        nmap <F5> <Plug>(qf_qf_toggle_stay)
        nmap <F6> <Plug>(qf_loc_toggle_stay)
        " In a location/quickfix window, navigate to an older or newer list
        nmap <buffer> <Left>  <Plug>(qf_older)
        nmap <buffer> <Right> <Plug>(qf_newer)
        " Go up and down the current location/quickfix window, wrapping as necessary
        nmap <PageDown> <Plug>(qf_qf_next)
        nmap <PageUp> <Plug>(qf_qf_previous)
        nmap <C-PageDown> <Plug>(qf_loc_next)
        nmap <C-PageUp> <Plug>(qf_loc_previous)
    " }}}
    " Sneak {{{
        " Respect case sensitivity settings
        let g:sneak#use_ic_scs = 1
        " Use labels
        let g:sneak#label = 1
        map s <Plug>SneakLabel_s
        map S <Plug>SneakLabel_S
        " Upgrade FfTt
        map f <Plug>Sneak_f
        map F <Plug>Sneak_F
        map t <Plug>Sneak_t
        map T <Plug>Sneak_T
    " }}}
    " Startify {{{
        let g:startify_custom_footer =
           \ ['', "   Vim is charityware. Please read ':help uganda'.", '']
    " }}}
    " Supertab {{{
        " Completion type is per word
        let g:SuperTabRetainCompletionDuration = 'completion'
        " Select completion option with `<CR>` (instead of inserting newline)
        let g:SuperTabCrMapping = 1
    " }}}
    " Undotree {{{
        " Toggle the undo-tree panel
        nmap <F4> :UndotreeToggle<cr>
    " }}}
" }}}
" =============================================================================
" vim:foldmethod=marker
