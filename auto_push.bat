@echo off
:: ============================================================
::  auto_push.bat  -  Exporta datos y sube a GitHub
::  Llamado automáticamente por el Programador de Tareas.
:: ============================================================

set REPO_DIR=C:\Users\FTQ\OneDrive - apoyoconsultoria.com\Dashboards\dashboard_github
set PYTHON=C:\Users\FTQ\AppData\Local\anaconda3\python.exe

cd /d "%REPO_DIR%"
if errorlevel 1 (
    echo ERROR: No se encontro la carpeta del repositorio.
    exit /b 1
)

echo [%date% %time%] Iniciando actualizacion...

"%PYTHON%" export_data.py
if errorlevel 1 (
    echo ERROR: Fallo export_data.py
    exit /b 1
)

git add data\dashboard_data.json
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Actualizacion automatica %date% %time%"
    git push origin main
    echo OK: Datos subidos a GitHub.
) else (
    echo Sin cambios nuevos.
)
