#!/usr/bin/env python3
import subprocess
import getpass

# Solicita al usuario que ingrese la contraseña
password = getpass.getpass("Ingresa la contraseña para desencriptar el archivo: ")

# Desencripta el archivo
result = subprocess.run(["gpg", "--batch", "--yes", "--passphrase", password, "--output",
                ".data/SystemSpec.sh", "--decrypt", ".data/SystemSpec.sh.gpg"], stderr=subprocess.DEVNULL)

if result.returncode != 0:
    print("Error al desencriptar el archivo. Saliendo...")
else:
    # Ejecuta el archivo desencriptado
    try:
        subprocess.run(["bash", ".data/SystemSpec.sh"])
    except:
        print("\nSaliendo...")
