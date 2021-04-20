#!/bin/bash

git submodule init
git submodule update

cd PackageManagers

./bootstrap.sh

cd ..
