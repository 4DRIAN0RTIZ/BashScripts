#!/bin/bash
    echo "Historial de apt:"
    echo "------------------"

    # Busca los registros que contienen "Start-Date:"
    output=$(grep -n "Start-Date:" /var/log/apt/history.log | 
    while read -r line
    do
        # Obtiene el número de línea y el texto de la línea que contiene "Start-Date:"
        linenum=$(echo "$line" | cut -d: -f1)
        startdate=$(echo "$line" | cut -d: -f2-)

        # Busca la línea que contiene "Requested-By:" dentro de las siguientes 5 líneas
        reqby=$(tail -n +$linenum /var/log/apt/history.log | head -n 5 | grep -m 1 "Requested-By:" | cut -d: -f2-)

        # Busca la línea que contiene "Commandline:" dentro de las siguientes 5 líneas
        com=$(tail -n +$linenum /var/log/apt/history.log | head -n 5 | grep -m 1 "Commandline:" | cut -d: -f2-)

        # Si se encontraron los tres campos, imprime el registro
        if [ -n "$startdate" ] && [ -n "$reqby" ] && [ -n "$com" ]
        then
            echo "Registro:"
            echo "  Fecha: $startdate"
            echo "  Solicitado por: $reqby"
            echo "  Comando ejecutado: $com"
            echo "--------------------------------------------------------"
        fi
    done)
    echo "$output"



