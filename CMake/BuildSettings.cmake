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
# Build settings for CMake programs
#

message(STATUS "toolchain file: ${CMAKE_TOOLCHAIN_FILE}")

# Check for interprocedural optimizations at linker
cmake_policy(SET CMP0069 NEW)
include(CheckIPOSupported)
check_ipo_supported(RESULT CMAKE_BUILD_SETTINGS_IPO_SUPPORTED LANGUAGES C CXX)

# Check for position-independent code flags
cmake_policy(SET CMP0083 NEW)
include(CheckPIESupported)
check_pie_supported(LANGUAGES C CXX)
if(CMAKE_C_LINK_PIE_SUPPORTED AND CMAKE_CXX_LINK_PIE_SUPPORTED)
    set(CMAKE_BUILD_SETTINGS_PIE_SUPPORTED TRUE)
else()
    set(CMAKE_BUILD_SETTINGS_PIE_SUPPORTED FALSE)
endif()

# Add GNU settings when needed
if(NOT (MSVC OR MINGW))
    include(GNUInstallDirs)
endif()

# Find threads library
find_package(Threads REQUIRED)
link_libraries(Threads::Threads)

# Find BOOST libraries
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set(Boost_DEBUG 1)
endif()
find_package(Boost 1.75.0 COMPONENTS system thread chrono REQUIRED)
add_compile_definitions(BOOST_ALL_DYN_LINK)
include_directories(${Boost_INCLUDE_DIRS})
link_libraries(Boost::system Boost::thread Boost::chrono)

# Default compiler and linker settings and definitions
add_compile_definitions(__STDC_WANT_SECURE_LIB__=1)
add_compile_definitions(__STDC_WANT_LIB_EXT1__=1)

# Flags that control code generation below
set(CMAKE_BUILD_SETTINGS_COMPILER_WARNINGS TRUE)
set(CMAKE_BUILD_SETTINGS_DEBUG_BUILD FALSE)
set(CMAKE_BUILD_SETTINGS_DEBUG_INFORMATION FALSE)

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	set(_CMAKE_GENERATE_DEBUG_BUILD TRUE)
	set(_CMAKE_INCLUDE_DEBUG_INFORMATION TRUE)
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
	set(_CMAKE_INCLUDE_DEBUG_INFORMATION TRUE)
endif()

if(MSVC)
	# Target system definitions
	add_compile_definitions(WINVER=0x0601)
	add_compile_definitions(_WIN32_WINNT=0x0601)

	# Compiler definitions
	if(CMAKE_BUILD_SETTINGS_COMPILER_WARNINGS)
        add_compile_options(/W4)
        add_compile_options(/WX)
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

	# Debug information
	if(CMAKE_BUILD_SETTINGS_DEBUG_INFORMATION)
		add_compile_options(/FC)
		add_compile_options(/Zi)
		add_compile_options(/Zf)
	endif()

	# Optimizations
	if(CMAKE_BUILD_SETTINGS_DEBUG_BUILD)
		add_link_options(/INCREMENTAL)
	else()
		add_compile_options(/Oi)
		add_compile_options(/Ot)
		add_compile_options(/Gy)
		add_link_options(/INCREMENTAL:NO)
		add_link_options(/LTCG)
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
	if(CMAKE_BUILD_SETTINGS_DEBUG_INFORMATION})
		add_compile_options(-g)
		add_compile_options(-fno-omit-frame-pointer)
	endif()

	# Optimizations
	if(CMAKE_BUILD_SETTINGS_DEBUG_BUILD)
	else()
	endif()
endif()
