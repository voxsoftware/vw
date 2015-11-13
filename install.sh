#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_DIR='/bin'
if [ ! "$1" == "" ];
then
    INSTALL_DIR="$1"    
fi


if [ ! -d "$INSTALL_DIR" ];
then
    sudo mkdir "$INSTALL_DIR"
fi



### Instalar jxcore ...
curl http://jxcore.com/xil.sh | sudo bash


### Crear las carpetas si es necesario ...
if [ ! -d "$INSTALL_DIR/vwdata" ];
then
    sudo mkdir "$INSTALL_DIR/vwdata"
fi

if [ ! -d "$INSTALL_DIR/vwdata/node_modules" ];
then
    sudo mkdir "$INSTALL_DIR/vwdata/node_modules"
fi 


## Copiando los binarios ...
sudo cp ./vw "$INSTALL_DIR/vw"

sudo cp /usr/local/bin/jx "$INSTALL_DIR/vwdata/jx"
# Esto es para copiar el exe jx al directorio establecido ...
#sudo jx "$DIR/install.js" "$INSTALL_DIR"

JX= "$INSTALL_DIR/vwdata/jx"
cd "$INSTALL_DIR/vwdata"
sudo "$JX" install vw-server # instala vw-server 
sudo "$JX" install vw ## Instala el módulo VW con sus dependencias ...
sudo "$JX" install nw ## Instala el módulo NW con sus dependencias ...
sudo "$JX" install mime-types
sudo "$JX" install app-module-path

## Hasta acá ya está listo para usar ...