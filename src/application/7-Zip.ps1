@{
    Name = '7-Zip'
    Verify = @{
        File = @(
            $SevenZip
        )
    }
    Install = @{
        Uri = 'https://www.7-zip.org/a/7z1900-x64.msi'
        Media = Join-Path -Path $TempDir -ChildPath '7z1900-x64.msi'
        Directory = Join-Path -Path $ProgramDir -ChildPath '7-Zip'
        Script = {
            param($InstallMedia, $Directory)
            Write-Message -Install -Type Info -Message "Installing 7-Zip into: ${Directory}"
            msiexec /i "`"${InstallMedia}`"" INSTALLDIR="`"${Directory}`"" /qb
        }
    }
}