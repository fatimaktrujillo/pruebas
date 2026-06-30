@echo off
:: ============================================================
::  auto_push_horas.bat
::  Descarga horas del mes, copia al repo y sube a GitHub.
:: ============================================================

set PRUEBAS_DIR=C:\Users\FTQ\OneDrive - apoyoconsultoria.com\Dashboards\Pruebas
set REPO_DIR=C:\Users\FTQ\OneDrive - apoyoconsultoria.com\Dashboards\dashboard_horas
set PYTHON=C:\Users\FTQ\AppData\Local\anaconda3\python.exe

echo [%date% %time%] Iniciando descarga de horas...

:: 1. Correr el script de descarga
cd /d "%PRUEBAS_DIR%"
"%PYTHON%" descargar_horas.py
if errorlevel 1 (
    echo ERROR: Fallo descargar_horas.py
    exit /b 1
)

:: 2. Copiar JSON al repo
for /f "delims=" %%F in ('dir /b /o-d "%PRUEBAS_DIR%\horas_*.json" 2^>nul') do (
    set JSON_FILE=%%F
    goto :copiado
)
:copiado
if not defined JSON_FILE (
    echo ERROR: No se encontro archivo horas_*.json
    exit /b 1
)

copy /y "%PRUEBAS_DIR%\%JSON_FILE%" "%REPO_DIR%\data\%JSON_FILE%" >nul
copy /y "%PRUEBAS_DIR%\%JSON_FILE%" "%REPO_DIR%\data\horas_latest.json" >nul
echo [OK] JSON copiado: %JSON_FILE%

:: 3. Git push
cd /d "%REPO_DIR%"
git pull origin main --rebase
git add data\horas_*.json data\horas_latest.json
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Actualizacion horas %date% %time%"
    git push origin main
    echo [OK] Datos subidos a GitHub.
) else (
    echo Sin cambios nuevos.
)
