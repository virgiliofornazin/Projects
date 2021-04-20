#!/bin/bash

source ../Scripts/is_wsl.sh

if [[ $IS_WSL == false ]]; then

    echo "unprotecting package managers folders from modifications..."

    chmod +r -R vcpkg

fi
