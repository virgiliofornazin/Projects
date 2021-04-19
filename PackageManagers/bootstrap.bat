@echo off

call %~dp0\unprotect.bat

pushd %~dp0\vcpkg

echo bootstrapping vcpkg...

call bootstrap_vcpkg.bat

vcpkg install boost:x86-uwp
vcpkg install boost:x86-windows
vcpkg install boost:x86-windows-static
vcpkg install boost:x64-windows
vcpkg install boost:x64-windows-static
vcpkg install boost:arm-windows
vcpkg install boost:arm64-uwp
vcpkg install boost:arm64-windows-static

vcpkg list

call %~dp0\protect.bat

echo list of installed vcpkg packages:

vcpkg list

popd
