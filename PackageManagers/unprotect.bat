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
rem $/PackageManagers/unprotect.bat
rem
rem Unprotect (mark as read-write) all package manager files for package building
rem
rem -----------------------------------------------------------------------------

pushd %~dp0

echo unprotecting package managers folders from modifications...

attrib -A -S -H -R /s vcpkg

popd
