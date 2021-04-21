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
# CMake root project for workspace
#

cmake_minimum_required(VERSION 3.20)

project(Workspace LANGUAGES C CXX)

include(CMake/BuildSettings.cmake)

add_subdirectory(Sources)
add_subdirectory(TestingCode)
