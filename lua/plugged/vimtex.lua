vim.cmd('command! LL VimtexCompile')
vim.cmd('command! L VimtexView')
vim.cmd('command! CL VimtexClean')
return{
  "lervag/vimtex",
  init = function()
        vim.g.vimtex_view_method ='zathura'
        vim.g.tex_flavor='latex'
        vim.g.vimtex_quickfix_mode=0
        vim.g.tex_conceal='abdmg'
  end
}
