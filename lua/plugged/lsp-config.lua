return {
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
    --{
    --    "SmiteshP/nvim-navic",
    --    dependencies ={
    --        "neovim/nvim-lspconfig",
    --    }
    --},
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        lazy = false,
        config = function()  
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")
            --local navic = require("nvim-navic")
            lspconfig.clangd.setup({
                capabilities = capabilities,
                --on_attach = function(client, bufnr)
                --    navic.attach(client, bufnr)
                --end
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                 settings = {
                    Lua = {
                      runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        path = vim.split(package.path, ";"),
                      },
                      diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                      },
                      workspace = {
                        -- Make the server aware of Neovim runtime files and plugins
                        library = { vim.env.VIMRUNTIME },
                        checkThirdParty = false,
                      },
                      telemetry = {
                        enable = false,
                      },
                    },
                },
            })
            lspconfig.csharp_ls.setup({
                capabilities = capabilities,
                cmd ={ "csharp-ls" },
                init_options= {AutomaticWorkspaceInit = true},
                filetypes ={"cs"}
            })
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
        end
    }
}
