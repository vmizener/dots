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

--
-- After modifying plugins, resync with :PackerSync
--

return require('packer').startup(function(use)

    -- LSP Config/Installer {{{
    use {
        'williamboman/nvim-lsp-installer',
        requires = { 'neovim/nvim-lspconfig' },
        config = function ()
            local lsp_installer = require('nvim-lsp-installer')

            local function on_attach(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                utils.buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { noremap=true, silent=true }
                utils.buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                utils.buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                utils.buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                utils.buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                utils.buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                utils.buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                utils.buf_map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                utils.buf_map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                utils.buf_map('n', '<Leader>j', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
                utils.buf_map('n', '<Leader>k', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
                utils.buf_map('n', '<Leader>f', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)

            end

            -- Register a handler that will be called for each installed server when it's ready
            -- (i.e. when installation is finished or if the server is already installed).
            lsp_installer.on_server_ready(function(server)
                local opts = {
                    on_attach = on_attach,
                }

                if server.name == "sumneko_lua" then
                    local runtimepath = vim.split(package.path, ';')
                    table.insert(runtimepath, 'lua/?.lua')
                    table.insert(runtimepath, 'lua/?/init.lua')
                    opts.settings = {
                        Lua = {
                            runtime = { version = "LuaJIT", path = runtimepath, },
                            diagnostics = { globals = { "vim" }, },
                            telemetry = { enable = false, },
                            workspace = {
                                -- Make the server aware of Neovim config files
                                library = vim.fn.stdpath("config")
                            },
                        }
                    }
                end

                server:setup(opts)
            end)

        end

    }
    -- }}}
    -- LSP-Rooter automatically sets the working directory to the project root {{{
    use { "ahmedkhalf/lsp-rooter.nvim", config = function()
        require("lsp-rooter").setup()
    end }
    -- }}}
    -- LSP Symbols {{{
    use {
        'simrat39/symbols-outline.nvim',
        config = function ()
            utils.map('n', '<Leader>ss', ':SymbolsOutline<CR>', { noremap = true, silent = true } )
        end
    }
    -- }}}
    -- Treesitter {{{
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function () vim.cmd('TSUpdate') end,
        config = function ()
            require('nvim-treesitter.configs').setup({
                --ensure_installed = "maintained",
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
            })
        end
    }
    -- }}}

    -- Auto-Completion {{{
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'onsails/lspkind-nvim'
    -- }}}

    -- DAP {{{
    use {
        'mfussenegger/nvim-dap',
        config = function ()
            -- See `:help dap.txt` for documentation on how nvim-dap functions
            local opts = { noremap=true, silent=true }
            utils.map('n', '<F9>', ':lua require("dap").toggle_breakpoint()<CR>', opts)
            utils.map('n', '<F10>', ':lua require("dap").step_over()<CR>', opts)
            utils.map('n', '<F11>', ':lua require("dap").step_into()<CR>', opts)
            utils.map('n', '<F12>', ':lua require("dap").step_out()<CR>', opts)
            utils.map('n', '<F5>', ':lua require("dap").continue()<CR>', opts)
            utils.map('n', '<S-F5>', ':lua require("dap").stop()<CR>', opts)
            utils.map('n', '<Leader>dr', ':lua require("dap").repl.open()<CR>', opts)
            utils.map('n', '<Leader>dj', ':lua require("dap").down()<CR>', opts)
            utils.map('n', '<Leader>dk', ':lua require("dap").up()<CR>', opts)
            utils.map('n', '<Leader>di', ':lua require("dap.ui.widgets").hover()()<CR>', opts)
        end
    }
    use {
        'theHamsta/nvim-dap-virtual-text',
        after = { 'nvim-dap' },
        config = function ()
            require('nvim-dap-virtual-text').setup()
            vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='', linehl='', numhl='' })
        end
    }
    use {
        'mfussenegger/nvim-dap-python', config = function ()
            require('dap-python').setup(vim.g['python3_host_prog'])
        end
    }
    -- }}}

    -- BQF provides a better quickfix list {{{
    use {
        'kevinhwang91/nvim-bqf',
        config = function ()
            require('bqf').setup({})
        end
    }
    -- }}}
    -- Bufferline adds fancy tabs for buffers {{{
    use {
        'akinsho/nvim-bufferline.lua', tag = 'v2.*',
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
    use {
        'psf/black',
        ft = 'python'
    }
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
    -- Dressing improves nvim UI default interfaces (like using Telescope) {{{
    use {
        'stevearc/dressing.nvim',
        config = function ()
            require('dressing').setup()
        end
    }
    -- }}}
    -- Fidget provides a progress indicator for the LSP {{{
    use {
        'j-hui/fidget.nvim',
        config = function()
            require("fidget").setup()
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
            require('gitsigns').setup({ yadm = { enable = true }, })
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
    -- Lualine provides a better status line and a tab bar, in lua {{{
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        after = { 'gitsigns.nvim' },
        config = function ()
            local function get_git_status()
                local status_dict = vim.b['gitsigns_status_dict']
                if not status_dict then return {} else
                    return {
                        added = status_dict.added,
                        modified = status_dict.changed,
                        removed = status_dict.removed,
                    }
                end
            end
            require('lualine').setup({
                sections = {
                    lualine_a = { 'mode', { function () return 'ᑭ' end, cond = function () return vim.o['paste'] end } },
                    lualine_b = { { 'b:gitsigns_head', icon = '' }, { 'diff', source = get_git_status } },
                    lualine_c = { 'filename'},
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { { 'diagnostics', sources = { 'nvim_lsp' } } },
                    lualine_z = { 'progress', { 'location', icon = '' } }
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
    -- Pounce is a motion plugin akin to Hop/Sneak/Lightspeed with fuzzy matching {{{
    use { 'rlane/pounce.nvim', config = function ()
        utils.map('n', 's', ':Pounce<CR>')
        utils.map('n', 'S', ':PounceRepeat<CR>')
        utils.map('v', 's', ':Pounce<CR>')
    end }
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
        after = { 'telescope-fzf-native.nvim' },
        config = function ()
            utils.map('n', '<Leader>ot', ':Telescope file_browser<CR>')
            utils.map('n', '<Leader>of', ':Telescope find_files hidden=true<CR>')
            utils.map('n', '<Leader>oF', ':Telescope find_files cwd=~ hidden=true<CR>')
            utils.map('n', '<Leader>og', ':Telescope live_grep<CR>')
            utils.map('n', '<Leader>ob', ':Telescope buffers<CR>')
            utils.map('n', '<Leader>oh', ':Telescope help_tags<CR>')

            utils.map('n', '<Leader>od', ':Telescope diagnostics<CR>')
            utils.map('n', '<Leader>ca', ':Telescope lsp_code_actions<CR>')
            utils.map('v', '<Leader>ca', ':Telescope lsp_range_code_actions<CR>')

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
                        '.cache/.*',
                        '.git/.*',
                        'node_modules/.*',
                        '%.pyc',
                    },
                    layout_strategy = 'flex',
                },
                pickers = {
                    find_files = {
                        theme = "dropdown",
                        previewer = false,
                    },
                },
            })
            require('telescope').load_extension('fzf')
        end
    }
    -- Telescope Extensions {{{
    -- Telescope-fzf-native allows telescope to leverage fzf through native lua {{{
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }
    -- }}} }}}
    -- }}}
    -- ToggleTerm provides better terminal integration {{{
    use {
        'akinsho/toggleterm.nvim', tag = 'v1.*',
        config = function ()
            require('toggleterm').setup({
                open_mapping = [[<C-\>]],
                close_on_exit = true,
                direction = 'float',
                float_opts = {
                    border = 'curved',
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
                extra_groups = {
                    "Folded",
                },
                exclude = {}, -- table: groups you don't want to clear
            })
        end
    }
    -- }}}
    -- Vim-cool smartly toggles search highlighting automatically {{{
    use 'romainl/vim-cool'
    -- }}}
    -- Vim-OSCyank has vim use OSC52 to copy to the system clipboard {{{
    use 'ojroques/vim-oscyank'
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
