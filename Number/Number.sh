#!/bin/bash

read -p "Ingresa un número: " num
div=$((num%2))
if [ $div -eq 0 ]; then
		echo "El número es par"
else
		echo "El número es impar"
fi 
