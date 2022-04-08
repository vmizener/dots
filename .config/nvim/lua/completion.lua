local cmp = require('cmp')
local lspkind = require('lspkind')  -- Adds symbols to completion menu

cmp.setup({
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },

    sources = {
        -- Order indicates priority (top is highest)
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'buffer', keyword_length = 5 },  -- Only include buffer text after 5 characters typed
        { name = 'path' },
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',    -- Show type symbols
            with_text = true,   -- Show type name
            maxwidth = 50,      -- Restrict menu width
            menu = {
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                buffer = "[buf]",
                path = "[path]",
            }
        }),
    },

    experimental = {
        ghost_text = true,  -- Preview completion with virtual text
    },

})
