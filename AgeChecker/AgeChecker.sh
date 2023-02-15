#!/bin/bash

read -p "Ingrese su edad:" edad # Se pide la edad

if [ $edad -ge 18 ]; then # Se evalua la edad
	echo "Usted es mayor de edad"
else
	echo "Usted es menor de edad"
fi

