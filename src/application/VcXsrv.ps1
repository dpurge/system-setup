@{
    Name = 'VcXsrv'
    Verify = @{
        Directory = @(
            (Join-Path -Path $ProgramDir -ChildPath 'VcXsrv')
        )
    }
    Install = @{
        Uri = 'https://datapacket.dl.sourceforge.net/project/vcxsrv/vcxsrv/1.20.5.1/vcxsrv-64.1.20.5.1.installer.exe'
        Media = Join-Path -Path $TempDir -ChildPath 'vcxsrv-64.1.20.5.1.installer.exe'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'VcXsrv'
        Script = {
            param($InstallMedia, $Directory)
            Write-Message -Install -Type Info -Message "Running installer: ${InstallMedia}"
            & $InstallMedia
        }
    }
}