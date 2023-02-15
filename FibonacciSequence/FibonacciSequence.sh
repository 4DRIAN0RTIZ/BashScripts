#!/bin/bash

# This program require a number to user input and print the fibonacci sequence

# Get the number from user

read -p "Introduce un numero: " num

# Declare the first two numbers
a=$(($num))
b=1

# Print the first two numbers
echo "Secuencia de Fibonacci: "
echo $a
echo $b

# Print the fibonacci sequence
for (( i=0; i<num; i++ ))
do
		c=$((a+b))
		echo $c
		a=$b
		b=$c
done

