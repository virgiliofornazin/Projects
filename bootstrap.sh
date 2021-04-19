#!/bin/sh

git submodule init
git submodule update

cd PackageManagers

./bootstrap.sh

cd ..
