#!/usr/bin/env python3
import sys
from pydrive2.auth import GoogleAuth
import gdrive as gd
from dotenv import load_dotenv
import os

# Carga las variables de entorno desde el archivo .env
load_dotenv()

# Obtiene el ID de carpeta de las variables de entorno
id_carpeta = os.getenv("ID_CARPETA")

# Obtiene las credenciales de la API de Google Drive de las variables de entorno
client_id = os.getenv("CLIENT_ID")
client_secret = os.getenv("CLIENT_SECRET")
directorio_home = os.getenv("DIRECTORIO_HOME")

# Usa las variables de entorno para acceder a la API de Google Drive
# ...

if len(sys.argv) < 2:
    print("Debes pasar el nombre del archivo como argumento")
    sys.exit(1)

max_archivo = 5

nombre_archivo = sys.argv[1]


print("Subiendo archivo: " + nombre_archivo)

gauth = GoogleAuth()
gauth.LocalWebserverAuth()

gd.subir_archivo(directorio_home+'/.home-backup/'+nombre_archivo, id_carpeta)

gd.max_archivo(id_carpeta, max_archivo)

print("Finalizado.")

print("GitHub: www.github.com/4DRIAN0RTIZ")

