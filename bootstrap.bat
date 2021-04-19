@echo off

git submodule init
git submodule update

pushd %~dp0\PackageManagers

call bootstrap.bat

popd
