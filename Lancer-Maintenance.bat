@echo off
REM ============================================================================
REM Script de lancement pour Windows-Maintenance.ps1
REM Compatible Windows 10 et Windows 11
REM ============================================================================

title Lanceur - Script de Maintenance Windows
color 0A

echo.
echo ========================================================================
echo               LANCEUR DU SCRIPT DE MAINTENANCE WINDOWS
echo                            LM-Tools v1.0
echo ========================================================================
echo.
echo Ce script va lancer le script PowerShell de maintenance.
echo.
echo IMPORTANT : Une elevation des privileges sera demandee.
echo             Vous devez accepter pour continuer.
echo.
echo ========================================================================
echo.

REM Verification de l'existence du fichier PowerShell
if not exist "%~dp0Windows-Maintenance.ps1" (
    echo ERREUR : Le fichier Windows-Maintenance.ps1 est introuvable !
    echo.
    echo Assurez-vous que les fichiers suivants sont dans le meme dossier :
    echo   - Lancer-Maintenance.bat
    echo   - Windows-Maintenance.ps1
    echo.
    pause
    exit /b 1
)

echo Lancement du script PowerShell...
echo.

REM Lancement du script PowerShell avec elevation automatique
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0Windows-Maintenance.ps1""' -Verb RunAs}"

REM Verification du code de retour
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================================================
    echo Script lance avec succes !
    echo ========================================================================
) else (
    echo.
    echo ========================================================================
    echo ATTENTION : Une erreur s'est produite lors du lancement.
    echo Code d'erreur : %ERRORLEVEL%
    echo ========================================================================
    echo.
    echo Causes possibles :
    echo   - Vous avez refuse l'elevation des privileges
    echo   - PowerShell n'est pas disponible sur votre systeme
    echo   - Le fichier Windows-Maintenance.ps1 est corrompu
    echo.
)

echo.
pause
