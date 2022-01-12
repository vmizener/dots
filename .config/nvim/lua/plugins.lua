utils = require('utils')

-- Bootstrap Packer if necessary {{{
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end
-- }}}
-- Automatically reload configs after writing {{{
--vim.cmd([[
--   autocmd BufWritePost ~/.config/nvim/init.lua,~/.config/nvim/lua/*.lua source <afile> | PackerCompile
--]])
-- }}}

--
-- After modifying plugins, resync with :PackerSync
--

return require('packer').startup(function(use)

    -- LSP config {{{
    use {
        'neovim/nvim-lspconfig',
        config = function()
            local nvim_lsp = require('lspconfig')

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                --Enable completion triggered by <c-x><c-o>
                utils.buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { noremap=true, silent=true }
                utils.buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                utils.buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                --utils.buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                --utils.buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                --utils.buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                utils.buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                utils.buf_map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                --utils.buf_map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                --utils.buf_map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                utils.buf_map('n', '<Leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
                utils.buf_map('n', '<Leader>j', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
                utils.buf_map('n', '<Leader>k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
                utils.buf_map('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

            end

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            local servers = { "pyright" }
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup {
                    on_attach = on_attach,
                    flags = {
                        debounce_text_changes = 150,
                    }
                }
            end
        end
    }
    -- }}}
    -- LSP UI {{{
    use {
        'glepnir/lspsaga.nvim',
        config = function()
            require('lspsaga').init_lsp_saga()
            local opts = { noremap=true, silent=true }
            utils.map('n', 'K', ':Lspsaga hover_doc<CR>', opts)
            utils.map('n', 'gr', ':Lspsaga lsp_finder<CR>', opts)
            utils.map('n', '<Leader>rn', ':Lspsaga rename<CR>', opts)
            utils.map('n', '<Leader>ca', ':Lspsaga code_action<CR>', opts)
            utils.map('v', '<Leader>ca', '<C-u>:Lspsaga range_code_action<CR>', opts)

            utils.map('n', '<M-d>', ':Lspsaga open_floaterm<CR>', opts)
            utils.map('t', '<M-d>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', opts)
        end
    }
    -- }}}
    -- Treesitter {{{
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function () vim.cmd('TSUpdate') end,
        config = function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = "maintained",
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
            })
        end
      }
    -- }}}
    -- Auto-Completion {{{
    use {
        'hrsh7th/nvim-compe',
        config = function ()
            require('compe').setup({
                enabled = true;
                autocomplete = true;
                debug = false;
                min_length = 1;
                preselect = 'enable';
                throttle_time = 80;
                source_timeout = 200;
                resolve_timeout = 800;
                incomplete_delay = 400;
                max_abbr_width = 100;
                max_kind_width = 100;
                max_menu_width = 100;
                documentation = {
                    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
                    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
                    max_width = 120,
                    min_width = 60,
                    max_height = math.floor(vim.o.lines * 0.3),
                    min_height = 1,
                };
                source = {
                    path = true;
                    buffer = true;
                    calc = true;
                    nvim_lsp = true;
                    nvim_lua = true;
                    vsnip = true;
                    ultisnips = true;
                    luasnip = true;
                }
            })
            utils.map('i', '<C-Space>', 'compe#complete()', { expr = true, noremap = true, silent = true } )
            utils.map('i', '<CR>', "compe#confirm('<CR>')", { expr = true, noremap = true, silent = true } )
            utils.map('i', '<C-e>', "compe#close('<C-e>')", { expr = true, noremap = true, silent = true } )
            utils.map('i', '<C-f>', "compe#scroll({ 'delta': +4 })", { expr = true, noremap = true, silent = true } )
            utils.map('i', '<C-d>', "compe#scroll({ 'delta': -4 })", { expr = true, noremap = true, silent = true } )
        end
    }

    -- }}}
    -- GUI Library {{{
    use 'ray-x/guihua.lua'
    -- }}}

    -- Bufferline adds fancy tabs for buffers {{{
    use { 
        'akinsho/nvim-bufferline.lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        config = function ()
            require("bufferline").setup({
                options = {
                    numbers = "buffer_id",
                    diagnostics = 'nvim_lsp',
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and "" or ""
                        return " " .. icon .. count
                    end
                }
            })
        end
    }
    -- }}}
    -- Black is an autoformatter for Python {{{
    use 'psf/black'
    -- }}}
    -- Colorizer automatically highlights color codes {{{
    use { 
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup(nil, {
                --names = false,
            })
        end
    }
    -- }}}
    -- Fugitive is a Git wrapper for Vim {{{
    use {
        'tpope/vim-fugitive',
        config = function ()
            local opts = { noremap=true, silent=true }
            utils.map('n', '<Leader>gd', ':Gdiffsplit!<CR>', opts)
            utils.map('n', '<Leader>gD', '<C-w>h<C-w>c', opts)
            --utils.map('n', '<Leader>gc', ':G commit<CR>', opts)
            utils.map('n', '<Leader>gs', ':G status<CR>', opts)
        end
    }
    -- }}}
    -- Gitsigns provides Git diff and blame info {{{
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup({
                yadm = { enable = true },
                status_formatter = function (status)
                    local added, changed, removed = status.added, status.changed, status.removed
                    local status_txt = {}
                    if added   and added   > 0 then table.insert(status_txt, '+'..added  ) end
                    if changed and changed > 0 then table.insert(status_txt, '~'..changed) end
                    if removed and removed > 0 then table.insert(status_txt, '-'..removed) end
                    return table.concat(status_txt, ' ')
                end
            })
            utils.map('n', '<Leader>gj', ':Gitsigns next_hunk<CR>', { noremap = true, silent = true } )
            utils.map('n', '<Leader>gk', ':Gitsigns prev_hunk<CR>', { noremap = true, silent = true } )
        end
    }
    -- }}}
    -- Gruvbox is a colorscheme for Vim {{{
    use { 'sainnhe/gruvbox-material', config = function ()
        utils.apply_options({
            termguicolors = true,
            -- Options: 'dark', 'light'
            background = 'dark',
        })
        utils.apply_globals({
            -- Options: 'hard', 'medium', 'soft'
            gruvbox_material_background = 'medium',
        })
        vim.api.nvim_command('colorscheme gruvbox-material')
    end }
    -- }}}
    -- IndentLine provides an indentation guide {{{
    use { 'Yggdroot/indentLine', config = function ()
        utils.apply_globals({ indentLine_char = '┆' })
        utils.map('n', '<Leader>i', ':IndentLinesToggle<CR>')
    end }
    -- }}}
    -- Lightspeed.nvim is the nvim successor to vim-sneak {{{
    use 'ggandor/lightspeed.nvim'
    -- }}}
    -- LSP-rooter automatically sets the working directory to the project root {{{
    use { "ahmedkhalf/lsp-rooter.nvim", config = function()
        require("lsp-rooter").setup()
    end }
    -- }}}
    -- Lualine provides a better status line and a tab bar, in lua {{{
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        after = { 'gitsigns.nvim' },
        config = function ()
            require('lualine').setup({
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {{'b:gitsigns_head', icon = ''}, 'b:gitsigns_status'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = { {'diagnostics', sources = {'nvim_lsp'}} },
                    lualine_z = {'progress', {'location', icon = ''}}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {{'location', icon = ''}},
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end
    }
    -- }}}
    -- Peekaboo displays a preview window of register contents {{{
    use 'junegunn/vim-peekaboo'
    -- }}}
    -- Sad provides project-wide replacement {{{
    use {
        'ray-x/sad.nvim',
        config = function ()
            require('sad').setup({
                diff = 'delta',
                exact = false,
            })
        end
    }
    -- }}}
    -- Startify is a fancy start page for Vim {{{
    use 'mhinz/vim-startify'
    -- }}}
    -- StartupTime profiles plugin startup times {{{
    use 'tweekmonster/startuptime.vim'
    -- }}}
    -- Telescope is an extensible fuzzy finder tool {{{
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function ()
            utils.map('n', '<Leader>ot', ':Telescope file_browser<CR>')
            utils.map('n', '<Leader>of', ':Telescope find_files<CR>')
            utils.map('n', '<Leader>oF', ':Telescope find_files cwd=~<CR>')
            utils.map('n', '<Leader>og', ':Telescope live_grep<CR>')
            utils.map('n', '<Leader>ob', ':Telescope buffers<CR>')
            utils.map('n', '<Leader>oh', ':Telescope help_tags<CR>')

            utils.map('n', '<Leader>od', ':Telescope lsp_document_diagnostics<CR>')

            local actions = require('telescope.actions')
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"]  = actions.move_selection_next,
                            ["<C-k>"]  = actions.move_selection_previous
                        }
                    },
                    file_ignore_patterns = {
                        '.git/.*',
                        'node_modules/.*',
                        '%.pyc',
                    },
                    layout_strategy = 'vertical'
                },
            })
        end
    }
    -- }}}
    -- Transparent makes Neovim transparent {{{
    use {
        'xiyaowong/nvim-transparent',
        config = function ()
            require("transparent").setup({
                enable = true, -- boolean: enable transparent
                extra_groups = 'all',
                exclude = {}, -- table: groups you don't want to clear
            })
        end
    }
    -- }}}
    -- Vim-cool smartly toggles search highlighting automatically {{{
    use 'romainl/vim-cool'
    -- }}}
    -- VimTex for Tex {{{
    use {
        'lervag/vimtex',
        ft = 'tex'
    }
    -- }}}

    -- Packer can manage itself {{{
    use 'wbthomason/packer.nvim'
    -- }}}
end)

-- vim: set foldmethod=marker foldlevel=0 :
