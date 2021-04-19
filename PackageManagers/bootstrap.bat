@echo off

pushd %~dp0

call unprotect.bat

cd vcpkg

echo bootstrapping vcpkg...

call bootstrap-vcpkg.bat

for /f tokens=1 %%package in (../PackageList/vcpkg/package-list.txt) do call ../Scripts/vcpkg_install_for_windows.bat "%%package"

vcpkg list

call %~dp0\protect.bat

echo list of installed vcpkg packages:

vcpkg list

popd
