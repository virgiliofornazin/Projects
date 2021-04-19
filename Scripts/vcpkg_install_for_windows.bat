@echo off

for /f %%G in (../PackageList/vcpkg/triplets-windows.txt) do vcpkg install %1:%%G
