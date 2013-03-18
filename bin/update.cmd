@echo off
pushd "%~dp0"

:: Update node.exe if newer
where curl > nul 2>&1 
if %ERRORLEVEL% == 0 (
    curl --time-cond node.exe --remote-time --silent --show-error http://nodejs.org/dist/latest/node.exe -o node.exe
) else (
    echo Warning: curl not found, node.exe not updated.
)

:: Compress with upx
where upx > nul 2>&1 
if %ERRORLEVEL% == 0 (
    upx node.exe > nul 2>&1
) else (
    echo Warning: upx not found, node.exe not compressed.
)

if exist "node_modules\less" (
    call npm update less > nul 2>&1
) else (
    call npm install less > nul 2>&1
)

:: Update less
call npm update less > nul 2>&1

:: Copy files into place
xcopy /s /y /q "node_modules\less\LICENSE" ..\lib\less\ > nul
xcopy /s /y /q "node_modules\less\lib\less\*" ..\lib\less\ > nul
xcopy /s /y /q "node_modules\less\bin\*" .\ > nul

xcopy /y /q "node_modules\less\node_modules\ycssmin\*.js*" ..\lib\less\node_modules\ycssmin\ > nul
xcopy /y /q "node_modules\less\node_modules\ycssmin\LICENSE" ..\lib\less\node_modules\ycssmin\ > nul

popd