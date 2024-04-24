vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
return {
  {
    -- Manejo avanzado de paréntesis y repetición
    "tpope/vim-surround",
    "cohama/lexima.vim",
    "tpope/vim-repeat",
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require('indent_blankline').setup {
            char = '|',
            char_blankline = '┆',
            show_trailing_blankline_indent = false,
            filetype_exclude = { 'help', 'terminal' },
            buftype_exclude = { 'terminal' },
            show_current_context = true,
        }
    end
  }
}

