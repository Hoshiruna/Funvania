@ECHO OFF 

if not exist "rom/Castlevania_3.nes" (
  goto errorNoRom
  )

tools\asar.exe --fix-checksum=off --no-title-check "code/prePatch/preMain.asm" "rom/Castlevania_3.nes"
if errorlevel 1 goto errorBuild

tools\asar.exe --fix-checksum=off --no-title-check code/setup/header.asm header.sfc
if errorlevel 1 goto errorBuild
tools\asar.exe --fix-checksum=off --no-title-check code/setup/headerRemover.asm patch.sfc
if errorlevel 1 goto errorBuild
tools\asar.exe --fix-checksum=off --no-title-check main.asm patch.sfc
if errorlevel 1 goto errorBuild
copy /b /y "header.sfc"+"patch.sfc" "Castlevania_3.nes"
if errorlevel 1 goto errorBuild
del header.sfc 
del patch.sfc 

::timeout 3
pause 
exit /b 0

:errorBuild
echo ROM build failed.
pause
exit /b 1

:errorNoRom
echo no rom found! 
echo Put your "Castlevania_3.nes" rom into the "rom" folder and rename the file as shown.
pause
exit /b 1
