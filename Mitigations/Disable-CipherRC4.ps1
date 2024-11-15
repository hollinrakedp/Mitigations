<#
.SYNOPSIS
Disables the RC4 Ciphers on a system.

.LINK
https://docs.microsoft.com/en-us/troubleshoot/windows-server/windows-security/restrict-cryptographic-algorithms-protocols-schannel
#>

$Ciphers = @('RC4 128/128', 'RC4 56/128', 'RC4 40/128')

foreach ($Cipher in $Ciphers) {
    $ItemProperty = @{
        Path         = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\$Cipher"
        Name         = 'Enabled'
        Value        = 0
        PropertyType = 'DWORD'
        Force        = $true
    }
    if (!(Test-Path $ItemProperty['Path'])) {
        New-Item -Path $ItemProperty['Path'] -Force | Out-Null
    }
    New-ItemProperty @ItemProperty | Out-Null
}