#!/bin/sh

source ../Scripts/is_wsl.sh

if [[ $IS_WSL == false ]]; then

    echo "protecting package managers folders from modifications..."

    chmod -r -R vcpkg

fi
