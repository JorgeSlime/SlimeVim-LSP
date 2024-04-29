return{
    {
        'akinsho/toggleterm.nvim', version = "*",
        config = function ()
            require("toggleterm").setup({
                open_mapping = [[<C-t>]],
                direction = 'horizontal'--'vertical' --| 'horizontal' | 'tab' | 'float',
            })
        end
    }
}

