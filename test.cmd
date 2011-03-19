@echo off
set TEST_FILE="%TEMP%\less-test-%RANDOM%.css"
call lessc.cmd test.less > %TEST_FILE%
echo n | comp test-expected.css %TEST_FILE% /A 2> nul
if %ERRORLEVEL% EQU 0 (
    echo === PASS ===
) else (
    echo === FAIL ===
)
del %TEST_FILE%