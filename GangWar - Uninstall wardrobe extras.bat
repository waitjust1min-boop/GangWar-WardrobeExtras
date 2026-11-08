@echo off
title GangWar - remove the wardrobe extras
echo.
echo   GANGWAR - REMOVE THE WARDROBE EXTRAS
echo   Puts the game's original hat and clothes files back. Your GangWar progress is not touched.
echo.
echo   Close GTA IV first, then press a key to start.
echo.
pause >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\GangWar_tools\hats_installer\Install-GangWarHats.ps1" -Uninstall
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\GangWar_tools\clothes_installer\Install-GangWarClothes.ps1" -Uninstall
echo.
echo   Finished.
echo.
pause
