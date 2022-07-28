-- Bootstrap Packer if necessary {{{
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command('packadd packer.nvim')
end
-- }}}
-- Recompile on write {{{
local config_root_path = vim.fn.stdpath('config')
vim.api.nvim_create_augroup('PackerConfig', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern =  {
        config_root_path .. '/lua/*.lua',
        config_root_path .. '/init.lua',
    },
    command = 'PackerCompile',
    group = 'PackerConfig',
})
-- }}}

--
-- After modifying plugins, resync with :PackerSync
--

return require('packer').startup(function(use)

    -- Mason: external tooling package manager {{{
    use {
        'williamboman/mason.nvim',
        requires = {
            'neovim/nvim-lspconfig',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function ()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    }
                }
            })
            require("mason-lspconfig").setup({
                ensure_installed = { "sumneko_lua" },
            })
        end
    }
    -- }}}
    -- LSP-Rooter automatically sets the working directory to the project root {{{
    use { "ahmedkhalf/lsp-rooter.nvim", config = function ()
        require("lsp-rooter").setup()
    end }
    -- }}}
    -- LSP Symbols {{{
    use {
        'simrat39/symbols-outline.nvim',
        config = function ()
            vim.keymap.set('n', '<Leader>ss', ':SymbolsOutline<CR>', { noremap = true, silent = true } )
        end
    }
    -- }}}
    -- LSP Diagnostic Lines {{{
    use {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function ()
            local lsp_lines = require('lsp_lines')
            lsp_lines.setup()
            -- Disable default diagnostics as it's redundant with this plugin
            vim.diagnostic.config({ virtual_text = false })
            vim.keymap.set('n', '<Leader>l', lsp_lines.toggle, { desc = "Toggle lsp_lines" })
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
            vim.keymap.set('n', '<F9>', ':lua require("dap").toggle_breakpoint()<CR>', opts)
            vim.keymap.set('n', '<F10>', ':lua require("dap").step_over()<CR>', opts)
            vim.keymap.set('n', '<F11>', ':lua require("dap").step_into()<CR>', opts)
            vim.keymap.set('n', '<F12>', ':lua require("dap").step_out()<CR>', opts)
            vim.keymap.set('n', '<F5>', ':lua require("dap").continue()<CR>', opts)
            vim.keymap.set('n', '<S-F5>', ':lua require("dap").stop()<CR>', opts)
            vim.keymap.set('n', '<Leader>dr', ':lua require("dap").repl.open()<CR>', opts)
            vim.keymap.set('n', '<Leader>dj', ':lua require("dap").down()<CR>', opts)
            vim.keymap.set('n', '<Leader>dk', ':lua require("dap").up()<CR>', opts)
            vim.keymap.set('n', '<Leader>di', ':lua require("dap.ui.widgets").hover()()<CR>', opts)
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
            vim.keymap.set('n', '<Leader>gd', ':Gdiffsplit!<CR>', opts)
            vim.keymap.set('n', '<Leader>gD', '<C-w>h<C-w>c', opts)
            --vim.keymap.set('n', '<Leader>gc', ':G commit<CR>', opts)
            vim.keymap.set('n', '<Leader>gs', ':G status<CR>', opts)
        end
    }
    -- }}}
    -- Gitsigns provides Git diff and blame info {{{
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup({ yadm = { enable = true }, })
            vim.keymap.set('n', '<Leader>gj', ':Gitsigns next_hunk<CR>', { noremap = true, silent = true } )
            vim.keymap.set('n', '<Leader>gk', ':Gitsigns prev_hunk<CR>', { noremap = true, silent = true } )
        end
    }
    -- }}}
    -- Gruvbox is a colorscheme for Vim {{{
    use { 'sainnhe/gruvbox-material', config = function ()
        -- Options: 'hard', 'medium', 'soft'
        vim.g['gruvbox_material_background'] = 'medium'
        vim.api.nvim_command('colorscheme gruvbox-material')
    end }
    -- }}}
    -- IndentLine provides an indentation guide {{{
    use { 'Yggdroot/indentLine', config = function ()
        vim.g['indentLine_char'] = '┆'
        vim.keymap.set('n', '<Leader>i', ':IndentLinesToggle<CR>')
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
        vim.keymap.set('n', 's', ':Pounce<CR>')
        vim.keymap.set('n', 'S', ':PounceRepeat<CR>')
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
            local opts = { noremap=true, silent=true }
            vim.keymap.set('n', '<Leader>ot', ':Telescope file_browser<CR>', opts)
            vim.keymap.set('n', '<Leader>of', ':Telescope find_files hidden=true<CR>', opts)
            vim.keymap.set('n', '<Leader>oF', ':Telescope find_files cwd=~ hidden=true<CR>', opts)
            vim.keymap.set('n', '<Leader>og', ':Telescope live_grep<CR>', opts)
            vim.keymap.set('n', '<Leader>ob', ':Telescope buffers<CR>', opts)
            vim.keymap.set('n', '<Leader>oh', ':Telescope help_tags<CR>', opts)

            vim.keymap.set('n', '<Leader>od', ':Telescope diagnostics<CR>', opts)
            vim.keymap.set('n', '<Leader>ca', ':Telescope lsp_code_actions<CR>', opts)
            vim.keymap.set('v', '<Leader>ca', ':Telescope lsp_range_code_actions<CR>', opts)

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
