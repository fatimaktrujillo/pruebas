$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$batFile = Join-Path $scriptDir "auto_push.bat"
$logFile = Join-Path $scriptDir "log_auto_push.txt"

$action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument ("/c `"" + $batFile + "`" >> `"" + $logFile + "`" 2>&1")

$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable -ExecutionTimeLimit (New-TimeSpan -Minutes 10)

$trigger1 = New-ScheduledTaskTrigger -Daily -At "10:00AM"
Register-ScheduledTask -TaskName "Dashboard IJM - 10am" -Action $action -Trigger $trigger1 -Settings $settings -Force
Write-Host "Tarea creada: Dashboard IJM - 10am"

$trigger2 = New-ScheduledTaskTrigger -Daily -At "17:00"
Register-ScheduledTask -TaskName "Dashboard IJM - 5pm" -Action $action -Trigger $trigger2 -Settings $settings -Force
Write-Host "Tarea creada: Dashboard IJM - 5pm"

Write-Host "Listo."
