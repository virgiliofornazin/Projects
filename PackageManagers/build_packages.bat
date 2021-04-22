@echo off

rem -----------------------------------------------------------------------------
rem
rem This file is part of the Virgilio Alexandre Fornazin Development Workspace
rem Copyright (C) 2021, Virgilio Alexandre Fornazin (virgiliofornazin@gmail.com)
rem
rem -----------------------------------------------------------------------------
rem
rem This program is free software; you can redistribute it and/or
rem modify it under the terms of the GNU Lesser General Public
rem License as published by the Free Software Foundation; either
rem version 3 of the License, or (at your option) any later version.
rem
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
rem GNU Lesser General Public License for more details.
rem
rem You should have received a copy of the GNU Lesser General Public License
rem along with this program; if not, write to the Free Software Foundation,
rem Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
rem
rem -----------------------------------------------------------------------------
rem
rem $/PackageManagers/build_packages.bat
rem
rem Build all packages and dependencies of all package managers
rem
rem -----------------------------------------------------------------------------

pushd %~dp0

call unprotect.bat

cd vcpkg

echo bootstrapping vcpkg...

call bootstrap-vcpkg.bat

for /f %%G in (../PackageList/vcpkg/package_list.txt) do call ../../Scripts/vcpkg_install_for_windows.bat %%G

vcpkg list

call %~dp0\protect.bat

echo list of installed vcpkg packages:

vcpkg list

popd
