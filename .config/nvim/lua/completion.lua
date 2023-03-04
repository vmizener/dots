local cmp = require('cmp')
local lspkind = require('lspkind')  -- Adds symbols to completion menu
local luasnip = require('luasnip')

local function call_if_visible(func, fallback)
    if cmp.visible() then
        func()
    else
        fallback()
    end
end

cmp.setup({
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
        --['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = function(fb) call_if_visible(cmp.select_next_item, fb) end,
        ['<S-Tab>'] = function(fb) call_if_visible(cmp.select_prev_item, fb) end,
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },

    sources = {
        -- Order indicates priority (top is highest)
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', max_item_count = 8 },
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
                luasnip = "[snip]",
                buffer = "[buf]",
                path = "[path]",
            }
        }),
    },

    experimental = {
        ghost_text = true,  -- Preview completion with virtual text
    },

})
