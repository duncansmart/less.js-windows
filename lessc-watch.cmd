@ECHO OFF
CLS
:: Less watcher
:: Author: Alex Skrypnyk (alex.designworks@gmail.com)
:: Modified: 24/09/2012
:: Version 1.0
:: lessc must be installed 
:: [Original blog post](http://blog.dotsmart.net/2010/11/26/running-the-less-js-command-line-compiler-on-windows/). 
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
echo Starting watching %1. Output will be writtem to %2.
echo Use Ctrl-C to stop watching.
for /L %%n in (1,0,10) do (
  call "%~dp0lessc.cmd" %* 
  timeout /T 1 /NOBREAK>nul
)
ENDLOCAL