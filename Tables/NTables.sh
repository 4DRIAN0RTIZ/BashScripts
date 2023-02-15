#!/bin/bash


tables=(1 2 3 4 5 6 7 8 9 10)
read -p "Escribe un numero: " num


for i in "${tables[@]}"
do
	echo "$num x $i = $(($num*$i))"
done



