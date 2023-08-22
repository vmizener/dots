local lspconfig = require("lspconfig")
local available_configs = require("lspconfig.configs")
local utils = require("utils")

-- Helper functions
local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- Global hotkeys
utils.set_map_opts({noremap=true, silent=true})
utils.map('n', '<Leader>l', require("lsp_lines").toggle, "[LSP] Toggle lsp_lines")

-- LSP hotkeys
local function on_attach(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo['omnifunc'] = 'v:lua.vim.lsp.omnifunc'

    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    utils.set_map_opts({noremap=true, silent=true, buffer=bufnr})
    utils.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
        "[LSP] Jump to the declaration of the symbol")
    utils.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',
        "[LSP] Jump to the definition of the symbol")
    utils.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
        "[LSP] Display information about the symbol in a floating window")
    utils.map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
        "[LSP] Display signature information about the symbol")
    utils.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>',
        "[LSP] List all references of the symbol in the quickfix window")
    utils.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
        "[LSP] List all implementations of the symbol in the quickfix window")
    utils.map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
        "[LSP] Jump to the type definition of the symbol")
    utils.map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>',
        "[LSP] Rename the symbol")
    utils.map('n', '<Leader>j', '<cmd>lua vim.diagnostic.goto_next()<cr>',
        "[LSP] Jump to the next diagnostic message")
    utils.map('n', '<Leader>k', '<cmd>lua vim.diagnostic.goto_prev()<cr>',
        "[LSP] Jump to the previous diagnostic message")
    utils.map('n', '<Leader>f', '<cmd>lua vim.diagnostic.open_float()<cr>',
        "[LSP] Show diagnostics in a floating window")

end

---------------
-- LSP Configs:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- [Google3] CiderLSP: https://g3doc.corp.google.com/devtools/cider/ciderlsp/neovim/README.md?cl=head
local ciderlsp = '/google/bin/releases/cider/ciderlsp/ciderlsp'
if file_exists(ciderlsp) then
    available_configs.ciderlsp = {
        default_config = {
            cmd = { ciderlsp, '--tooltag=nvim-lsp', '--noforward_sync_responses' };
            filetypes = { "c", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl" },
            --offset_encoding = 'utf-8',
            root_dir = lspconfig.util.root_pattern('google3/*BUILD');
            settings = {};
        }
    }
    lspconfig.ciderlsp.setup({})
end

-- Golang
if file_exists("WORKSPACE") then
    -- If a Bazel WORKSPACE file is present, include some additional settings
    -- https://github.com/bazelbuild/rules_go/wiki/Editor-setup
    lspconfig.gopls.setup({
        on_attach = on_attach,
        settings = {
            gopls = {
                env = {
                    GOPACKAGESDRIVER = vim.env.HOME .. '/tools/gopackagesdriver.sh'
                },
                directoryFilters = {
                    "-bazel-bin",
                    "-bazel-out",
                    "-bazel-testlogs",
                    "-bazel-mypkg",
                }
        }
      }
    })
else
    lspconfig.gopls.setup({
       on_attach = on_attach
    })
end

-- Lua
local luaruntimepath = vim.split(package.path, ';')
table.insert(luaruntimepath, 'lua/?.lua')
table.insert(luaruntimepath, 'lua/?/init.lua')
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = luaruntimepath, },
            diagnostics = { globals = { "vim" }, },
            telemetry = { enable = false, },
            workspace = {
                -- Make the server aware of Neovim config files
                library = vim.fn.stdpath("config")
            },
        }
    }
})

-- Python
lspconfig.pyright.setup({
    on_attach = on_attach,
})

-- Shell
lspconfig.bashls.setup({
    on_attach = on_attach,
})
