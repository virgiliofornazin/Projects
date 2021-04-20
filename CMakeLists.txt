cmake_minimum_required(VERSION 3.20)

project(Workspace LANGUAGES C CXX)

include(CMake/BuildSettings.cmake)

add_subdirectory(Sources)
add_subdirectory(TestingCode)
