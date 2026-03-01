@echo off
REM =====================================================
REM Script Batch Windows d'exemple
REM Description: Affiche des informations système
REM =====================================================

echo.
echo ========================================
echo    Informations Système Windows
echo ========================================
echo.

echo Nom de l'ordinateur: %COMPUTERNAME%
echo Nom d'utilisateur: %USERNAME%
echo Date: %DATE%
echo Heure: %TIME%
echo.

systeminfo | findstr /C:"Nom du système d'exploitation" /C:"Version du système"

echo.
echo ========================================
pause
