#!/usr/bin/env python3
import pymongo
from pydrive2.auth import GoogleAuth
import gdrive as gd
# importar nuestro otro archivo para usar sus funciones

gauth = GoogleAuth()
gauth.LocalWebserverAuth()




gd.subir_archivo('/home/buzort/.home-backup/job.py','1cxk59Z4jhJLzWJe5Zi77yYc092LFiW5P')



