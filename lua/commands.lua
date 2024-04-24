-- Funcion de notify de bienvenida
function welcome()
    local text = "UwU"
    vim.notify("Bienvenido JorgeSlime", 'info', {
        title = text,
        timeout=3000,
        render = "simple",
        stages = "slide",
    })
end
vim.cmd([[autocmd VimEnter * lua welcome()]])
-------------------------------------------------------------------
-- Definir la función en Lua
function OpenInput()
    -- Abrir el archivo input.txt en una nueva ventana vertical
    vim.cmd('vsplit input.txt')
end
vim.cmd('command! INPUT lua OpenInput()')

---------------------------------------------------------------------

function compile_program()
    local program_name = vim.fn.expand('%:r')
    local compile_command = 'g++ -std=c++20 -O2 -Wall -Wextra -Wunknown-pragmas -o "' .. program_name .. '" "' .. vim.fn.expand('%') .. '"'
    -- Compilar el programa
    local compile_output = vim.fn.systemlist(compile_command)
    -- Verificar si hubo errores de compilación
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_err_writeln('Error de compilación:')
        for _, error_line in ipairs(compile_output) do
            vim.api.nvim_err_writeln(error_line)
        end
    else
        vim.notify("Programa compilado correctamente")
        --print('Programa compilado correctamente')
    end
end
function compile_programXD()
    local original_program_name = vim.fn.expand('%:r')
    local program_name = string.gsub(original_program_name, ' ', '_')  -- Reemplazar espacios por guiones bajos en el nombre

    local compile_command = 'g++ -std=c++20 -O2 -Wall -Wextra -Wunknown-pragmas -o "' .. original_program_name .. '" "' .. vim.fn.expand('%') .. '"'
    -- Compilar el programa
    local compile_output = vim.fn.systemlist(compile_command)
    -- Verificar si hubo errores de compilación
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_err_writeln('Error de compilación:')
        for _, error_line in ipairs(compile_output) do
            vim.api.nvim_err_writeln(error_line)
        end
    else
        print('Programa compilado correctamente')
    end
end
--vim.cmd('command! compilar lua compile_program()')
vim.api.nvim_set_keymap('n', '<C-x>', '<cmd>lua compile_program()<cr>', { noremap = true, silent = true })
vim.cmd('command! CC lua compile_program()')
-------------------------------------------------------------------------------------------------------------------------

-- Correr programa C++
function RunProgram()
    local program_name = vim.fn.expand('%:r')
    local run_command = './\'' .. program_name .. '\''
    -- Ejecutar el programa en una ventana a la izquierda o en una división vertical
    vim.cmd('leftabove vsplit term://' .. program_name)
    vim.cmd('terminal ' .. run_command)
    vim.cmd('startinsert')
end
vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua RunProgram()<cr>', { noremap = true, silent = true })

----------------------------------------------------------------------------------------------------------

-- Define la función RunProgramIO con nombre de archivo estático
function RunProgramIO()
    local program_name = vim.fn.expand('%:r')
    local input_file = 'input.txt'
    local run_command = './\'' .. program_name .. '\' < \'' .. input_file .. '\''

    -- Ejecutar el programa en una ventana a la izquierda o en una división vertical
    vim.cmd('leftabove vsplit term://' .. program_name)
    vim.cmd('terminal ' .. run_command)
    vim.cmd('startinsert')
end
-- Define el keymapping con Ctrl+Alt+B para ejecutar RunProgramIO
vim.api.nvim_set_keymap('n', '<C-A-b>', ':lua RunProgramIO()<CR>', { noremap = true, silent = true })

-------------------------------------------------------------------------------------------------------------

-- Define la función para ejecutar el programa con temrinal de eleccion 
function RunProgramTerminal()
    local program_name = vim.fn.expand('%:r')

    -- Generar el comando para ejecutar el programa compilado en una nueva terminal
    local run_command = 'tilix -e /bin/bash -c \'./"' .. program_name .. '"; echo; read -p "Pulse_intro_para_salir..."\''

    -- Ejecutar el comando en el sistema
    os.execute(run_command)
end

vim.cmd('command! XD lua RunProgramTerminal()')

----------------------------------------------------------------------------------------------------------------------------

-- Define la función para ejecutar el programa con temrinal de eleccion  pero con un archivp por parametro
function RunProgramTerminalIO()
    -- Obtener el nombre del programa compilado
    local program_name = vim.fn.expand('%:r')

    -- Nombre del archivo de entrada
    local input_file = 'input.txt'

    -- Generar el comando para ejecutar el programa con el archivo de entrada
    local run_command = 'tilix -e bash -c \'./"' .. program_name .. '" < "' .. input_file .. '"; echo; read -p "Pulse_intro_para_salir..."\''

    -- Ejecutar el comando en la terminal
    local handle = io.popen(run_command)
    local result = handle:read("*a")
    handle:close()

    -- Mostrar el resultado en un mensaje
    vim.api.nvim_out_write(result)
end

vim.cmd('command! XDD lua RunProgramTerminalIO()')


------------------------------------------------------------------{


-- Define la función para compilar el documento LaTeX con pdflatex y -shell-escape
function CompileWithPdflatex()
  -- Nombre del archivo actual sin extensión
  local filename = vim.fn.expand('%:r')

  -- Nombre del archivo de registro
  local log_filename = filename .. '.log'

  -- Comando para compilar el documento con pdflatex y -shell-escape
  local compile_command = 'pdflatex -shell-escape ' .. filename .. '.tex > ' .. log_filename .. ' 2>&1'

  -- Ejecutar el comando en el sistema
  local status = os.execute(compile_command)

  -- Comprobar el estado de la compilación
  if status == 0 then
     vim.notify("Programa compilado correctamente")
    --print('El programa se ha compilado correctamente.')
    -- Comando para abrir el archivo PDF generado en Zathura en segundo plano
    local view_command = 'zathura ' .. filename .. '.pdf' .. ' &'
    -- Ejecutar el comando en el sistema
    os.execute(view_command)
  else
    print('Error: El programa no se ha compilado correctamente. Revisa el archivo ' .. log_filename .. ' para obtener más detalles.')
  end
end
-- Asignar la función a un comando Vim
vim.cmd('command! LLL lua CompileWithPdflatex()')




