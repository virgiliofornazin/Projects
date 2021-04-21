#!/bin/bash

# Virgilio A. Fornazin Development Workspace
# Copyright (C) 2021, Virgilio Alexandre Fornazin
# virgiliofornazin@gmail.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

#
# bootstrap script for workspace package managers
#

./unprotect.sh

cd vcpkg

echo "bootstrapping vcpkg..."

./bootstrap-vcpkg.sh

./vcpkg update

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
