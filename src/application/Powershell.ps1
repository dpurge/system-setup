@{
    Name = 'PowerShell'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'PowerShell')
        )
    }
    Install = @{
        Uri = 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.3/PowerShell-7.0.0-preview.3-win-x64.zip'
        Media = Join-Path -Path $TempDir -ChildPath 'PowerShell-7.0.0-preview.3-win-x64.zip'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'PowerShell'
        Script = {
            param($InstallMedia, $Directory)
            & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
        }
    }
}