#!/bin/bash
# Verifica si las dependencias estan instaladas y las instala si no lo estan

if ! [ -x "$(command -v python3)" ]; then
  echo 'Python3 no esta instalado. Instalando...'
  sudo apt install python-is-python3
fi

excluidos=("/home/$(whoami)/.home-backup" "/home/$(whoami)/.cache" "/home/$(whoami)/.local/share/Trash" "/home/$(whoami)/.local/share/Trash/files" "/home/$(whoami)/.local/share/Trash/info" "/home/$(whoami)/.local/share/Trash/expunged" "/home/$(whoami)/snap/")
origen="/home/$(whoami)/University/BashScripts"
destino="$HOME/.home-backup/"
fecha_actual=$(date "+%Y-%m-%d-%H-%M-%S")
nombre_archivo="backup-${fecha_actual}-$(whoami).tar.gz"

# Crea el directorio de destino si no existe

if [ ! -d "${destino}" ] 
then
    mkdir -p "${destino}"
fi

rm -rf "${destino}"*

# Itera sobre los archivos y directorios del origen y los copia al destino
contador=0

for archivo in ${origen}/*
do
    if [ -d "${archivo}" ] && [[ " ${excluidos[@]} " =~ " $(basename "${archivo}") " ]] 
    then
      echo "Excluyendo: $(basename "${archivo}")"
    else
      echo "Copiando: $(basename "${archivo}")"
      cp -r "${archivo}" "${destino}"
    fi
  contador=$((contador+1))
  p=$((contador*100/$(ls -1 ${origen} | wc -l)))
  bar=$(printf "%${p}s" | tr ' ' '#')

  echo "XXX"
  echo "${p}"
  echo "Progreso: ${bar}"
  echo "XXX"
done | whiptail --gauge "Copiando archivos..." 6 60 0 --title "Copia en progreso"

# Se comprime el directorio de destino en un archivo .tar.gz

tar -czf "$HOME/.home-backup/${nombre_archivo}" ${destino} 1>/dev/null 2>&1

# Se ejecuta el script de python para enviar el archivo a google drive

python3 HomeBack.py "${nombre_archivo}"

