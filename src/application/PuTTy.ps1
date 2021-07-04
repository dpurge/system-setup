@{
    Name = 'PuTTy'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'PuTTy')
        )
    }
    Install = @{
        Uri = 'https://the.earth.li/~sgtatham/putty/0.73/w64/putty.zip'
        Media = Join-Path -Path $TempDir -ChildPath 'putty-0.73-w64.zip'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'PuTTy'
        Script = {
            param($InstallMedia, $Directory)
            & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
        }
    }
}