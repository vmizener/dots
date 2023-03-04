-- Bootstrap Lazy if necessary {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}
--

local plugins = {
    -- Mason: external tooling package manager {{{
    {
        'williamboman/mason.nvim',
        dependencies = {
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
                ensure_installed = {
                    "bashls",
                    "pyright",
                    "lua_ls",
                },
            })
        end
    },
    -- }}}
    -- LSP-Rooter automatically sets the working directory to the project root {{{
    {
        "ahmedkhalf/lsp-rooter.nvim",
        config = function ()
            require("lsp-rooter").setup()
        end
    },
    -- }}}
    -- LSP Symbols {{{
    'simrat39/symbols-outline.nvim',
    -- }}}
    -- LSP Diagnostic Lines {{{
    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function ()
            local lsp_lines = require('lsp_lines')
            lsp_lines.setup()
            -- Disable default diagnostics as it's redundant with this plugin
            vim.diagnostic.config({ virtual_text = false })
            -- Set diagnostic virtual text colorscheme
            vim.api.nvim_create_augroup('ColorLspLines', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                command = 'hi link DiagnosticVirtualTextError DiagnosticFloatingError',
                group = 'ColorLspLines'
            })
            vim.api.nvim_create_autocmd('ColorScheme', {
                command = 'hi link DiagnosticVirtualTextWarn DiagnosticFloatingWarn',
                group = 'ColorLspLines'
            })
            vim.api.nvim_create_autocmd('ColorScheme', {
                command = 'hi link DiagnosticVirtualTextInfo DiagnosticFloatingInfo',
                group = 'ColorLspLines'
            })
            vim.api.nvim_create_autocmd('ColorScheme', {
                command = 'hi link DiagnosticVirtualTextHint DiagnosticFloatingHint',
                group = 'ColorLspLines'
            })
        end
    },
    -- }}}
    -- Treesitter {{{
    {
        'nvim-treesitter/nvim-treesitter',
        build = function () vim.cmd('TSUpdate') end,
        config = function ()
            require('nvim-treesitter.configs').setup({
                --ensure_installed = "maintained",
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
            })
        end
    },
    -- }}}

    -- Auto-Completion {{{
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'onsails/lspkind-nvim',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    -- }}}

    -- DAP {{{
    {
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
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function ()
            require('nvim-dap-virtual-text').setup()
            vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='', linehl='', numhl='' })
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        config = function ()
            require('dap-python').setup(vim.g['python3_host_prog'])
        end
    },
    -- }}}

    -- BQF provides a better quickfix list {{{
    {
        'kevinhwang91/nvim-bqf',
        config = function ()
            require('bqf').setup({})
        end
    },
    -- }}}
    -- Bufferline adds fancy tabs for buffers {{{
    {
	'akinsho/bufferline.nvim', --tag = "v3.*",
        dependencies = {'kyazdani42/nvim-web-devicons', lazy = true },
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
    },
    -- }}}
    -- Black is an autoformatter for Python {{{
    {
        'psf/black',
        ft = 'python'
    },
    -- }}}
    -- Colorizer automatically highlights color codes {{{
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup(nil, {
                --names = false,
            })
        end
    },
    -- }}}
    -- Dressing improves nvim UI default interfaces (like using Telescope) {{{
    {
        'stevearc/dressing.nvim',
        config = function ()
            require('dressing').setup()
        end
    },
    -- }}}
    -- Fidget provides a progress indicator for the LSP {{{
    {
        'j-hui/fidget.nvim',
        config = function()
            require("fidget").setup()
        end
    },
    -- }}}
    -- Fugitive is a Git wrapper for Vim {{{
    'tpope/vim-fugitive',
    -- }}}
    -- Gitsigns provides Git diff and blame info {{{
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup({ yadm = { enable = true }, })
        end
    },
    -- }}}
    -- Gruvbox is a colorscheme for Vim {{{
    {
        'sainnhe/gruvbox-material',
        config = function ()
            vim.o.termguicolors = true
            -- Options: 'hard', 'medium', 'soft'
            vim.g['gruvbox_material_background'] = 'medium'
            vim.api.nvim_command('colorscheme gruvbox-material')
        end
    --    "folke/tokyonight.nvim",
    --    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --    priority = 1000, -- make sure to load this before all the other start plugins
    --    config = function()
    --      -- load the colorscheme here
    --      vim.cmd([[colorscheme tokyonight]])
    --    end
    },
    -- }}}
    -- IndentLine provides an indentation guide {{{
    {
        'Yggdroot/indentLine',
        config = function ()
            vim.g['indentLine_char'] = '┆'
        end
    },
    -- }}}
    -- Lualine provides a better status line and a tab bar, in lua {{{
    {
        'hoob3rt/lualine.nvim',
        dependencies = {'kyazdani42/nvim-web-devicons', lazy = true },
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
    },
    -- }}}
    -- Peekaboo displays a preview window of register contents {{{
    'junegunn/vim-peekaboo',
    -- }}}
    -- Pounce is a motion plugin akin to Hop/Sneak/Lightspeed with fuzzy matching {{{
    {
        'rlane/pounce.nvim',
        config = function ()
            vim.keymap.set('n', 's', ':Pounce<CR>')
            vim.keymap.set('n', 'S', ':PounceRepeat<CR>')
        end
    },
    -- }}}
    -- Startify is a fancy start page for Vim {{{
    'mhinz/vim-startify',
    -- }}}
    -- Telescope is an extensible fuzzy finder tool {{{
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim'
        },
        config = function ()

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
        end
    },
    -- }}}
    -- ToggleTerm provides better terminal integration {{{
    {
        'akinsho/toggleterm.nvim',
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
    },
    -- }}}
    -- Transparent makes Neovim transparent {{{
    {
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
    },
    -- }}}
    -- Vim-cool smartly toggles search highlighting automatically {{{
    'romainl/vim-cool',
    -- }}}
    -- Vim-OSCyank has vim use OSC52 to copy to the system clipboard {{{
    'ojroques/nvim-osc52',
    -- }}}
    -- VimTex for Tex {{{
    {
        'lervag/vimtex',
        ft = 'tex'
    },
    -- }}}
}

local opts = {
}

require("lazy").setup(plugins, opts)
-- vim: set foldmethod=marker foldlevel=0 :
