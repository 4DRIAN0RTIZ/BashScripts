# Homeback

<span style="font-family:Sans-serif;">

_HomeBackup realiza una tarea bastante sencilla pero que una vez que la automatizas, se vuelve mucho, pero mucho mejor._

## Contenido

1. [Descripción](#descripción)
2. [Dependencias](#dependencias)
3. [Uso](#uso)
4. [Cron](#cron)

## Descripción

Es una herramienta de cli fue desarrollada debido a mi necesidad de tener copias de seguridad de mis archivos, en especial los archivos de configuración; ya que permite hacer una copia de seguridad en la carpeta
principal de usuario en su propio sistema.

El proceso se lleva a cabo copiando la carpeta $HOME del usuario localmente, para después comprimir los archivos y subirlos directamente a una carpeta en Google Drive.

El script también cuenta con una función de exclusión de archivos, lo que significa que se pueden ignorar ciertos directorios, lo que viene bastante útil para evitar archivos pesados o directorios sin importancia. Resumiendo, el script es una manera rápida y sencilla de respaldar tus archivos.

> Este script está diseñado para ser ejecutado de manera automática mediante el uso de cron.

## Dependencias

<details><summary>Python</summary>

Es un lenguaje de progrmación interpretado y de alto nivel. Es muy popular por su sintaxis clara y legible, lo que lo hace facil de aprender y usar

</details>

<details><summary>Tar</summary>

Esta es una herramienta que se utiliza para crear y manipular archivos comprimidos. Con tar se pueden comprimir múltiples archivos
y directorios en un solo archivo lo que facilita el transporte y la copia de archivos. Un ejemplo de uso sería:

Crear un archivo comprimido con tar

```bash
tar -czf archivo_comprimido.tar.gz archivo1 archivo2 directorio1
```

Descomprimir archivo con tar

```bash
tar -xzf archivo_comprimido.tar.gz
```

</details>

<details><summary>Wget</summary>

Es una heeramienta que permite descargar archivos y recursos desde la web. "wget" es mut útil para descargar archivos grandes o para múltiples archivos a la vez. Ejemplo:

Descargar un archivo desde la web con wget:

```
wget https://www.ejemplo.com/archivo.txt
```

Descargar varios archivos con wget

```
wget -i lista_de_archivos.txt
```

</details>

<details><summary>Whiptail</summary>

Es una herramienta que permite crear interfaces de usuario en la terminal de manera interactiva. Con Whiptail se pueden crear cuadros de diálogo, menús y formularios para que el usuario pueda interactuar con el programa, o al menos ver lo que está haciendo de manera más gráfica. Ejemplo:

Crear menú de opciones con Whiptail

```bash
whiptail --title "Menú de opciones" --menu "Seleccione una opción:" 15 60 4 \
"1" "Opción 1" \
"2" "Opción 2" \
"3" "Opción 3" \
"4" "Opción 4" \
3>&1 1>&2 2>&3
```

Crear un cuadro de diálogo con whiptail

```bash
whiptail --title "Mensaje de advertencia" --msgbox "¡Cuidado! Esta acción es irreversible." 10 50
```

</details>

<details><summary>Awk</summary>

Es una herramienta que se utiliza para procesar y manipular datos en formato de texto plano. Awk es muy útil para extraer información de archivos de texto. Ejemplo:

Imprimir el contenido de una columna de un archivo de texto con Awk

```bash
awk '{print $1}' archivo.txt
```

Calcular la suma de los valores de una columna de un archivo de texto con awk

```bash
awk '{sum += $1} END {print sum}' archivo.txt
```

</details>

<details><summary>Sed</summary>

Sed es una herramienta de procesamiento de texto que se utiliza para buscar y reemplazar texto en archivos de texto. Sed permite realizar operaciones complejas en archivos de texto como buscar y reemplazar texto en funcion de patrones. Ejemplo:

Busca la palabra "antiguo" en un archivo de texto y la reemplaza por la palabra "Nuevo"

```
sed 's/antiguo/Nuevo/' archivo.txt
```

</details>
<br>

**La mayoría ya vienen instaladas por defecto, de igual manera el script se encarga de descargar lo necesario**

## Uso

Clonar el repositorio:

```bash
git clone https://github.com/4DRIAN0RTIZ/BashScripts.git
```

Crear un archivo de variable de entorno en la carpeta raíz del programa.

```bash
touch .env
```

Agregar este formato:

```txt

ID_CARPETA=XXXXXXXXX
CLIENT_ID=XXXXXXXXX
CLIENT_SECRET=XXXXXXXXX


## Sin la de abajo no funciona el script
DIRECTORIO_HOME=/home/usuario
## Sin la de arriba no funciona el script
## Va sin el "/" al final

```

> Se está asumiendo que ya se tiene una cuenta de desarrollador en Google previamente configurada para unicamente agregar las claves de la API.

<details><summary>Como conseguir las credenciales</summary>

1. Ingresa a https://console.cloud.google.com/
2. Dentro de la pagina dirígete a la barra de búsqueda y busca "Google Drive"
3. Seleccionas Google Drive y habilitas la API.
4. Te vas al apartado APIs y servicios > Credenciales
5. Das click en "+ Crear Credenciales" y seleccionas de tipo OAuth
6. En donde pide orígenes autorizados colocar esto:

```bash
http://localhost:8080
```

En URI de redireccionamiento autorizados

```bash
http://localhost:8080/
```

> _En la URI lleva "/" al final._ 7. Descargar archivo Json con nuevos datos. 8. Renombrarlo como "client_secret.json y colocarlo en la carpeta raíz.

</details>

---

Una vez realizado lo anterior se debe modificar las variables origen y destino del fichero "Homebackup.sh". Se puede agregar a cron.

## Cron

Cron es un programa en sistemas operativos Unix y similares que permite programar la ejecución automática de tareas o comandos a intervalos regulares de tiempo. Es una herramienta muy útil para automatizar procesos recurrentes.
Cron utiliza un archivo llamado crontab para definir las tareas a ejecutar y su frecuencia. En este archivo se especifíca el comando que se debe ejecutar, el intervalo de tiempo en que se de ejecutará.

```
*     *     *     *     *     comando a ejecutar
-     -     -     -     -
|     |     |     |     |
|     |     |     |     +----- día de la semana (0 - 6) (Domingo = 0)
|     |     |     +------- mes (1 - 12)
|     |     +--------- día del mes (1 - 31)
|     +----------- hora (0 - 23)
+------------- minuto (0 - 59)
```

Para agregarlo primero le damos los permisos necesarios a los archivos

```bash
chmod a+x Homebackup,sh HomeBackup.py gdrive.py
```

Después abrimos el archivo de cron

```bash
crontab -e
```

Para que se ejecute los domingos a las 03:am quedaría así:

```bash
0 3 * * 0  /aqui/va/la/ruta/al/archivo/Homeback.sh
```

---

#### Pendientes

- [ ] Descargar archivo .env de manera automática
- [ ] Agregar script de manera automática en cron

---

| Fecha              | Versión |
| ------------------ | ------- |
| 20 Febrero de 2023 | v1.0    |

</span>
