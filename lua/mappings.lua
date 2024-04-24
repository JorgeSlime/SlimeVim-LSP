-- Cambiar entre ventanas 
vim.keymap.set('n', '<C-l>', ':BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<C-h>', ':BufferLineCyclePrev<CR>', { silent = true })

-- Para abrir nuevas ventanas
vim.keymap.set('n', '<C-n>', ':tabnew<CR>', { silent = true })

--Utilidades
-- Mapeo para copiar todo
vim.keymap.set('n', '<C-a>', '<Esc>ggVG<CR>', { silent = true })
-- Mapeo para simular Ctrl c
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true })
-- Comando para abrir una terminal flotante
vim.keymap.set('n', '<C-t>', ':FloatermToggle<CR>', { silent = true })
-- Mapeo para cerrar buffer(pestaña) en Bufferline
vim.keymap.set('n', '<C-w>', ':Bdelete<CR>', opts)

-- Abrir Alpha Dashborad
vim.keymap.set('n', '<C-z>', ':Alpha<CR>', opts)

-- Mapeo para Telescope
vim.keymap.set('n', '<C-f>', '<cmd>Telescope find_files<cr>', opts)
--vim.keymap.set('n', '<A-f>', '<cmd>Telescope live_grep<cr>', opts)
vim.keymap.set('n', '<A-f>', '<cmd>Telescope oldfiles<cr>', opts)

-- Split commands
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-v>', '<C-w>v', opts)


