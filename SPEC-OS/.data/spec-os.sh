#!/bin/bash
# This Script show the system specifications
# while cyle for update the system and show the system specifications


function print_Sys(){
    echo -e "\033[1;34m<----SISTEMA--->\033[0m"
    echo -e "\033[1;32mFecha\033[0m":$(date);
    echo -e "\033[1;32mCronJobs activos\033[0m": $Cron;
    echo -e "\033[1;32mUsuario y Host\033[0m": $UserAndHost;
    echo -e "\033[1;32mShell\033[0m": $Shell;
    echo -e "\033[1;32mSistema\033[0m": $SysVersion;
    echo -e "\033[1;32mProcesos\033[0m": $PS;
    echo -e "\033[1;32mKernel\033[0m": $Kernel;
    echo -e "\033[1;32mFecha de Instalación\033[0m": $Date_OS;
    echo -e "\033[1;32mTiempo de Inicio\033[0m": $StartTime;
}

function print_Disk(){
    echo -e "\033[1;34m<----DISCO--->\033[0m"
    echo -e "\033[1;32mPartición\033[0m": $Partition;
    echo -e "\033[1;32mTotal\033[0m": $TotalDisk;
    echo -e "\033[1;32mLibre\033[0m": $FreeDisk;
}

function print_Mem(){
    echo -e "\033[1;34m<----MEMORIA--->\033[0m";
    echo -e "\033[1;32mTotal\033[0m": $TotalRam;
    echo -e "\033[1;32mUsada\033[0m": $UsedRam;
    echo -e "\033[1;32mLibre\033[0m": $MemRam;
}

function print_Network(){
    echo -e "\033[1;34m<----RED--->\033[0m"
    if [ -z "$(iwgetid -r)" ]; then
        echo -e "\033[1;31mNo hay conexión a red\033[0m"
    else
        echo -e "\033[1;32mConectado a\033[0m": $(iwgetid -r);
        echo -e "\033[1;32mIP\033[0m": $Ip;
        echo -e "\033[1;32mMAC\033[0m": $MAC;
        echo -e "\033[1;32mPuerta de Enlace\033[0m": $(ip route | grep default | awk '{print $3}');
        echo -e "\033[1;32mDNS\033[0m": $(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}');
    fi
}

function print_Devtool(){
    echo -e "\033[1;34m<----DEVTOOL--->\033[0m"
    # Check if the program is installed
    if [ -z "$(which git)" ]; then
        echo -e "\033[1;31mGit: No se encuentra instalado git.\033[0m"
    else
        echo -e "\033[1;32mGit\033[0m": $(git --version | awk '{print $3}');
    fi
    if [ -z "$(which java)" ]; then
        echo -e "\033[1;31mJava: No se encuentra instalado Java.\033[0m"
    else
        echo -e "\033[1;32mJava\033[0m": $(java -version 2>&1 | awk 'NR==1{ gsub(/"/,""); print $3 }');
    fi
    if [ -z "$(which python3)" ]; then
        echo -e "\033[1;31mPython: No se encuentra instalado Python.\033[0m"
    else
        echo -e "\033[1;32mPython\033[0m": $(python3 --version | awk '{print $2}');
    fi
    if [ -z "$(which gcc)" ]; then
        echo -e "\033[1;31mGCC: No se encuentra instalado GCC.\033[0m"
    else
        echo -e "\033[1;32mGCC\033[0m": $(gcc --version | awk 'NR==1{print $4}');
    fi
    if [ -z "$(which g++)" ]; then
        echo -e "\033[1;31mG++: No se encuentra instalado G++.\033[0m"
    else
        echo -e "\033[1;32mG++\033[0m": $(g++ --version | awk 'NR==1{print $4}');
    fi
    if [ -z "$(which make)" ]; then
        echo -e "\033[1;31mMake: No se encuentra instalado Make.\033[0m"
    else
        echo -e "\033[1;32mMake\033[0m": $(make --version | awk 'NR==1{print $3}');
    fi
    if [ -z "$(which php)" ]; then
        echo -e "\033[1;31mPHP: No se encuentra instalado PHP.\033[0m"
    else
        echo -e "\033[1;32mPHP\033[0m": $(php -v | awk 'NR==1{print $2}');
    fi
    if [ -z "$(which node)" ]; then
        echo -e "\033[1;31mNode: No se encuentra instalado Node.\033[0m"
    else
        echo -e "\033[1;32mNode\033[0m": $(node -v);
    fi
    if [ -z "$(which mysql)" ]; then
        echo -e "\033[1;31mMySQL: No se encuentra instalado MySQL.\033[0m"
    else
        echo -e "\033[1;32mMySQL\033[0m": $(mysql --version | awk '{print $3}');
    fi
}
function AptLog() {
    echo "Historial de apt:"
    echo "------------------"

    # Busca los registros que contienen "Start-Date:"
    grep -n "Start-Date:" /var/log/apt/history.log | 
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
    done
    # ask to user if he wants copy the output to a file
    read -p "¿Desea copiar el historial a un archivo? (s/n) " yn
    if [ "$yn" = "s" ] || [ "$yn" = "S" ]; then
        USER=$(whoami)
        echo "Copiando historial a un archivo..."
        mkdir -p /home/$USER/SpecOs/ 2>&1
        echo "Historial de apt:" > /home/$USER/SpecOs/AptLog.txt
        echo "------------------" >> /home/$USER/SpecOs/AptLog.txt
        grep -n "Start-Date:" /var/log/apt/history.log | 
        while read -r line
        do
            linenum=$(echo "$line" | cut -d: -f1)
            startdate=$(echo "$line" | cut -d: -f2-)
            reqby=$(tail -n +$linenum /var/log/apt/history.log | head -n 5 | grep -m 1 "Requested-By:" | cut -d: -f2-)
            com=$(tail -n +$linenum /var/log/apt/history.log | head -n 5 | grep -m 1 "Commandline:" | cut -d: -f2-)
            if [ -n "$startdate" ] && [ -n "$reqby" ] && [ -n "$com" ]
            then
                echo "Registro:" >> /home/$USER/SpecOs/AptLog.txt
                echo "  Fecha: $startdate" >> /home/$USER/SpecOs/AptLog.txt
                echo "  Solicitado por: $reqby" >> /home/$USER/SpecOs/AptLog.txt
                echo "  Comando ejecutado: $com" >> /home/$USER/SpecOs/AptLog.txt
                echo "--------------------------------------------------------" >> /home/$USER/SpecOs/AptLog.txt
            fi
        done
        echo "Archivo creado en /home/$USER/SpecOs/AptLog.txt"
    fi
}

while true; do
    echo "1. Actualizar Repositorios"
    echo "2. Registro ultimas instalaciones"
    echo "3. Continuar"
    echo "4. Salir"
    read -p "Seleccione una opción: " option

    case $option in
        1)
            # Whiptail progress bar
            sudo apt update -y > /tmp/aptupdate.log 2>&1
            pasos=$(cat /tmp/aptupdate.log | sed '1,3d' | head -n -5 | wc -l)
            x=0
            while read i; do
                x=$((x+1))
                p=$((x*100/pasos))
                echo "XXX"
                echo "$p"
                echo "Actualizando repositorios... ${x}/${pasos}"
                echo "XXX"
                sleep 0.2
            done < /tmp/aptupdate.log | whiptail --gauge "Espere mientras se
            actualizan los repositorios..." 6 60 0 --title "Actualizando repositorios"
            whiptail --title "Actualización de repositorios" --msgbox "Repositorios actualizados correctamente" 8 78
            read -p "Desea ver las instalaciones disponibles: (s/n) " yn2
            if [ "$yn2" = "s" ] || [ "$yn2" = "S" ]; then
                sudo apt upgrade;
            fi
            break
            ;;
        2)
            AptLog
            ;;

        3)
            break
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Opción no válida. Seleccione 1 o 2."
            ;;
    esac
done

# while true; do
#     read -p "¿Desea revisar actualizaciones? (s/n) " yn
#     case $yn in
#         [SsyY]* ) sudo apt update && sudo apt upgrade; 
#                 read -p "Se han encontrado actualizaciones. ¿Desea realizarlas? (s/n) " yn2
#                 if [ "$yn2" = "y"]; then
#                     sudo apt upgrade -y; sudo apt autoremove -y; sudo apt autoclean -y;
#                 fi
#                 break;;
#         [Nn]* ) break;;
#         * ) echo "Por favor responda sí o no.";;
#     esac
# done

echo "
▒█▀▀▀█ █▀▀█ █▀▀ █▀▀ ░░ ▒█▀▀▀█ █▀▀ 
░▀▀▀▄▄ █░░█ █▀▀ █░░ ▀▀ ▒█░░▒█ ▀▀█ 
▒█▄▄▄█ █▀▀▀ ▀▀▀ ▀▀▀ ░░ ▒█▄▄▄█ ▀▀▀
"
echo "---------------------------------"

# Variables


SysVersion=$(cat /usr/lib/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//' | cut -d'"' -f2)
GraphicCard=$(lspci | grep VGA | tr -d [ | tr -d ] | awk '{print $11 $12 $13}' | sed 's/Radeon/Radeon-/' | sed 's/R2/R2-/')
Partition=$(df -h | awk 'NR==3 {print $6}')
FreeDisk=$(df -h | awk 'NR==3 {print $4}')
TotalDisk=$(lsblk | grep -m1 sda | awk '{print $4}')
MemRam=$(free -h | awk 'NR==2 {print $7}' | sed 's/i/B/')
TotalRam=$(free -h | awk 'NR==2 {print $2}' | sed 's/i/B/')
UsedRam=$(free -h | awk 'NR==2{print $3}' | sed 's/i/B/')
UserAndHost=$(whoami)@$(hostname)
StartTime=$(uptime --pretty | sed 's/up//')
Ip=$(hostname -I)
MAC=$(cat /sys/class/net/$(ip route | grep default | awk '{print $5}')/address)
Shell=$(echo $SHELL | sed 's/zsh/ zsh/' | awk '{print $NF}')
Kernel=$(uname -r)
Date_OS=$(cat /var/log/installer/syslog | grep "finished"| tail -1 | awk '{print $1,$2,$3}')
CPU=$(lscpu | grep "Model name" | sed 's/Model name: //' | sed 's/^ *//' | awk '{print $1,$2,$3}'
)
PS=$(ps -A | wc -l)
Cron=$(crontab -l | wc -l)



print_Sys;
print_Disk;
print_Mem;
print_Network;
print_Devtool;

