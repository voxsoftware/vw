Bienvenido a vw (voxwebkit) !
===================


VW (voxwebkit) es un proyecto para crear aplicaciones multiplataforma con el mismo código fuente. Utiliza herramientas libres modernas.

Plataformas 

 - Windows 
 - Linux (Opensuse, Debian, Redhat, Ubuntu, others)
 - Android 4.0 o superior

VW utiliza los siguientes proyectos libres:

 - nw.js http://nwjs.io/
 - jxcore http://jxcore.com/home/
 - crosswallk (sobre Android e iOs)  https://crosswalk-project.org/
 - cordova (sobre Android e iOs) https://cordova.apache.org/
 - nodejs-vw  https://github.com/voxsoftware/nodejs-vw
 - vox-server https://github.com/voxsoftware/vox-server

----------


Instalación
-------------
Clone el repositorio y a continuación instale ejecutando el archivo install.sh en linux, o install.bat en Windows. Es necesario el programa git


#### Linux: 
```shell
git clone https://github.com/voxsoftware/vw
cd vw
sudo ./install.sh
```

#### Windows:
Si está sobre Windows 7 u 8 asegurese de ejecutar el cmd como administrador

```shell
git clone https://github.com/voxsoftware/vw
cd vw
install.bat
```
----------

Uso 
-------------------

VW funciona en modo servidor, cliente. VW utiliza internamente JxCore, un fork de nodejs que puede utilizarse desde plataforma móviles, lo que significa que vw puede utilizar la mayoría de módulos de nodejs.

En VW primero se crea un servidor web en un puerto aleatorio, e inicia nw.js para la interfaz gráfica. Es cierto que nw.js ya cuenta con io.js integrado un fork también de nodejs, pero este fork solo funciona en plataformas de escritorio. Eso no concuerda con el objetivo de VW que es un solo código fuente tanto para aplicaciones móviles como de escritorio. Por ese motivo nw.js se usa específicamente para la interfaz gráfica. 


Para programar en VW se pueden utilizar dos lenguajes que vienen listos para usar 

 - JavaScript
 - CoffeeScript
 
 VW, puede automáticamente cargar módulos escritos en CoffeeScript y JavaScript desde cualquiera de los dós lenguajes.
Desde CoffeeScript se pueden cargar módulos escritos en JavaScript, y desde JavaScript se pueden cargar módulos escritos en CoffeeScript

 
 En JavaScript:
 
```javascript
require("modulo-coffee");
```

En CoffeeScript
```coffeescript
require "modulo-javascript"
```


#### El punto de partida de una aplicación

El punto de partida de VW puede ser una carpeta que contenga un módulo NodeJS creado para iniciar VW escrito en CoffeeScript o JavaScript. 

#### Archivo inicial 

En CoffeeScript
```coffeescript
vwserver= require "vox-server"
app= new vwserver
	path: __dirname, ## Directorio de la aplicacion
	theme: "default", ## Directorio donde se encuentran los archivos HTML, JS, CSS3 de la interfaz de usuario
	workercount: 0   ## Número de subprocesos 


app.prepareHttpServer ( -> 
	# Acá va la definición de rutas del servidor creado

	# vox-server utiliza express-app y puede obtener el objeto router así:
	router= app.getRouter()
	
	# Definir las rutas
	# La interfaz gráfica utiliza como ruta inicial: /index
	router.all '/index', (req, res, next) ->
		res.writeHead 200, 'Content-type': 'text/html'
		res.write "Hola mundo"
		res.end()
		return
)

# Parámetros de la ventana (opcional)
app.windowParameters=
	width:640,
	height:480,
	toolbar:false

# Iniciar la interfaz gráfica
app.start()

# O bien puede iniciar la aplicación en un puerto específico.
# app.start 7000
```

#### Archivos HTML (interfaz de usuario)
Los archivos deben ir en la carpeta que se haya definido en las opciones que se dan al crear el servidor (options.theme). 
Esa carpeta debe tener dos subcarpetas

 - assets (todos los archivos de estilos, scripts, imágenes, etc)
 - views (los archivos VISTAS. Son archivos HTML, y código fuente juntos)

#### Vistas 
Son archivos híbridos de código HTML, y código fuente de servidor. Podría asimilarse de cierta manera a los archivos PHP que tienen porciones de código y porciones HTML, y estas vistas son muy similares en el uso.

 - Dentro de cada vista existen las siguientes variables locales: **vox**, **req**, **res**, **pars**.
 **vox** es una referencia a un objeto que tiene ciertas utilidades como mostrar secciones que se verá más adelante
 **req** es una referencia al objeto request
 **res** es una referencia al objeto response
 **pars** son parámetros que se pueden enviar a la vista
 
 - Las porciones de código se encierran dentro de las etiquetas "&lt;?" y "?&gt;". El código puede estar en JavaScript o CoffeeScript
 
 - Se puede encerrar variables o expresiones dentro de etiquetas "{{" y ""}}. Colocar **{{expression}}** es similar al siguiente código CoffeeScript **&lt;? res.write expression ?&gt;**
 
 - Se pueden crear secciones que se pueden utilizar más adelante. Considere el siguiente ejemplo: 

``` CoffeeScript

<?section:mysection:
Hello world! Solicitud procesada por el proceso: {{process.pid}}
:end?>

<!DOCTYPE html>
<html>
	<head>
		<title>App name</title>
	</head>
	<body>
		{{vox.section "mysection"}}
	</body>
</html>
``` 

Ahora se muestra como usar las vistas dentro del código fuente del servidor  que creamos al inicio:

``` CoffeeScript
 # Puede reemplazar el código de creación del servidor mostrado al inicio 
 # Suponiendo que tiene un archivo /default/views/inicio.vox.coffee con un código similar al anterior mostrado en vistas

router.all 'index' (req, res, next) ->
	app.theme.section 'inicio', req, next
	return
 
```

Al iniciar la aplicación mostrará algo así:
``` 
Hello world! Solicitud procesada por el proceso: 3456
``` 

### Table of contents

You can insert a table of contents using the marker `[TOC]`:

[TOC]

