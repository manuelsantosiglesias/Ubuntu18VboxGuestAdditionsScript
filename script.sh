#!/bin/bash
echo "Por favor, monta las Guest Additions en VirtualBox."
echo "Pulsa espacio para continuar una vez montadas..."

# Wait spacebar
while :; do
    read -n1 -r key
    if [[ $key == ' ' ]]; then
        break
    fi
done

# Check Guest additions are mounted
GUEST_ADDITIONS_DIR=$(find /media/$USER -type d -name "VBox_GAs_*" 2>/dev/null)

if [[ -d "$GUEST_ADDITIONS_DIR" ]]; then
    echo "Guest Additions detectadas en $GUEST_ADDITIONS_DIR. Continuando con la instalación..."
    sudo apt update && sudo apt install -y build-essential dkms linux-headers-$(uname -r)
    cd "$GUEST_ADDITIONS_DIR" || exit
    sudo ./VBoxLinuxAdditions.run
else
    echo "No se detectan las Guest Additions en el directorio /media/$USER/. Por favor, verifica que estén montadas."
    exit 1
fi
