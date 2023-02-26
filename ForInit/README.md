# ForInit

## Contenido

1. [Descripción](#descripcion)
2. [Modo de uso](#mododeuso)
3. [FAQ](#faq)

### Descripción

Este script de bash contiene una serie de funciones para instalar una serie de dependencias y herramientas útiles en un sistema Ubuntu. Estas son las funciones que incluye:

- install_dependencies: Instala una serie de dependencias del sistema que se definen en un array.
- install_oh_my_zsh: Instala el Framework de shell Oh-My-Zsh.
- install_node: Instala Node.js utilizando el repositorio oficial de NodeSource.
- install_vimplug: Instala el plugin manager Vim-Plug para Neovim.
- install_nvim: Instala Neovim (0.7) utilizando el repositorio PPA Stable.
- install_fzf: Instala la herramienta FZF para búsquedas rápidas y filtrado de archivos en la terminal.
- install_fastsyntaxhighlighting: Instala el plugin de resaltado de sintaxis rápido para ZSH.
- install_autosuggestions: Instala el plugin de sugerencias automáticas para ZSH.
- install_caskaydia_font: Descarga e instala la fuente de Nerd Font: Caskaydia.
- install_zshrc: Descarga y sobreescribe el archivo de configuración .zshrc para el Framework de shell Oh-My-ZSH
- install_powerlevel10k: Instala el tema de terminal Powerlevel10k para Oh-My-ZSH.

Cada función comprueba si la herramienta correspondiente ya está instalada antes de proceder a su instalación. Si la herramienta ya está instalada, se omite y se muestra un mensaje correspondiente. En caso contrario, se procede a su instalación y se muestra un mensaje de confirmación.

### Modo de uso

El modo de uso es de lo más simple:

Primero le damos los permisos necesarios para que se pueda ejecutar el script.

```bash
sudo chmod a+x Init.sh
```

Una vez que descargues el archivo ejecutable en tu ordenador, simplemente ejecutalo como aparece arriba para abrirlo. El programa se abrirá y podrás empezar a usarlo de inmediato. No es necesario instalar nada ni realizar ninguna configuración adicional, todo lo que necesitas está incluido en el archivo ejecutable.

Una vez que el programa esté en funcionamiento, podrás utilizar todas sus funciones. Verás que es muy intuitiva y fácil de usar, por lo que no tendrás ningún problema para empezar a trabajar con él y agregar o quitar cositas que no quieras.

En resumen, el modo de uso del programa es muy simple: solo tienes que ejecutar el archivo, y ya estarás listo para empezar a utilizarlo.

```bash
./Init.sh
```

### FAQ

#### ¿Es necesario contar con conexión a internet para ejecutar el script?

##### Para ejecutarlo como tal, no, pero para descargar las herramientas si es necesario.
