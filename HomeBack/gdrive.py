#!/usr/bin/env python3

from pydrive2.auth import GoogleAuth
from pydrive2.drive import GoogleDrive

directorio_credenciales = 'credentials_module.json'

# Iniciar Sesión
def login():
    gauth = GoogleAuth()
    gauth.LoadCredentialsFile(directorio_credenciales)
    if gauth.credentials is None:
        gauth.LocalWebserverAuth()
    elif gauth.access_token_expired:
        gauth.Refresh()
    else:
        gauth.Authorize()
    gauth.SaveCredentialsFile(directorio_credenciales)
    drive = GoogleDrive(gauth)
    return GoogleDrive(gauth)

# # Crear archivo texto simple

# def crear_archivo_texto(nombre_archivo, contenido, id_carpeta):
#     credenciales = login()
#     archivo = credenciales.CreateFile({'title': nombre_archivo, 'parents': [{'id': id_carpeta}]})
#     archivo.SetContentString(contenido)
#     archivo.Upload()

# Subir archivo

def subir_archivo(ruta_archivo, id_carpeta):
    credenciales = login()
    archivo = credenciales.CreateFile({'parents': [{'id': id_carpeta}]})
    archivo['title'] = ruta_archivo.split('/')[-1]
    archivo.SetContentFile(ruta_archivo)
    archivo.Upload()

# # Descargar archivo

# def descargar_archivo(id_archivo, ruta_descarga):
#     credenciales = login()
#     archivo = credenciales.CreateFile({'id': id_archivo})
#     nombre_archivo = archivo['title']
#     archivo.GetContentFile(ruta_descarga + nombre_archivo)

# # Buscar archivo

# def buscar_archivo(query):
#     resultado = []
#     credenciales = login()
#     # Archivos con el nombre 'backup': title = 'backup'
#     # Archivos que contengan 'backup' y 2023 en el nombre: title contains 'backup' and title contains '2023'
#     # Archivos que NO contengan 'backup' en el nombre: not title contains 'backup'
#     # Archvios que NO contengan 'backup' en el nombre y que contengan '2023' en el nombre: not title contains 'backup' and title contains '2023'
#     # Archivos que contengan 'backup' en el nombre y que NO contengan '2023' en el nombre: title contains 'backup' and not title contains '2023'
#     # Archivos en el basurero: trashed = true

#     lista_archivos = credenciales.ListFile({'q': query}).GetList()
#     for archivo in lista_archivos:
#         # ID Drive
#         print('ID Drive:', archivo['id'])
#         # Link de visualización embebido
#         print('Link de visualización embebido:', archivo['embedLink'])
#         # Link de descarga
#         print('Link de descarga:', archivo['webContentLink'])
#         # Nombre del archivo
#         print('Nombre del archivo:', archivo['title'])
#         # Tamaño del archivo
#         print('Tamaño del archivo:', archivo['fileSize'])
#         # Tipo de archivo
#         print('Tipo de archivo:', archivo['mimeType'])
#         # Fecha de creación
#         print('Fecha de creación:', archivo['createdDate'])
#         # Fecha de modificación
#         print('Fecha de modificación:', archivo['modifiedDate'])
#         # Fecha de última modificación
#         print('Fecha de última modificación:', archivo['modifiedByMeDate'])
#         # Fecha de última vista
#         print('Fecha de última vista:', archivo['lastViewedByMeDate'])
#         # ID de la carpeta padre
#         print('ID de la carpeta padre:', archivo['parents'][0]['id'])
#         # Esta en la papelera
#         print('Esta en la papelera:', archivo['labels']['trashed'])
#         # Versión del archivo
#         print('Versión del archivo:', archivo['version'])
#         resultado.append(archivo)
#     return resultado


# Ejemplo de uso
# if __name__ == '__main__':
    # crear_archivo_texto('Prueba','Hola perro', '1cxk59Z4jhJLzWJe5Zi77yYc092LFiW5P')
    # subir_archivo('/home/buzort/.home-backup/backup-2023-02-18-12-05-08-buzort.tar.gz' , '1cxk59Z4jhJLzWJe5Zi77yYc092LFiW5P')
    # descargar_archivo('1svCRrVWlwkmiWeli1kA5gNkoX7RXDfqH', '/home/buzort/University/IoT/')
    # buscar_archivo("title = 'ENCRYPT'") 
