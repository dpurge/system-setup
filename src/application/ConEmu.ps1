@{
    Name = 'ConEmu'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'ConEmu')
        )
        EnvVar = @{
            ConEmuDir = Join-Path -Path $ProgramDir -ChildPath 'ConEmu'
        }
    }
    Install = @{
        Uri = 'https://github.com/Maximus5/ConEmu/releases/download/v19.07.14/ConEmuPack.190714.7z'
        Media = Join-Path -Path $TempDir -ChildPath 'ConEmuPack.190714.7z'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'ConEmu'
        Script = {
            param($InstallMedia, $Directory)
            & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
            [Environment]::SetEnvironmentVariable('ConEmuDir', $Directory, $SystemScope)
        }
    }
}