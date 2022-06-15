require("nvim-lsp-installer").setup({})
local lspconfig = require("lspconfig")

local function on_attach(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo['omnifunc'] = 'v:lua.vim.lsp.omnifunc'

    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<Leader>j', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    vim.keymap.set('n', '<Leader>k', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', '<Leader>f', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)

end

-- Lua
local luaruntimepath = vim.split(package.path, ';')
table.insert(luaruntimepath, 'lua/?.lua')
table.insert(luaruntimepath, 'lua/?/init.lua')
lspconfig.sumneko_lua.setup({
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
