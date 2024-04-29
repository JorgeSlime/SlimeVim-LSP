return{
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({})
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        }
    }
}
--return{
--    {
--        "utilyre/barbecue.nvim",
--        name = "barbecue",
--        version = "*",
--        dependencies = {
--          "SmiteshP/nvim-navic",
--          "nvim-tree/nvim-web-devicons", -- optional dependency
--        },
--        opts = {
--          -- configurations go here
--        },
--    }
--}
