@echo off
pushd "%~dp0"
set TEST_FILE="less-test-out.css"
call ..\lessc.cmd test.less > %TEST_FILE%
echo n | comp test-expected.css %TEST_FILE% /A 2> nul
if %ERRORLEVEL% EQU 0 (
    echo === PASS ===
) else (
    echo === FAIL ===
)
::del %TEST_FILE%
popd
