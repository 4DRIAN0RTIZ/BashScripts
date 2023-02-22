#!/bin/bash
echo -e "\a"
# Verificación de dependencias

declare -A dependencies=(
  ["wget"]="sudo apt install wget -y"
  ["tar"]="sudo apt install tar -y"
  ["python3"]="sudo apt install python-is-python3 -y"
)
for dependency in "${!dependencies[@]}"; do
  if ! command -v "$dependency" &> /dev/null; then
    echo "El comando '$dependency' no está instalado"
    echo "Instalando '$dependency'..."
    eval "${dependencies[$dependency]}"
    if [ $? -ne 0 ]; then
      echo "Error al instalar '$dependency'"
      exit 1
    fi
  else
    echo "$dependency ya está instalado"
  fi
done

# Verificación de archivos en el directorio

declare -A files_to_download=(
  ["settings.yaml"]="https://gist.githubusercontent.com/4DRIAN0RTIZ/45c6273ebe20efeaf02c53ec156fd417/raw/63209dc6b5ac5cb2f870bfddcc0d6412bccded21/settings.yaml"
  ["gdrive.py"]="https://gist.githubusercontent.com/4DRIAN0RTIZ/5da96f80dd35f81d596b0f95517ed838/raw/bb106e6e7efa3a5733245bbcb9a033783147f7ca/gdrive.py"
  ["HomeBack.py"]="https://gist.githubusercontent.com/4DRIAN0RTIZ/e880ec9ac49b73531514d5861a302be9/raw/d440b9175f5a9ac24023d8eee8c39817279b3f36/HomeBack.py"
)

for file in "${!files_to_download[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Archivo $file no encontrado"
    echo "Descargando $file..."
    wget "${files_to_download[$file]}"
    if [ $? -ne 0 ]; then
      echo "Error al descargar $file"
      exit 1
    fi
  else
    echo "$file ya está descargado"
  fi
done

# Ruta de  del archivo de backup
backup_dir="$HOME/.backup"

# Carpetas a excluir en la copia de seguridad
excluded_folders=(
    # "$HOME/.cache"
    # "$HOME/.bin"
    # "$HOME/snap"
    # "$HOME/.mozilla"
    # "$HOME/.backup"
    # "$HOME/.local"
)

# Crear directorio de backup si no existe
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi

echo "Eliminando archivos de backup antiguos"
# Eliminar archivos de backup antiguos
find "$backup_dir" -type f -delete
echo "Fin de eliminación de archivos de backup antiguos"

# Nombre del archivo de backup
backup_file="backup_home_$(date +%Y%m%d_%H%M%S).tar.gz"

# Crear archivo de backup y comprimirlo en el directorio de destino
tar_cmd="tar -czf $backup_dir/$backup_file $HOME/University/IoT"


for folder in "${excluded_folders[@]}"; do
    tar_cmd+=" --exclude=$folder"
done


 eval "$tar_cmd"

 echo "Backup completado: $backup_dir/$backup_file"

  echo "Abriendo Script de Python"
  python3 HomeBack.py $backup_file
