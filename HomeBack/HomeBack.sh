#!/bin/bash

# Script para hacer backup de la carpeta Home y subirla a Google Drive
# Autor: Adrián Ortiz

# Trap para controlar la señal de interrupción

trap ctrl_c INT
function ctrl_c() {
  echo ""
  echo "Saliendo..."
  echo ""
  exit 1
}

# Verificación de dependencias

declare -A dependencias=(
  ["wget"]="sudo apt install wget -y"
  ["tar"]="sudo apt install tar -y"
  ["python3"]="sudo apt install python-is-python3 -y"
)
for dependencia in "${!dependencias[@]}"; do
  if ! command -v "$dependencia" &> /dev/null; then
    echo "El comando '$dependencia' no está instalado"
    echo "Instalando '$dependencia'..."
    eval "${dependencias[$dependencia]}"
    if [ $? -ne 0 ]; then
      echo "Error al instalar '$dependencia'"
      exit 1
    fi
  fi
done

# Verificación de archivos en el directorio

declare -A archivos_a_descargar=(
  ["settings.yaml"]="https://gist.githubusercontent.com/4DRIAN0RTIZ/45c6273ebe20efeaf02c53ec156fd417/raw/63209dc6b5ac5cb2f870bfddcc0d6412bccded21/settings.yaml"
  ["gdrive.py"]="https://gist.githubusercontent.com/4DRIAN0RTIZ/5da96f80dd35f81d596b0f95517ed838/raw/bb106e6e7efa3a5733245bbcb9a033783147f7ca/gdrive.py"
  ["HomeBack.py"]="https://gist.githubusercontent.com/4DRIAN0RTIZ/e880ec9ac49b73531514d5861a302be9/raw/d440b9175f5a9ac24023d8eee8c39817279b3f36/HomeBack.py"
)

for archivo in "${!archivos_a_descargar[@]}"; do
  if [ ! -f "$archivo" ]; then
    echo "Archivo $archivo no encontrado"
    echo "Descargando $archivo..."
    wget "${archivos_a_descargar[$archivo]}"
    if [ $? -ne 0 ]; then
      echo "Error al descargar $archivo"
      exit 1
    fi
  fi
done

# Ruta de  del archivo de backup
backup_dir="$HOME/.backup"

# Carpetas a excluir en la copia de seguridad
declare -A carpetas_excluidas=(
    ["$HOME/.cache"]='',
    ["$HOME/.bin"]='',
    ["$HOME/snap"]='',
    ["$HOME/.mozilla"]='',
    ["$HOME/.backup"]='',
    ["$HOME/.local"]='',
)

# Crear directorio de backup si no existe
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi


# Eliminar archivos de backup antiguos
# Se puede cambiar el número de días a conservar
#find "$backup_dir" -type f -mtime +7 -delete
find "$backup_dir" -type f -delete

# Nombre del archivo de backup
backup_archivo="backup_home_$(date +%Y%m%d_%H%M%S).tar.gz"

# Crear archivo de backup y comprimirlo en el directorio de destino, el segundo parámetro es la ruta de la carpeta a comprimir.
tar_cmd="tar -czf $backup_dir/$backup_archivo $HOME/Downloads 2> /dev/null"


for carpeta in "${carpetas_excluidas[@]}"; do
    tar_cmd+=" --exclude=$carpeta"
done


 echo "Creando backup..."
 eval "$tar_cmd"

 echo "Backup completado: $backup_dir/$backup_archivo"
 sleep 2

echo "Abriendo Script de Python"
sleep 2
python3 HomeBack.py $backup_archivo
