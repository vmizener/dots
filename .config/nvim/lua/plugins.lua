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
-- ####### Currently breaks lualine loading #######
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
                utils.buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                utils.buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                utils.buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                utils.buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                utils.buf_map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                utils.buf_map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                utils.buf_map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
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

    -- Fugitive is a Git wrapper for Vim {{{
    use { 'tpope/vim-fugitive', config = function ()
        -- map('n', '<Leader>gc', ':Git commit<CR>')
        -- map('n', '<Leader>gd', ':Gitdiffsplit!<CR>')
    end }
    -- }}}
    -- Gitsigns provides Git diff and blame info {{{
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
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
        config = function ()
            require('lualine').setup()
        end
    }
    -- }}}
    -- Peekaboo displays a preview window of register contents {{{
    use 'junegunn/vim-peekaboo'
    -- }}}
    -- Sneak for sneaky movement {{{
    use { 
        'justinmk/vim-sneak',
        config = function ()
            utils.apply_globals({
                ['sneak#use_ic_scs'] = 1,     -- Respect case-sensitivity settings
                ['sneak#label'] = 1,          -- Use labels
            })
            utils.map('n', 's', '<Plug>SneakLabel_s')
            utils.map('n', 'S', '<Plug>SneakLabel_S')
            utils.map('n', 'f', '<Plug>Sneak_f')
            utils.map('n', 'F', '<Plug>Sneak_F')
            utils.map('n', 't', '<Plug>Sneak_t')
            utils.map('n', 'T', '<Plug>Sneak_T')
        end
    }
    -- }}}
    -- Startify is a fancy start page for Vim {{{
    use 'mhinz/vim-startify'
    -- }}}
    -- Telescope is an extensible fuzzy finder tool {{{
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function ()
            utils.map('n', '<Leader>of', ':Telescope find_files<CR>')
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
    -- Vim-cool smartly toggles search highlighting automatically {{{
    use 'romainl/vim-cool'
    -- }}}
    -- Vim-css-color is a color-code highlighting plugin {{{
    use 'ap/vim-css-color'
    -- }}}

    -- Packer can manage itself {{{
    use 'wbthomason/packer.nvim'
    -- }}}
end)

-- vim:foldmethod=marker
