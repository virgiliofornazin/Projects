#!/bin/sh

WSL_VERSION=`cat /proc/version`
IS_WSL=`cat /proc/version | grep ucrosoft`

if [[ "$IS_WSL" == "" ]]; then
    IS_WSL=false
else
    IS_WSL=true
fi
