local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- Cambiar entre ventanas 
map('n', '<C-l>', ':BufferNext<CR>', opts)
map('n', '<C-h>', ':BufferPrevious<CR>', opts)
map('n', '<C-w>', ':BufferClose<CR>',opts)
-- Para abrir nuevas ventanas
map('n', '<C-n>', ':tabnew<CR>',opts)

--Utilidades
-- Mapeo para copiar todo
map('n', '<C-a>', '<Esc>ggVG<CR>', opts)
-- Mapeo para simular Ctrl c
map('v', '<C-c>', '"+y', { noremap = true })

-- Abrir Alpha Dashborad
map('n', '<C-z>', ':Alpha<CR>', opts)

-- Mapeo para Telescope
map('n', '<C-f>', '<cmd>Telescope find_files<cr>', opts)
--map('n', '<A-f>', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<A-f>', '<cmd>Telescope oldfiles<cr>', opts)

-- Split commands
map('n', '<A-l>', '<C-w>l', opts)
map('n', '<A-h>', '<C-w>h', opts)
map('n', '<A-v>', '<C-w>v', opts)
-- Definir una función para reemplazar <Esc> con <C-\><C-n>
function my_escape_mapping()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true), "n", true)
end

-- Crear el mapeo de tecla en modo normal y modo visual
vim.api.nvim_set_keymap('t', '<Esc>', '<cmd>lua my_escape_mapping()<CR>', { noremap = true, silent = true })






