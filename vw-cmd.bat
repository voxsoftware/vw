@echo off
SET SUBDIR=%~dp0
"%SUBDIR%\vwdata\jx" --expose-gc "%SUBDIR%\vwdata\node_modules\vw" "%*"
