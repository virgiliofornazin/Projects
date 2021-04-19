#!/bin/sh

./unprotect.sh

cd vcpkg

echo" bootstrapping vcpkg..."

./bootstrap-vcpkg.sh

package_list="../Packages/vcpkg/package_list.txt"

if [[ -f "$package_list" ]]
then
    while IFS=read -r package
    do
        echo "installing package $package in vcpkg..."
        ./vcpkg install $package
    done <"$package_list"
fi

./vcpkg install boost
./vcpkg list

cd ..

./protect.sh

cd vcpkg

./vcpkg list

cd ..
