@echo off

pushd %~dp0

echo protecting package managers folders from modifications...

attrib -A -S -H -R /s vcpkg

popd
