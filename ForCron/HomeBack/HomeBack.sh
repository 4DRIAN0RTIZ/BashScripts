#!/bin/bash

# Ruta de  del archivo de backup
backup_dir="$HOME/.backup"

# Carpetas a excluir en la copia de seguridad
excluded_folders=(
    "$HOME/.cache"
    "$HOME/.bin"
    "$HOME/snap"
    "$HOME/.mozilla"
    "$HOME/.backup"
    "$HOME/.local"
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
tar_cmd="tar -czf $backup_dir/$backup_file $HOME"

echo "Creando backup: $backup_dir/$backup_file"

for folder in "${excluded_folders[@]}"; do
    tar_cmd+=" --exclude=$folder"
done

eval "$tar_cmd"

echo "Backup completado: $backup_dir/$backup_file"

# Ejecutar Script de Python pasado como argumento el nombre del archivo de backup

python3 HomeBack.py $backup_file

