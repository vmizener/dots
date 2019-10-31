" ====================================================================
"  _   _ ______ ______      _______ __  __
" | \ | |  ____/ __ \ \    / /_   _|  \/  |
" |  \| | |__ | |  | \ \  / /  | | | \  / |
" | . ` |  __|| |  | |\ \/ /   | | | |\/| |
" | |\  | |___| |__| | \  /   _| |_| |  | |
" |_| \_|______\____/   \/   |_____|_|  |_|
"
"  _   _ ______ ______      _______ __  __
" | \ | |  ____/ __ \ \    / /_   _|  \/  |
" |  \| | |__ | |  | \ \  / /  | | | \  / |
" | . ` |  __|| |  | |\ \/ /   | | | |\/| |
" | |\  | |___| |__| | \  /   _| |_| |  | |
" |_| \_|______\____/   \/   |_____|_|  |_|
"
"  _   _ ______ ______      _______ __  __
" | \ | |  ____/ __ \ \    / /_   _|  \/  |
" |  \| | |__ | |  | \ \  / /  | | | \  / |
" | . ` |  __|| |  | |\ \/ /   | | | |\/| |
" | |\  | |___| |__| | \  /   _| |_| |  | |
" |_| \_|______\____/   \/   |_____|_|  |_|
"
" Use with Plug (https://github.com/junegunn/vim-plug):
"   curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then install plugins with `nvim +PlugInstall +qall`
"
" Note vim-devicons requires fonts to be installed
" See https://github.com/ryanoasis/nerd-fonts
" Make sure your terminal is using the correct font as well
"
" Changelog: {{{
" Thu Oct 31 2019 {{{
"   - Happy Halloween!
"   - Added some ASCII art to the header
"   - Added rulers to columns 80 & 120
"   - Changed read/write to buffer hotkeys from Ctrl-<key> to <Leader><key>
"   - Added vim-peekaboo plugin for register previewing
"   - Added vim-startify plugin for fancy startup
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
" ====================================================================
" Load Plugins {{{
call plug#begin('~/.config/nvim/plugged')
    " Airline provides a better status line and a tab bar
    Plug 'bling/vim-airline'
    " Ale is an 'asynchronous linting engine'
    "Plug 'w0rp/ale'
    " Ctrl-P is a fuzzy file finder tool
    Plug 'kien/ctrlp.vim'
    " Fugitive is a Git wrapper for vim
    Plug 'tpope/vim-fugitive'
    " Gitgutter shows a Git diff in the sign column asynchronously
    Plug 'airblade/vim-gitgutter'
    " Gruvbox is a colorscheme for vim
    Plug 'morhetz/gruvbox'
    " Gutentags automatically maintains ctags for an open project (use with
    " universal-ctags for an up-to-date ctags implementation)
    " Plug 'ludovicchabant/vim-gutentags'
    " IndentLine provides an indentation guide
    Plug 'Yggdroot/indentLine'
    " Jedi-Vim is an autocompletion library for Python
    Plug 'davidhalter/jedi-vim'
    " Neomake is an asynchronous make/linter tool for neovim
    "Plug 'neomake/neomake'
    " Peekaboo displays a preview window of register contents
    Plug 'junegunn/vim-peekaboo'
    " Nerdcommenter is for automatically commenting lines
    Plug 'scrooloose/nerdcommenter'
    " Nerdtree is a directory preview tool
    Plug 'scrooloose/nerdtree'
    " Startify is a fancy start page for vim
    Plug 'mhinz/vim-startify'
    " Supertab is a code-completion tool
    Plug 'ervandew/supertab'
    " Vim-cool smartly toggles search highlighting automatically
    Plug 'romainl/vim-cool'
    " Vim-css-color is a color-code highlighting plugin
    Plug 'ap/vim-css-color'
    " Vim-latex is vim latex, obviously
    Plug 'vim-latex/vim-latex'
    " Vim-obsession is an automatic session management plugin
    Plug 'tpope/vim-obsession'
    " Vim-sneak is a convenient motion command
    Plug 'justinmk/vim-sneak'

    " Add custom filetype glyphs to various Vim plugins
    " !! Must be loaded last !!
    Plug 'ryanoasis/vim-devicons'
call plug#end()
" }}}
" ====================================================================
" General Settings {{{
        set encoding=utf-8      " Okay

        set autoindent          " Automatic indentation
        set breakindent         " Indent line-breaks to align with code
        set colorcolumn=80,120  " Draw rulers at columns 80 & 120
        set confirm             " Confirm quit if there're unsaved changes
        set expandtab           " Fill tabs with spaces
        set foldlevelstart=20   " Open files with closed folds
        set hidden              " Don't require writing buffers before hiding them
        set history=500         " MORE history
        set hlsearch            " Highlight search results
        set incsearch           " Do incremental search
        set ignorecase          " Do case-insensitive search...
        set smartcase           " ...unless capital letters are used
        set modeline            " MORE modeline
        set mouse=a             " MORE mouse
        set nobackup            " No swp files please
        set nojoinspaces        " No extra space after '.' when joining lines
        set nowrap              " By default, don't wrap lines
        set nowritebackup       " ...even before writing
        set number              " Show absolute line numbers on left
        set relativenumber      " Show relative line numbers on left (overrides number except on current line)
        set scrolloff=10        " Leave lines above/below cursor
        set shiftwidth=4        " Set indentation depth to 4 columns
        set softtabstop=4       " Backspacing over 4 spaces like over tabs
        set splitbelow          " Always split below current buffer
        set splitright          " Always split right of current buffer
        set tabstop=4           " Set tabular length to 4 columns
        set timeoutlen=250      " Less timeout?
        set ttimeoutlen=10      " Keycode timeouts?  Who the what?
        set undolevels=500      " MOAR undo
        set updatetime=500      " Check file status every half second (e.g. for swp file and git)
        set virtualedit=block   " Allow selecting over non-existant characters in visual block mode

        filetype on         " Detect filetypes
        filetype plugin on  " Run plugins for specific filetypes
        filetype indent on  " Use indent files for specific filetypes

        " Copy and paste to system clipboard (may require X)
        set clipboard=unnamedplus
        " See all the characters
        set list
        set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+
" }}}
" Controls and Custom Shortcuts {{{
        let mapleader=','   " Use ',' as the leader key
        " Toggle Editor Settings {{{
            " Toggle line wrap
            nnoremap <silent> <Leader>w :set wrap! wrap?<CR>
            " Toggle paste mode
            set pastetoggle=<F2>
            " Toggle spell check mode
            nnoremap <silent> <F3> :set spell! spell?<CR>
            vnoremap <silent> <F3> <Esc>:set spell! spell?<CR>gv
            " Toggle folding
            nnoremap z<Space> za
            vnoremap z<Space> za
        " }}}
        " File Navigation {{{
            " Get to normal mode with `jk` or `<Space>`
            inoremap jk <Esc>
            vnoremap <Space> <Esc>
            " Navigate wrapped lines
            nnoremap j gj
            nnoremap k gk
            " Indentation with tab key
            nnoremap <Tab> >>_
            nnoremap <S-Tab> <<
            inoremap <S-Tab> <C-d>
            vnoremap <Tab> >gv
            vnoremap <S-Tab> <gv
            " Clear search
            nmap <silent> <Leader>/ :nohlsearch<CR>
            " Center view on search results
            noremap n nzz
            noremap N Nzz
        " }}}
        " Buffer/Tab/Window Navigation {{{
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
                tnoremap <C-h> <C-\><C-n><C-w>h
                tnoremap <C-j> <C-\><C-n><C-w>j
                tnoremap <C-k> <C-\><C-n><C-w>k
                tnoremap <C-l> <C-\><C-n><C-w>l
                nnoremap <C-h> <C-w>h
                nnoremap <C-j> <C-w>j
                nnoremap <C-k> <C-w>k
                nnoremap <C-l> <C-w>l
            " }}}
        " }}}
        " Reading & Writing Files {{{
            " Open this configuration file for editing
            "nnoremap <silent> <Leader>ec :execute "tabedit" resolve($MYVIMRC)<CR>
            nnoremap <silent> <Leader>ec :edit $MYVIMRC<CR>
            " Source this configuration file
            nnoremap <silent> <Leader>sc :source $MYVIMRC<CR>
            " Copy and paste from an external buffer file
            vnoremap <Leader>y :w! ${HOME}/.vbuf<CR>
            nnoremap <Leader>y :.w! ${HOME}/.vbuf<CR>
            nnoremap <Leader>p :r ${HOME}/.vbuf<CR>
            " Write the current file with sudo permission
            cmap w!! w !sudo tee > /dev/null %
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
" Interface Behavior {{{
        " General Behavior {{{
            " Automatically show absolute numbering only when in insert mode
            autocmd InsertEnter * :set norelativenumber
            autocmd InsertLeave * :set relativenumber
            " Automatic views
            augroup AutoSaveView
                autocmd!
                autocmd BufWinLeave * if &buftype !=# 'terminal' | silent! mkview
                autocmd BufWinEnter * if &buftype !=# 'terminal' | silent! loadview
            augroup END
        " }}}
        " Terminal Behavior {{{
            " Start insert mode when entering a terminal
            autocmd BufWinEnter,WinEnter term://* startinsert
            " Don't automatically unload terminal buffers
            silent! autocmd TermOpen * set bufhidden=hide
            " Open a terminal
            nnoremap <silent> <Leader>tt :terminal<CR>i
            nnoremap <silent> <Leader>tv :vnew<CR><Esc>:terminal<CR>i
            nnoremap <silent> <Leader>th :new<CR><Esc>:terminal<CR>i
            " Escape a terminal
            tnoremap <Esc> <C-\><C-n>
            " Close a terminal
            tnoremap <C-x> <C-\><C-n>:b#\|bd! #<CR>
        " }}}
" }}}
" UI Appearance {{{
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
    " DevIcons {{{
        set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ 11
    " }}}
    " Fugitive / Gitgutter {{{
        nnoremap <Leader>gc :Gcommit<CR>
        nnoremap <Leader>gd :Gdiff HEAD<CR>
        nnoremap <Leader>gf :Gfetch<CR>
        nnoremap <Leader>gl :Gpull<CR>
        nnoremap <Leader>gp :Gpush<CR>
        nnoremap <Leader>gs :Gstatus<CR>
        nnoremap <Leader>gw :Gwrite<CR>

        nnoremap <Leader>gj :GitGutterNextHunk<CR>
        nnoremap <Leader>gk :GitGutterPrevHunk<CR>
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
    " Nerdcommenter {{{
        let g:NERDSpaceDelims = 1           " Include a space after comment delimiters
    " }}}
    " Nerdtree {{{
        " Toggle the tree
        nnoremap <silent> <Leader>ot :NERDTreeToggle<CR>
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
    " Neomake {{{
        " Let there be linters
        let g:neomake_python_enabled_makers = ['pylint']
        " Run Neomake
        nnoremap <Leader>ln :Neomake<CR>
        " Open lint window (and move cursor back to original window)
        nnoremap <silent> <Leader>ll :lwindow<CR><C-w>k
        " Close lint window
        nnoremap <silent> <Leader>lc :lclose<CR>
        " Next lint list option
        nnoremap <silent> <Down> :lnext<CR>
        " Previous lint list option
        nnoremap <silent> <Up> :lprev<CR>
    " }}}
" }}}
" ====================================================================
" vim:foldmethod=marker:foldlevel=0
