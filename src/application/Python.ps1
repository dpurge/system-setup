@{
    Name = 'Python'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'Python')
        )
    }
    Install = @{
        Uri = 'https://www.python.org/ftp/python/3.7.4/python-3.7.4-amd64.exe'
        Media = Join-Path -Path $TempDir -ChildPath 'python-3.7.4-amd64.exe'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'Python'
        Script = {
            param($InstallMedia, $Directory)
            & $InstallMedia
        }
    }
}