#!/usr/bin/env python3

from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive

# Crea una instancia de GoogleAuth y autentica al usuario
gauth = GoogleAuth()
gauth.LocalWebserverAuth()

# Crea una instancia de GoogleDrive utilizando la autenticación de GoogleAuth
drive = GoogleDrive(gauth)

# Define la ruta del archivo comprimido generado por el script de backup
backup_file = "/home/$(whoami)/*.tar.gz"

# Crea un objeto de archivo de PyDrive para el archivo de backup
file = drive.CreateFile({'title': 'backup.tar.gz'})

# Define la ruta del archivo en el sistema de archivos y lo carga al objeto de archivo de PyDrive
file.SetContentFile(backup_file)

# Sube el archivo a Google Drive
file.Upload()
