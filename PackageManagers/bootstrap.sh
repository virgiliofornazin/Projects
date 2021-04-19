#!/bin/sh

./unprotect.sh

cd vcpkg

./bootstrap_vcpkg.sh

./vcpkg install boost
./vcpkg list

cd ..

./protect.sh

cd vcpkg

./vcpkg list

cd ..
