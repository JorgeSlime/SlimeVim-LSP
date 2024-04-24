return {
    {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline"
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snippets"})
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                  completion = cmp.config.window.bordered(),
                  documentation = cmp.config.window.bordered(),
                },
                 mapping = {
                  ['<C-Space>'] = require('cmp').mapping.complete(),
                  ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
                  ['<C-e>'] = require('cmp').mapping.close(),
                  ['<Tab>'] = require('cmp').mapping.select_next_item(),
                  ['<S-Tab>'] = require('cmp').mapping.select_prev_item(),
                },
                sources = {
                  { name = "nvim_lsp" },
                  { name = "luasnip" }, -- Utilizar UltiSnips como fuente de snippets
                  { name = "buffer" },
                },
            })
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                { name = 'buffer' }
              }
            })
            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline' }
              }),
              matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}
