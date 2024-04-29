return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-refactor'
    },
    main = 'nvim-treesitter.configs',
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c","cpp","css","lua","vim","vimdoc","query","python","html","rust","bash","latex","c_sharp","javascript"},
            highlight = {
                enable = true,
                use_languagetree = true,
                disable={"latex"},
            },
            indent = { enable = true },
        }
    end
}

