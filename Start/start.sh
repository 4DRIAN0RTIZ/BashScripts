#!/bin/bash

# Escribe recibe un programa como parametro y lo ejecuta en segundo plano

# Si el programa no existe, muestra ayuda

if [ -z $1 ]; then
	echo "Uso: $0 programa"
	exit 1
fi

path=$(which $1) # Busca el programa en el path
if [ -n $path ]; then
	$1 > /dev/null 2>&1 & # Ejecuta el programa en segundo plano
	disown # Desvincula el proceso del shell
	clear # Limpia la pantalla
else
	echo "No se encuentra el programa $1"
fi



