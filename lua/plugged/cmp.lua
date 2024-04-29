return {
    {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "micangl/cmp-vimtex",
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local kind_icons = {
                article = "󰧮",
                book = "",
                incollection = "󱓷",
                Function = "󰊕",
                Constructor = "",
                Text = "󰦨",
                Method = "",
                Field = "󰅪",
                Variable = "󱃮",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "󰚯",
                Enum = "",
                Keyword = "",
                Snippet = "󰆐",
                Color = "󰌁",
                -- Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                -- EnumMember = "",
                Constant = "󰀫",
                Struct = "",
                -- Struct = "",
                Event = "",
                Operator = "󰘧",
                TypeParameter = "",
            }
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snippets"})
            local winhighlight = {
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
            }
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
                  --{ name = "html-css" },
                    { name = "vimtex" }
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                      vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) -- Kind icons
                      vim_item.menu = ({
                        -- vimtex = (vim_item.menu ~= nil and vim_item.menu or "[VimTex]"),
                        -- vimtex = test_fn(vim_item.menu, entry.source.name),
                        vimtex = vim_item.menu,
                        luasnip = "[Snippet]",
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        spell = "[Spell]",
                        -- orgmode = "[Org]",
                        -- latex_symbols = "[Symbols]",
                        cmdline = "[CMD]",
                        path = "[Path]",
                      })[entry.source.name]
                      return vim_item
                    end,
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
              sources = cmp.config.sources(
                    {{ name = 'path' }},
                    {{ name = 'cmdline' }}
                    --{{ name = "vimtex" }}
                ),
              matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}
