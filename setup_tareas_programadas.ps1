# ============================================================
#  setup_tareas_programadas.ps1
#  Crea dos tareas en el Programador de Windows:
#    "Dashboard IJM - 10am"  → todos los días a las 10:00
#    "Dashboard IJM - 5pm"   → todos los días a las 17:00
#
#  Ejecutar UNA SOLA VEZ como Administrador:
#    Clic derecho → "Ejecutar con PowerShell"
# ============================================================

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$batFile   = Join-Path $scriptDir "auto_push.bat"
$logFile   = Join-Path $scriptDir "log_auto_push.txt"

if (-not (Test-Path $batFile)) {
    Write-Error "No se encontro auto_push.bat en: $batFile"
    exit 1
}

$action = New-ScheduledTaskAction `
    -Execute  "cmd.exe" `
    -Argument "/c `"$batFile`" >> `"$logFile`" 2>&1"

$settings = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 10)

$trigger1 = New-ScheduledTaskTrigger -Daily -At "10:00AM"
Register-ScheduledTask -TaskName "Dashboard IJM - 10am" -Action $action -Trigger $trigger1 -Settings $settings -Description "Sube datos del seguimiento IJM a GitHub Pages (10am)" -Force
Write-Host "✓ Tarea creada: Dashboard IJM - 10am" -ForegroundColor Green

$trigger2 = New-ScheduledTaskTrigger -Daily -At "5:00PM"
Register-ScheduledTask -TaskName "Dashboard IJM - 5pm" -Action $action -Trigger $trigger2 -Settings $settings -Description "Sube datos del seguimiento IJM a GitHub Pages (5pm)" -Force
Write-Host "✓ Tarea creada: Dashboard IJM - 5pm" -ForegroundColor Green

Write-Host ""
Write-Host "Listo. Verifica en: Inicio > Programador de tareas > Biblioteca" -ForegroundColor Cyan
