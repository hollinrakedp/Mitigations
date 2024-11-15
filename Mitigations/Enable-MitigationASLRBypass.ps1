function Enable-MitigationASLRBypass {
    # MS15-124
    # https://docs.microsoft.com/en-us/security-updates/SecurityBulletins/2015/ms15-124#internet-explorer-aslr-bypass--cve-2015-6161--

    $Paths = @(
        'HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ALLOW_USER32_EXCEPTION_HANDLER_HARDENING'
    )

    if ($(Get-CimInstance Win32_OperatingSystem).OSArchitecture -eq '64-bit') {
        $Paths += 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ALLOW_USER32_EXCEPTION_HANDLER_HARDENING'
    }

    $Properties = @(
        @{ Name = 'iexplorer.exe'; Value = 1 }
    )

    foreach ($Path in $Paths) {
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
    }
}