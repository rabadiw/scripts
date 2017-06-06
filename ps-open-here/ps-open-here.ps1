#
# The following code will create an 'Open Here' menu 
# containing sub menu entries for: 
#     cmd, cmd(Admin), powershell, powershell(Admin)
#     HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore
#     https://msdn.microsoft.com/en-us/library/windows/desktop/hh127467(v=vs.85).aspx
# Warning: code provided "AS IS", use with discretion.

$osversion = [Version](Get-CimInstance Win32_OperatingSystem).Version

if ($osversion.Major -eq 10) {
    #Window 10
    'directory', 'directory\background', 'drive' | %{ 
        New-Item -Path "Registry::HKEY_CLASSES_ROOT\$_\shell" -Name openhere -Force |
        Set-ItemProperty -Name MUIVerb -Value 'Open Here' -PassThru |
        Set-ItemProperty -Name SubCommands -Value 'Windows.cmd;Windows.cmdPromptAsAdministrator;Windows.Powershell;Windows.PowershellAsAdmin' -PassThru | 
        Set-ItemProperty -Name Extended -Value ''
    }
} elseif ($osversion.Major -eq 6) {
    #Window 7
    New-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell" -Name "Windows.cmd" -Force |
        Set-ItemProperty -Name CanonicalName -Value '{858B5A19-A5CE-40CE-9FA7-44C4254BA4A0}' -PassThru |
        Set-ItemProperty -Name Description -Value '@shell32.dll,-8507' -PassThru |
        Set-ItemProperty -Name Icon -Value 'imageres.dll,-5323' -PassThru |
        Set-ItemProperty -Name ImpliedSelectionModel -Value 1 -Type DWord -PassThru |
        Set-ItemProperty -Name InvokeCommandOnSelection -Value 1 -Type DWord -PassThru |
        Set-ItemProperty -Name MUIVerb -Value '@shell32.dll,-8506' -PassThru |
        Set-ItemProperty -Name ResolveLinksQueryBehavior -Value 0 -Type DWord -PassThru |
        Set-ItemProperty -Name StaticVerbOnly
}
