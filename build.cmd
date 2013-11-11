@echo off
pushd "%~dp0\bin"

:: create httpget.js for use with cscript.exe
set HTTPGET_JS="%TEMP%\httpget.js"
echo (function(b,d){var a=b.Arguments(0);var c=b.Arguments(1);var f=new d("MSXML2.XMLHTTP");f.open("GET",a,false);f.send();if(f.Status==200){var e=new d("ADODB.Stream");e.Open();e.Type=1;e.Write(f.ResponseBody);e.Position=0;e.SaveToFile(c);e.Close()}else{b.Echo("Error: HTTP "+f.status+" "+f.statusText)}})(WScript,ActiveXObject); > %HTTPGET_JS%

:: Update node.exe
if not exist node.exe (
    cscript //nologo %HTTPGET_JS% http://nodejs.org/dist/latest/node.exe node.exe
)

:: Install/Update less
if exist "node_modules\less" (
    call npm update less > nul 2>&1
) else (
    call npm install less > nul 2>&1
)

:: Recursively grabs nested node_modules and moves them to the top level where 
:: the require() algorithm will eventually find them. We do this because
:: node_modules can get nested beyond Win32's MAX_PATH 260 char limit.
:FLATTEN_NODE_MODULES
set BASE_MODULES=%~dp0node_modules
pushd "%BASE_MODULES%"
for /l %%I in (1,1,3) do (
    for /d /r %%D in (node_modules) do if exist %%D (
        pushd "%%D"
        for /d %%M in (*) do (
            rem echo %%~dpnM
            move /y "%%M" "%BASE_MODULES%\%%M" >nul
        )
        popd
        rmdir "%%D"
    )
)

:: clean varous junk directories from node_modules
:CLEAN_JS
for /d /r %%D in (*) do  (
    echo %%D
    if "%%~nD"=="build" rd /s /q "%%D"
    if "%%~nD"=="images" rd /s /q "%%D"
    if "%%~nD"=="example" rd /s /q "%%D"
    if "%%~nD"=="tests" rd /s /q "%%D"
    if "%%~nD"=="test" rd /s /q "%%D"
    if "%%~nD"=="tst" rd /s /q "%%D"
    if "%%~nD"=="tmp" rd /s /q "%%D"
    if "%%~nD"=="man" rd /s /q "%%D"
)
:: various less junk
rd /s /q "less\.grunt"
rd /s /q "less\.idea"
rd /s /q "less\benchmark"
rd /s /q "less\dist"
rd /s /q "less\projectFilesBackup"


::tidy up
del %HTTPGET_JS%

popd