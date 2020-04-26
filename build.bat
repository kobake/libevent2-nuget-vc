@echo.
@echo "==============================="
@echo "clean packaging output files"
@echo "==============================="

del packaging\x86_debug\*.lib
del packaging\x86_release\*.lib
del packaging\x86_include\event2\*.h
del packaging\x64_debug\*.lib
del packaging\x64_release\*.lib
del packaging\x64_include\event2\*.h


@echo.
@echo "==============================="
@echo "x86"
@echo "==============================="

setlocal
pushd libevent
rmdir /S /Q cmake-make32
mkdir cmake-make32
pushd cmake-make32

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"

cmake -G "Visual Studio 16 2019" -A Win32 -DEVENT__DISABLE_TESTS=ON ..
msbuild event.vcxproj       -p:Configuration=Debug   -p:Platform=Win32
msbuild event.vcxproj       -p:Configuration=Release -p:Platform=Win32
msbuild event_core.vcxproj  -p:Configuration=Debug   -p:Platform=Win32
msbuild event_core.vcxproj  -p:Configuration=Release -p:Platform=Win32
msbuild event_extra.vcxproj -p:Configuration=Debug   -p:Platform=Win32
msbuild event_extra.vcxproj -p:Configuration=Release -p:Platform=Win32

xcopy lib\Debug\*.lib    ..\..\packaging\x86_debug\.
xcopy lib\Release\*.lib  ..\..\packaging\x86_release\.
xcopy include\event2\*.h ..\..\packaging\x86_include\event2\.

popd
popd
endlocal
@echo.


@echo.
@echo "==============================="
@echo "x64"
@echo "==============================="

setlocal
pushd libevent
rmdir /S /Q cmake-make64
mkdir cmake-make64
pushd cmake-make64

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

cmake -G "Visual Studio 16 2019" -A x64 -DEVENT__DISABLE_TESTS=ON ..
msbuild event.vcxproj       -p:Configuration=Debug   -p:Platform=x64
msbuild event.vcxproj       -p:Configuration=Release -p:Platform=x64
msbuild event_core.vcxproj  -p:Configuration=Debug   -p:Platform=x64
msbuild event_core.vcxproj  -p:Configuration=Release -p:Platform=x64
msbuild event_extra.vcxproj -p:Configuration=Debug   -p:Platform=x64
msbuild event_extra.vcxproj -p:Configuration=Release -p:Platform=x64

xcopy lib\Debug\*.lib   ..\..\packaging\x64_debug\.
xcopy lib\Release\*.lib ..\..\packaging\x64_release\.
xcopy include\event2\*.h ..\..\packaging\x64_include\event2\.

popd
popd
endlocal
@echo.
