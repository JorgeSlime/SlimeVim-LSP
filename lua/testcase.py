import subprocess
import difflib
import os
import sys

def compile_code(source_file, executable):
    print("Compilando el programa...")
    result = subprocess.run(['g++', '-std=c++20', '-O2', '-Wextra', '-Wunknown-pragmas', '-DSLIME', '-o', executable, source_file])
    if result.returncode != 0:
        print("\033[91mError: No se pudo compilar el programa.\033[0m")  # Rojo
        return False
    return True

def run_and_compare(executable, input_file, output_file):
    temp_output = "temp_output.txt"

    # Ejecutar el programa
    with open(input_file, 'r') as infile, open(temp_output, 'w') as outfile:
        subprocess.run(['./' + executable], stdin=infile, stdout=outfile)

    if not os.path.exists(output_file):
        print("\033[93mWarning: El archivo de salida esperado no existe. Mostrando solo el output generado.\033[0m\n")  # Amarillo
        with open(temp_output, 'r') as temp_out:
            print("Input:\n" + open(input_file).read())
            print("\nOutput generado:\n" + temp_out.read())
        os.remove(temp_output)
        return

    # Comparar la salida generada con la salida esperada
    with open(temp_output, 'r') as temp_out, open(output_file, 'r') as expected_out:
        temp_lines = temp_out.readlines()
        expected_lines = expected_out.readlines()

    print("Input:\n" + open(input_file).read())

    if temp_lines == expected_lines:
        print("\nOutput generado:\n" + "".join(temp_lines))
        print("\033[92mVeredicto: Accepted\033[0m")  # Verde
    else:
        print("\nOutput generado:\n" + "".join(temp_lines))
        print("\nOutput esperado:\n" + "".join(expected_lines))
        print("\033[91mVeredicto: Wrong Answer\033[0m")  # Rojo

    os.remove(temp_output)

def main():
    if len(sys.argv) != 4:
        print("Uso: python3 test_runner.py <source_file> <input_file> <output_file>")
        sys.exit(1)

    source_file = sys.argv[1]
    executable = 'test'
    input_file = sys.argv[2]
    output_file = sys.argv[3]

    if not compile_code(source_file, executable):
        return

    run_and_compare(executable, input_file, output_file)

if __name__ == "__main__":
    main()


