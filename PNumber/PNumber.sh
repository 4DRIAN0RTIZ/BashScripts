#!/bin/bash

read -p "Ingrese el numero: " num
if [ $num -gt 0 ]
then
echo "El numero es positivo"
elif [ $num -lt 0 ]
then
echo "El numero es negativo"
else
echo "El numero es cero"
fi

