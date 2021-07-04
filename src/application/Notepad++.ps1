@{
    Name = 'Notepad++'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'Notepad++')
        )
    }
    Install = @{
        Uri = 'http://download.notepad-plus-plus.org/repository/8.x/8.1/npp.8.1.Installer.x64.exe'
        Media = Join-Path -Path $TempDir -ChildPath 'npp.8.1.Installer.x64.exe'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'Notepad++'
        Script = {
            param($InstallMedia, $Directory)
            Write-Message -Install -Type Info -Message "Running installer: ${InstallMedia}"
            & $InstallMedia
        }
    }
}