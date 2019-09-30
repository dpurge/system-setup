Task InstallOtherTools `
    -description "Install other tools" `
    -depends `
        DownloadOtherTools, InstallBaseSystemTools `
    -requiredVariable `
        SystemRootDir, TempDir, SystemDir `
{
    $BinDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['bin']
    $ProgramDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['pgm']
    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7z\7z.exe'

    # ================================================================

    $Application = @{
        Name = 'YouTube-Dl'
        Executable = Join-Path -Path $BinDir -ChildPath 'youtube-dl.exe'
        InstallMedia = Join-Path -Path $TempDir -ChildPath 'youtube-dl.exe'
    }
    if (Test-Path -Path $Application.Executable -PathType Leaf) {
        Write-Message -Install -Type Info -Message "$($Application.Name) executable file already exists: $($Application.Executable)"
    } else {
        if (-not (Test-Path -Path $Application.InstallMedia -PathType Leaf)) {
            Write-Message -Install -Type Error -Message "Missing $($Application.Name) installation media: $($Application.InstallMedia)"
        } else {
            if (Invoke-YesNoQuestion -title "Installation of $($Application.Name)" -message "Do you want to copy this tool? : $($Application.InstallMedia)") {
                Write-Message -Install -Type Info -Message "Installing $($Application.Name) into: $($Application.Executable)"
                Copy-Item -Path $Application.InstallMedia -Destination $Application.Executable
            }
        }
    }

    # ================================================================

}