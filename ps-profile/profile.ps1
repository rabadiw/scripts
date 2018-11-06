function prompt {
  "$pwd`nPS>"
}

# Starts Powershell in a new Windows
function New-Powershell {
  [CmdletBinding(SupportsShouldProcess=$true)]
  param(
    # Working directory sets the path to the specified value
    [Parameter(Position = 0, Mandatory = $false)]
    [String]$WorkingDirectory
  )
  
  if (!$WorkingDirectory) {
    $WorkingDirectory = "."
  }

  if($PSCmdlet.ShouldProcess("New-Powershell -WorkingDirectory $WorkingDirectory")){
    Start-Process Powershell.exe -WorkingDirectory $WorkingDirectory
  }
}
Set-Alias -Name nps -Value New-Powershell
