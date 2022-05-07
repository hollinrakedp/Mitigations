<#
.SYNOPSIS
Disables TripleDES Cipher on the system

.LINK
https://docs.microsoft.com/en-us/troubleshoot/windows-server/windows-security/restrict-cryptographic-algorithms-protocols-schannel
#>

$ItemProperty =@{
    Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168'
    Name = 'Enabled'
    Value = 0
    PropertyType = 'DWORD'
    Force = $true
}
if (!(Test-Path $ItemProperty['Path'])) {
    New-Item -Path $ItemProperty['Path'] -Force | Out-Null
}
New-ItemProperty @ItemProperty | Out-Null