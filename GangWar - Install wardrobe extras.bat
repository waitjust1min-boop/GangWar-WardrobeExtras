@echo off
title GangWar - wardrobe extras
echo.
echo   GANGWAR - WARDROBE EXTRAS
echo   Adds the hats, clothes, hairstyles and faces of the game's other men to Niko's wardrobe.
echo   They are built from your own game files (about 2 minutes). A copy of the two game files
echo   it changes is kept in the GangWar_backups folder.
echo.
echo   Close GTA IV first, then press a key to start.
echo.
pause >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\GangWar_tools\hats_installer\Install-GangWarHats.ps1"
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\GangWar_tools\clothes_installer\Install-GangWarClothes.ps1" -All
echo.
echo   Finished. Start GTA IV, open the GangWar menu (P, or LB + SELECT) and go to the WARDROBE tab.
echo   To take the extras out again: "GangWar - Uninstall wardrobe extras.bat".
echo.
pause
