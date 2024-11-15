<#
.SYNOPSIS
Disables the TLS 1.0 Client Protocol on the system

.LINK
https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/manage-ssl-protocols-in-ad-fs
#>

$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client'

$Properties = @(
    @{ Name = 'Enabled'; Value = 0 },
    @{ Name = 'DisabledByDefault'; Value = 1 }
)

foreach ($Property in $Properties) {
    $ItemProperty = @{
        Path         = $Path
        Name         = $Property.Name
        Value        = $Property.Value
        PropertyType = 'DWORD'
        Force        = $true
    }
    if (!(Test-Path $ItemProperty['Path'])) {
        New-Item -Path $ItemProperty['Path'] -Force | Out-Null
    }
    New-ItemProperty @ItemProperty | Out-Null
}