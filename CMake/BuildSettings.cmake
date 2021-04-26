# -----------------------------------------------------------------------------
#
# This file is part of the Virgilio Alexandre Fornazin Development Workspace
# Copyright (C) 2021, Virgilio Alexandre Fornazin (virgiliofornazin@gmail.com)
#
# -----------------------------------------------------------------------------
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# -----------------------------------------------------------------------------
#
# $/CMake/BuiidSettinogs.cmake
#
# CMake build settings for all workspace projects
#
# -----------------------------------------------------------------------------

# Flags that control code generation below
set(CMAKE_BUILD_SETTINGS_COMPILER_WARNINGS ON)

if(NOT ("${CMAKE_TOOLCHAIN_FILE}" STREQUAL ""))
    message(STATUS "Toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
endif()

# Check for interprocedural optimizations at linker for Release and RelWithDebInfo builds
if(("${CMAKE_BUILD_TYPE}" STREQUAL "Release") OR ("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo"))
    cmake_policy(SET CMP0069 NEW)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT CMAKE_BUILD_SETTINGS_IPO_SUPPORTED LANGUAGES C CXX)
    if(CMAKE_BUILD_SETTINGS_IPO_SUPPORTED)
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
        message(STATUS "Interprocedural optimizations enabled")
    endif()
endif()

# Check for position-independent code flags
set(CMAKE_BUILD_SETTINGS_PIE_SUPPORTED OFF)
if(NOT ("${CMAKE_BUILD_TYPE}" STREQUAL "RelMinSize"))
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
    message(STATUS "Position independent code enabled for libraries")
    cmake_policy(SET CMP0083 NEW)
    include(CheckPIESupported)
    check_pie_supported(LANGUAGES C CXX)
    if(CMAKE_C_LINK_PIE_SUPPORTED AND CMAKE_CXX_LINK_PIE_SUPPORTED)
        set(CMAKE_BUILD_SETTINGS_PIE_SUPPORTED ON)
        message(STATUS "Position independent code enabled for executables")
    endif()
endif()

message(STATUS "PIE: ${CMAKE_C_LINK_OPTIONS_PIE}")

# Add GNU settings when needed
if(NOT (MSVC OR MINGW))
    include(GNUInstallDirs)
endif()

# Find threads library
find_package(Threads REQUIRED)
link_libraries(Threads::Threads)

# Find BOOST libraries
find_package(Boost COMPONENTS system thread chrono filesystem REQUIRED)
add_compile_definitions(BOOST_ALL_DYN_LINK)
include_directories(${Boost_INCLUDE_DIRS})
link_libraries(Boost::system Boost::thread Boost::chrono Boost::filesystem)

# Default compiler and linker settings and definitions
add_compile_definitions(__STDC_WANT_SECURE_LIB__=1)
add_compile_definitions(__STDC_WANT_LIB_EXT1__=1)

if(MSVC)
	# Target system definitions
	add_compile_definitions(WINVER=0x0601)
	add_compile_definitions(_WIN32_WINNT=0x0601)

	# Compiler definitions
	if(CMAKE_BUILD_SETTINGS_COMPILER_WARNINGS)
        add_compile_options(/W4)
        add_compile_options(/WX)
    else()
        add_compile_definitions(_CRT_NONSTDC_NO_DEPRECATE)
	    add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
	    add_compile_definitions(_WINSOCK_DEPRECATED_NO_WARNINGS)
	    add_compile_definitions(_SILENCE_ALL_CXX17_DEPRECATION_WARNINGS)
    endif()

	# C++ language conformance
	add_compile_options(/EHsc)
	add_compile_options(/permissive-)
	add_compile_options(/std:c++latest)
	add_compile_options(/Zc:__cplusplus)
	add_compile_options(/Zc:preprocessor)
	add_compile_options(/fp:precise)
	add_compile_options(/Gy)

    if(CMAKE_POSITION_INDEPENDENT_CODE)
        add_link_options(/DYNAMICBASE)
        add_link_options(/LARGEADDRESSAWARE)
        add_link_options(/HIGHENTROPYVA)
    endif()

    add_link_options(/GUARD:CF)
    add_link_options(/CETCOMPAT)
    add_link_options(/NXCOMPAT)
    add_link_options(/WX)

	# Debug information
	if(("${CMAKE_BUILD_TYPE}" STREQUAL "Debug") OR ("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo"))
		add_compile_options(/FC)
        add_compile_options(/Zi)
		add_compile_options(/Zf)
        add_link_options(/MAP)
        add_link_options(/MAPINFO:EXPORTS)
	endif()

	# Optimizations
	if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	else()
		add_compile_options(/Oi)
        if("${CMAKE_BUILD_TYPE}" STREQUAL "RelMinSize")
            add_compile_options(/Os)
        else()
            add_compile_options(/Ot)
		endif()
    	add_link_options(/OPT:REF)
	    add_link_options(/OPT:ICF)
	endif()
else()
	# System definitions
	add_compile_definitions(_GNU_SOURCE)
    add_compile_definitions(_FILE_OFFSET_BITS=64)
	add_compile_definitions(_FORTIFY_SOURCE=2)

	# Compiler definitions
	if(CMAKE_BUILD_SETTINGS_COMPILER_WARNINGS)
	    add_compile_options(-Wall)
	    add_compile_options(-Wextra)
	    add_compile_options(-Werror)
	    add_compile_options(-pedantic)
	    add_compile_options(-pedantic-errors)
    endif()

	# C+ language definitions
	add_compile_options(-fexceptions)
	add_compile_options(-std=c++20)

	# Debug information
	if(("${CMAKE_BUILD_TYPE}" STREQUAL "Debug") OR ("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo"))
		add_compile_options(-g)
		add_compile_options(-fno-omit-frame-pointer)
	endif()

	# Optimizations
	if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	else()
	endif()
endif()
