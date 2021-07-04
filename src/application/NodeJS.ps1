@{
    Name = 'NodeJS'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'NodeJS')
        )
    }
    Install = @{
        Uri = 'https://nodejs.org/dist/v12.10.0/node-v12.10.0-x64.msi'
        Media = Join-Path -Path $TempDir -ChildPath 'node-v12.10.0-x64.msi'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'NodeJS'
        Script = {
            param($InstallMedia, $Directory)
            Write-Message -Install -Type Info -Message "Installing NodeJS into: ${Directory}"
            msiexec /i "`"${InstallMedia}`"" INSTALLDIR="`"${Directory}`"" /qb
        }
    }
}