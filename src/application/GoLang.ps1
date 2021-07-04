@{
    Name = 'GoLang'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'Go')
        )
    }
    Install = @{
        Uri = 'https://dl.google.com/go/go1.13.windows-amd64.zip'
        Media = Join-Path -Path $TempDir -ChildPath 'go1.13.windows-amd64.zip'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'Go'
        Script = {
            param($InstallMedia, $Directory)
            & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
        }
    }
}