#!/bin/bash

# This script evaluate if a fle exists in the current directory
if [ $# -eq 0 ]; then
	echo "No se ha introducido ningun argumento"
	echo "Saliendo..."
	exit 1
fi
if [ -f $1 ];
then
		echo "El archivo $1 existe"
		echo "- - - - - "
		read -p "Quiere intentar abrirlo? (y/n)" answer

		if [ $answer == "y" ];
		then echo "Abriendo archivo..."
			cat $1
		else
			echo "Algo salio mal al abrir el archivo"
			echo "Saliendo..."
			exit 1
		fi
else
		echo "Parece que el archivo $1 no existe"
		echo "- - - - - "
		read -p "Quiere crearlo? (y/n)" answer
		if [ $answer == "y" ]; then
			touch $1
			echo "Archivo $1 creado"
		else
			echo "Archivo $1 no creado"
			echo "Saliendo..."
		fi
fi

