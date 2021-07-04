@{
    Name = 'VSCode'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'VSCode')
        )
    }
    Install = @{
        Uri = 'https://az764295.vo.msecnd.net/stable/b37e54c98e1a74ba89e03073e5a3761284e3ffb0/VSCodeSetup-x64-1.38.1.exe'
        Media = Join-Path -Path $TempDir -ChildPath 'VSCodeSetup-x64-1.38.1.exe'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'VSCode'
        Script = {
            param($InstallMedia, $Directory)
            & $InstallMedia
        }
    }
}