@echo off

pushd %~dp0

call unprotect.bat

cd vcpkg

echo bootstrapping vcpkg...

call bootstrap-vcpkg.bat

for /f %%G in (../PackageList/vcpkg/package-list.txt) do call ../../Scripts/vcpkg_install_for_windows.bat %%G

vcpkg list

call %~dp0\protect.bat

echo list of installed vcpkg packages:

vcpkg list

popd
