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

#sudo cp /usr/bin/jx /"$INSTALL_DIR/vwdata/jx"
# Esto es para copiar el exe jx al directorio establecido ...
sudo jx "$DIR/install.js" "$INSTALL_DIR"


cd "$INSTALL_DIR/vwdata"
sudo jx install vw-server # instala vw-server 
sudo jx install vw ## Instala el módulo VW con sus dependencias ...
sudo jx install nw ## Instala el módulo NW con sus dependencias ...
sudo jx install mime-types
sudo jx install app-module-path

## Hasta acá ya está listo para usar ...