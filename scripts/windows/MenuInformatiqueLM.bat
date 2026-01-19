@ECHO OFF
REM.-- Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

:menuLOOP
echo.
echo.= Menu ========= Laurent Wattieaux Informatique CLG Port Lympia =========
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
set choice=
echo.&set /p choice=Make a choice or hit ENTER to quit: ||GOTO:EOF
echo.&call:menu_%choice%
GOTO:menuLOOP

::-----------------------------------------------------------
:: menu functions follow below here
::-----------------------------------------------------------

:menu_1   cleanmgr nettoyage disque
cleanmgr /sagerun:65535
GOTO:EOF

:menu_2   cleanning dossier temp
del /s /f /q c:\windows\temp\*.*
rd /s /q c:\windows\temp
md c:\windows\temp
REM del /s /f /q C:\WINDOWS\Prefetch
del /s /f /q %temp%\*.*
rd /s /q %temp%
md %temp%
deltree /y c:\windows\tempor~1
deltree /y c:\windows\temp
deltree /y c:\windows\tmp
deltree /y c:\windows\ff*.tmp
REM deltree /y c:\windows\history
REM deltree /y c:\windows\cookies
REM deltree /y c:\windows\recent
REM deltree /y c:\windows\spool\printers
REM del c:\WIN386.SWP
GOTO:EOF

:menu_3   defrag C:
defrag C: /U /V
GOTO:EOF

:menu_4   ipconfig /all
ipconfig /all
GOTO:EOF

:menu_5   flushdns
ipconfig /flushdns
GOTO:EOF

:menu_6   sfc /scannow
sfc /scannow
GOTO:EOF

:menu_7   Moniteur de ressources
resmon.exe
GOTO:EOF

:menu_8   CMD
set UD_TIME_LIMIT=6h 30m
C:\Windows\System32\cmd.exe


:menu_9   Pedago Net use U: \\172.16.0.12\laurent.wattieaux\perso
net use U: \\172.16.0.12\laurent.wattieaux\perso /USER:laurent.wattieaux


:menu_T   Tip
echo.It's easy to add a line separator using one or more fake labels
GOTO:EOF

:menu_C   Clear Screen
cls

GOTO:EOF
