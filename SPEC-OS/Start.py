#!/usr/bin/env python3

import subprocess
import getpass
import os

try:
    # Verificar si el archivo .gpg ya existe
    if os.path.isfile('./.data/spec-os.sh.gpg'):
        # Desencriptar archivo con contraseña
        password = getpass.getpass('Ingrese la contraseña: ')
        result = subprocess.run(['gpg', '-d', '--batch', '--yes', '--passphrase', password, './.data/spec-os.sh.gpg'], input=None, capture_output=True)
        if result.returncode == 0:
            # Ejecutar script desencriptado
            subprocess.run(['bash', './.data/spec-os.sh'])
        else:
            print('Error al desencriptar archivo')
    else:
        password = getpass.getpass('Ingrese la contraseña: ')
        # Encriptar archivo con contraseña
        result = subprocess.run(['gpg', '-c', '--batch', '--yes',
                                 '--passphrase', password,
                                 './.data/spec-os.sh'], input=None,
                                capture_output=True)
        # Verificar resultado de la encripción
        if result.returncode == 0:
            print('Contraseña establecida')
            print('Ejecutando Spec-OS...')
            subprocess.run(['bash', './.data/spec-os.sh'])
        else:
            print('Error al establecer contraseña')
            print('Error: ' + result.stderr.decode('utf-8'))
except KeyboardInterrupt:
    print('Interrupción de teclado detectada. Saliendo...')  # Coloca aquí el código que se ejecutará al detectarse la interrupción de teclado
