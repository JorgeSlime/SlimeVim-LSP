return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-refactor'
    },
    main = 'nvim-treesitter.configs',
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "cpp","lua", "vim", "vimdoc", "query","python","html","rust","bash","latex","c_sharp"},
            highlight = {
                enable = true,
                use_languagetree = true,
            },
            indent = { enable = true },
        }
    end
}

