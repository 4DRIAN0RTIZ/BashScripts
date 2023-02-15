#!/bin/bash



if [ -z "$1" ]; then
		echo "Forma de uso: $0 <archivo>"
		exit 1
fi
mkdir -p "$1"

cp "/home/buzort/University/BashScripts/job.sh" "$1/$1.sh"
echo "Archivo $1.sh creado"
echo "No olvides crear el archivo README.md"


