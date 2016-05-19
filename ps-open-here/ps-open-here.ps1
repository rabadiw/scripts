$cmduac = "$env:SystemRoot\System32\cmd-uac.exe"
Copy-Item $env:SystemRoot\System32\cmd.exe $cmduac

Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -Name $cmduac -Value '~ RUNASADMIN'

$menu = 'Open Powershell Window Here'
#$command = "$PSHOME\powershell.exe -NoExit -NoProfile -Command ""Set-Location '%V'"""
#$command = "$PSHOME\powershell.exe -Command &{Start-Process powershell.exe -Verb runas -ArgumentList '-NoProfile','-NoExit','-Command Set-Location ""%V""'}"
$command = "cmd-uac.exe /s /c start $PSHOME\powershell.exe -NoExit -NoProfile -Command ""Set-Location '%V'"""

$regKeys = 'directory' #, 'directory\background', 'drive'}

$regKeys | %{ 
    New-Item -Path "Registry::HKEY_CLASSES_ROOT\$_\shell" -Name powershell\command -Force |
    Set-ItemProperty -Name '(default)' -Value $command -PassThru |
    Set-ItemProperty -Path {$_.PSParentPath} -Name '(default)' -Value $menu -PassThru |
    Set-ItemProperty -Name Extended -Value '' -PassThru |
    Set-ItemProperty -Name HasLUAShield -Value ''
    
}


    