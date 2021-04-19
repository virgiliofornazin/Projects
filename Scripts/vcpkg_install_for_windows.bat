@echo off

for /f tokens=1 %%triplet in (../PackageList/vcpkg/triplets-windows.txt) do ./vcpkg install %1:%%triplet
