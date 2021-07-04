@{
    Name = 'WindowsTerminal'
    Verify = @{
        Directory = @(
            "$($env:LocalAppData)\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"
        )
    }
    Install = @{
        Uri = 'https://github.com/microsoft/terminal/releases/download/v1.8.1444.0/Microsoft.WindowsTerminal_1.8.1444.0_8wekyb3d8bbwe.msixbundle'
        Media = Join-Path -Path $TempDir -ChildPath 'Microsoft.WindowsTerminal_1.8.1444.0_8wekyb3d8bbwe.msixbundle'
        Directory = "$($env:LocalAppData)\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"
        Script = {
            param($InstallMedia, $Directory)
            Write-Host "NOT IMPLEMENTED"
        }
    }
}