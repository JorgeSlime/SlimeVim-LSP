-- Configuración básica de NeoVim
vim.opt.number = true                   -- Mostrar números de línea
vim.opt.relativenumber = true           -- Mostrar números de línea relativos
vim.opt.tabstop = 4                     -- Tamaño de la tabulación
vim.opt.shiftwidth = 4                  -- Tamaño de indentación
vim.opt.expandtab = true                -- Utilizar espacios en lugar de tabulaciones
vim.opt.smartindent = true              -- Indentación automática inteligente
vim.opt.wrap = true                    -- Desactivar el ajuste automático de líneas
vim.opt.encoding = 'utf-8'              -- Codificación UTF-8
vim.opt.termguicolors = true     --for vim notify
vim.opt.mouse = 'a'                     -- Activar el uso del mouse
vim.opt.conceallevel = 2    --Activa el visor de latex 
vim.opt.concealcursor = 'nc'
vim.opt.spell=true
vim.opt.spelllang='es'
vim.cmd('syntax on')                     -- Activar la sintaxis

-- Habilitar las fuentes Nerd Fonts en los símbolos del tema de Airline
vim.g.airline_powerline_fonts = 1

-- Configurar las fuentes Nerd Fonts para los símbolos de indent-blankline
vim.g.indent_blankline_char = '│'  -- Puedes ajustar este valor según tus preferencias


