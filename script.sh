#!/bin/bash

# Check root
if [[ $EUID -ne 0 ]]; then
    echo "Este script necesita permisos de superusuario. Ejecútalo con 'sudo'."
    exit 1
fi

# User Name
USER_HOME=$(logname)

echo "Por favor, monta las Guest Additions en VirtualBox."
echo "Pulsa espacio para continuar una vez montadas..."

# Wait enter
read -r -p "Presiona Enter para continuar..."

# Check Guest additions are mounted
GUEST_ADDITIONS_DIR=$(ls -d /media/$USER_HOME/VBox_GAs_* 2>/dev/null | tail -n 1)

if [[ -d "$GUEST_ADDITIONS_DIR" ]]; then
    echo "Guest Additions detectadas en $GUEST_ADDITIONS_DIR. Continuando con la instalación..."
    sudo apt update && sudo apt install -y build-essential dkms linux-headers-$(uname -r)
    cd "$GUEST_ADDITIONS_DIR" || exit
    sudo ./VBoxLinuxAdditions.run
else
    echo "No se detectan las Guest Additions en el directorio /media/$USER_HOME/. Por favor, verifica que estén montadas."
    exit 1
fi
