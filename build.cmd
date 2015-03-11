@echo off
pushd "%~dp0\bin"

:: Update node.exe
if not exist node.exe (
    echo Downloading latest node.exe
    cscript //nologo "%~dp0\tools\httpget.js" http://nodejs.org/dist/latest/node.exe node.exe
)

:: Install/Update less (assumes npm is installed globally)
echo Install/update less ...
call npm update --quiet

:: Due to the way node_modules work, the directory depth can get very deep and go beyond MAX_PATH (260 chars). 
:: Therefore grab all node_modues directories and move them up to base node_modules. Node's require() will then 
:: traverse up and find them at the higher level. Should be fine as long as there are no versioning conflicts.
:FLATTEN_NODE_MODULES
echo Flatenning node_modules

where flatten-packages >nul
if ERRORLEVEL 1 call npm install -g flatten-packages

call flatten-packages

:: clean varous junk directories from node_modules
:CLEAN_NODE_MODULES
pushd node_modules
echo Cleaning node_modules
for /d /r %%D in (*) do  (
    rem echo %%D
    if "%%~nD"=="build" rd /s /q "%%D"
    if "%%~nD"=="example" rd /s /q "%%D"
    if "%%~nD"=="tests" rd /s /q "%%D"
    if "%%~nD"=="test" rd /s /q "%%D"
    if "%%~nD"=="tst" rd /s /q "%%D"
    if "%%~nD"=="tmp" rd /s /q "%%D"
    if "%%~nD"=="man" rd /s /q "%%D"
)
:: various less stuff we don't need to redistribute
rd /s /q "less\.grunt" 2>nul
rd /s /q "less\.idea" 2>nul
rd /s /q "less\benchmark" 2>nul
rd /s /q "less\dist" 2>nul
rd /s /q "less\projectFilesBackup" 2>nul


:PACKAGE
pushd "%~dp0"
::parse version from 'lessc --version' output "lessc 1.5.0 (LESS Compiler) [JavaScript]"
for /f "tokens=2" %%V in ('bin\node bin\node_modules\less\bin\lessc --version') do set LESSVER=%%V

set RELEASE_ZIP="%~dp0less.js-windows-v%LESSVER%.zip"
echo Creating %RELEASE_ZIP%
if exist %RELEASE_ZIP% del %RELEASE_ZIP%
"%~dp0tools\7-zip\7za.exe" a %RELEASE_ZIP% bin\* -i!lessc.cmd -i!lessc-watch.cmd -i!LICENSE -i!README.md >nul

popd
popd
popd
