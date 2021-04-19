@echo off

pushd %~dp0\..\PackageManagers

echo unprotecting package managers folders from modifications...

attrib -a -s -h -r /s *
attrib -a -s +h -r /s .git*

popd
