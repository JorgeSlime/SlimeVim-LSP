return {
          -- your configuration comes here
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
          require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
		dependencies = {
			"williamboman/mason.nvim"
		},
		opts = {
			auto_install = true,
		},
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = { "lua_ls","clangd" }
			})
		end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            local lspconfig = require("lspconfig")
            --local navic = require("nvim-navic")
            --local on_attach = function(client, bufnr)
            --    if client.server_capabilities.documentSymbolProvider then
            --        navic.attach(client, bufnr)
            --    end
            --end
            --FOR C++
            lspconfig.clangd.setup({
                capabilities = capabilities,
                --on_attach= on_attach
            })

            -- FOR LUA
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                 settings = {
                    Lua = {
                      runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ";"),
                      },
                      diagnostics = {
                        globals = { "vim" },
                      },
                      workspace = {
                        library = { vim.env.VIMRUNTIME },
                        checkThirdParty = false,
                      },
                      telemetry = {
                        enable = false,
                      },
                    },
                },
            })

            --FOR C#
            lspconfig.csharp_ls.setup({
                capabilities = capabilities,
                cmd ={ "csharp-ls" },
                init_options= {AutomaticWorkspaceInit = true},
                filetypes ={"cs"}
            })

            --FOR LaTeX
            lspconfig.texlab.setup({
                capabilities = capabilities,
                cmd={ "texlab" },
                filetypes = { "tex", "plaintex", "bib" },
                settings={
                    texlab = {
                      auxDirectory = ".",
                      bibtexFormatter = "texlab",
                      build = {
                        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                        executable = "latexmk",
                        forwardSearchAfter = false,
                        onSave = false
                      },
                      chktex = {
                        onEdit = false,
                        onOpenAndSave = false
                      },
                      diagnosticsDelay = 300,
                      formatterLineLength = 80,
                      forwardSearch = {
                        args = {}
                      },
                      latexFormatter = "latexindent",
                      latexindent = {
                        modifyLineBreaks = false
                      },
                    },
                }
            })
            --FOR BASH
            lspconfig.bashls.setup({
                capabilities = capabilities,
                settings={
                    {
                        bashIde = {
                            globPattern = "*@(.sh|.inc|.bash|.command)",
                        },
                    },
                    cmd={ "bash-language-server", "start" },
                },
            })
            --FOR  HTML

            lspconfig.html.setup({
                capabilities = capabilities,
                on_attach = function (client, bufnr)
                    client.server_capabilities.document_formatting = false
                    on_attach(client, bufnr)
                end,
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                    provideFormatter = true,
                },
            })
            --FRON CSS
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            -- FOR javascript ans Typescrpt
            local servers = {'tsserver','eslint'}
            for _, lsp in pairs(servers) do
                lspconfig[lsp].setup {
                    --on_attach = on_attach,
                    capabilites = capabilities,
                }
            end
        end
    }
}
