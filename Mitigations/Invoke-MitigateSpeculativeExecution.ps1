<#
.SYNOPSIS
Configures Speculative Execution mitigations.

.LINK
https://support.microsoft.com/en-us/help/4072698/windows-server-guidance-to-protect-against-the-speculative-execution
#>

$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'

$Properties = @(
    @{ Name = 'FeatureSettingsOverride'; Value = 72 },
    @{ Name = 'FeatureSettingsOverrideMask'; Value = 3 }
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
