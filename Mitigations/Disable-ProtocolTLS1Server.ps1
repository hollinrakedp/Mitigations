<#
.SYNOPSIS
Disables the TLS 1.0 Server Protocol on the system

.LINK
https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/manage-ssl-protocols-in-ad-fs
#>

$ItemProperty = @{
    Path         = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server'
    Name         = 'Enabled'
    Value        = 0
    PropertyType = 'DWORD'
    Force        = $true
}
if (!(Test-Path $ItemProperty['Path'])) {
    New-Item -Path $ItemProperty['Path'] -Force | Out-Null
}
New-ItemProperty @ItemProperty | Out-Null

$ItemProperty = @{
    Path         = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server'
    Name         = 'DisabledByDefault'
    Value        = 1
    PropertyType = 'DWORD'
    Force        = $true
}
if (!(Test-Path $ItemProperty['Path'])) {
    New-Item -Path $ItemProperty['Path'] -Force | Out-Null
}
New-ItemProperty @ItemProperty | Out-Null