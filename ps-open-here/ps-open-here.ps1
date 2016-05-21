#
# The following code will create an 'Open Here' menu 
# containing sub menu entries for: 
#     cmd, cmd(Admin), powershell, powershell(Admin)
#

'directory', 'directory\background', 'drive' | %{ 
    New-Item -Path "Registry::HKEY_CLASSES_ROOT\$_\shell" -Name openhere -Force |
    Set-ItemProperty -Name MUIVerb -Value 'Open Here' -PassThru |
    Set-ItemProperty -Name SubCommands -Value 'Windows.cmd;Windows.cmdPromptAsAdministrator;Windows.Powershell;Windows.PowershellAsAdmin' -PassThru | 
    Set-ItemProperty -Name Extended -Value ''
}
