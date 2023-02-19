#!/bin/bash
# Verifica si las dependencias estan instaladas y las instala si no lo estan

if ! [ -x "$(command -v python3)" ]; then
  echo 'Python3 no esta instalado. Instalando...'
  sudo apt install python-is-python3
fi

if ! [ -f "HomeBack.py" ]; then
  echo 'No se encuentra el script de python. Descargando...'
  wget https://gist.githubusercontent.com/4DRIAN0RTIZ/e880ec9ac49b73531514d5861a302be9/raw/d440b9175f5a9ac24023d8eee8c39817279b3f36/HomeBack.py
  wget https://gist.githubusercontent.com/4DRIAN0RTIZ/45c6273ebe20efeaf02c53ec156fd417/raw/63209dc6b5ac5cb2f870bfddcc0d6412bccded21/settings.yaml
  wget https://gist.githubusercontent.com/4DRIAN0RTIZ/5da96f80dd35f81d596b0f95517ed838/raw/bb106e6e7efa3a5733245bbcb9a033783147f7ca/gdrive.py
  echo 'Descarga completa'
fi

excluidos=("/home/$(whoami)/.home-backup" "/home/$(whoami)/.cache" "/home/$(whoami)/.local/share/Trash" "/home/$(whoami)/.local/share/Trash/files" "/home/$(whoami)/.local/share/Trash/info" "/home/$(whoami)/.local/share/Trash/expunged" "/home/$(whoami)/snap/")
origen="$HOME/University/IoT"
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
( for archivo in ${origen}/*
do
    if [ -d "${archivo}" ] && [[ " ${excluidos[@]} " =~ " $(basename "${archivo}") " ]] 
    then
      echo "Excluyendo: $(basename "${archivo}")"
    else
      echo "Copiando: $(basename "${archivo}")"
      cp -r "${archivo}" "${destino}"
    fi
  contador=$((contador+1))
  p=$((contador*100/$(ls -1 ${origen}/* | wc -l)))
  bar=$(printf "%${p}s" | tr ' ' '#')
  echo "XXX"
  echo "${p}"
  echo "Progreso: ${bar}"
  echo "XXX"
  sleep 0.3
done) |  whiptail --backtitle "\033[41mCopiando archivos...\033[0m" --gauge "Copiando archivos..." 6 60 0 --title "Copia en progreso"

# Se comprime el directorio de destino en un archivo .tar.gz

echo "Comprimiendo..."
tar -czf "$HOME/.home-backup/${nombre_archivo}" ${destino} 1>/dev/null 2>&1


# Se ejecuta el script de python para enviar el archivo a google drive

echo "Ejecutando script de python..."
python3 HomeBack.py "${nombre_archivo}"

