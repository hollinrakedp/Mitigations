<#
.SYNOPSIS
Configures Speculative Execution mitigations.

.LINK
https://support.microsoft.com/en-us/help/4072698/windows-server-guidance-to-protect-against-the-speculative-execution
#>

$ItemProperty = @{
    Path         = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
    Name         = 'FeatureSettingsOverride'
    Value        = 72
    PropertyType = 'DWORD'
    Force        = $true
}
if (!(Test-Path $ItemProperty['Path'])) {
    New-Item -Path $ItemProperty['Path'] -Force | Out-Null
}
New-ItemProperty @ItemProperty | Out-Null

$ItemProperty = @{
    Path         = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
    Name         = 'FeatureSettingsOverrideMask'
    Value        = 3
    PropertyType = 'DWORD'
    Force        = $true
}
if (!(Test-Path $ItemProperty['Path'])) {
    New-Item -Path $ItemProperty['Path'] -Force | Out-Null
}
New-ItemProperty @ItemProperty | Out-Null
