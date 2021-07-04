@{
    Name = 'Git'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'Git')
        )
    }
    Install = @{
        Uri = 'https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/Git-2.23.0-64-bit.exe'
        Media = Join-Path -Path $TempDir -ChildPath 'Git-2.23.0-64-bit.exe'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'Git'
        Script = {
            param($InstallMedia, $Directory)
            & $InstallMedia
        }
    }
}