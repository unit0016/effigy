@echo off
del "tgstation.rsc"
"%~dp0\..\bootstrap\javascript.bat" "%~dp0\build.js" %*
