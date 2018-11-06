# PS-PROFILE
A profile script for your Powershell shell terminal with helpful methods to start up your powershell profile. 

## Prerequisites
Create a code signing cert (local)

```powershell 
PS>New-SelfSignedCertificate -CertStoreLocation cert:\currentuser\my `
-Subject "CN=Dev Code Signing" `
-KeyAlgorithm RSA `
-KeyLength 2048 `
-Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
-KeyExportPolicy Exportable `
-KeyUsage DigitalSignature `
-Type CodeSigningCert

# Export cert
PS>Export-Certificate -Cert @(Get-ChildItem Cert:\CurrentUser\My\[replace with cert id])[0] -FilePath
path\to\dev_code_signing.cer

# Add to TrustedPublisher
PS>Get-ChildItem -Path path\to\dev_code_signing.cer | Import-Certificate -CertStoreLocation Cert:\Current
User\TrustedPublisher\

# Add to Root
PS>Get-ChildItem -Path path\to\dev_code_signing.cer | Import-Certificate -CertStoreLocation Cert:\Current
User\Root\
```

## Create/modify profile:
From a command prompt, load the profile script into your favorite text/code editor. e.g. [visual studio code](https://code.visualstudio.com/)

```powershell
PS>code $profile
# Copy the contents of the [profile.ps1](./profile.ps1) file and paste it into your open editor.
# sign the script
PS>Set-AuthenticodeSignature ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 @(Get-ChildItem Cert:\Curre
ntUser\My\[replace with cert id])[0]
```

Save the changes, close and reopen your powershell window. If you copied the file as is:
1. your prompt would have changed 
2. added a new cmdlet `New-Powershell` or it's alias `nps`
