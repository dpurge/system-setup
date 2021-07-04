@{
    Name = 'Far'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'Far')
        )
        EnvVar = @{
            FarHome = Join-Path -Path $ProgramDir -ChildPath 'Far'
        }
    }
    Install = @{
        Uri = 'https://www.farmanager.com/files/Far30b5454.x64.20190823.7z'
        Media = Join-Path -Path $TempDir -ChildPath 'Far30b5454.x64.20190823.7z'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'Far'
        Script = {
            param($InstallMedia, $Directory)
            & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
            [Environment]::SetEnvironmentVariable('FarHome', $Directory, $SystemScope)
        }
    }
}