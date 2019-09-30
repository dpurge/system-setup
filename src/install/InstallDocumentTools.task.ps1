Task InstallDocumentTools `
    -description "Install document tools" `
    -depends `
        DownloadDocumentTools, InstallBaseSystemTools `
    -requiredVariable `
        SystemRootDir, TempDir, SystemDir `
{
    $BinDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['bin']
    $ProgramDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['pgm']
    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7z\7z.exe'

    $UninstallRegKey32 = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    $UninstallRegKey64 = "HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

    # ================================================================

    $Application = @{
        Name = 'SumatraPdf'
        Executable = Join-Path -Path $BinDir -ChildPath 'SumatraPDF.exe'
        InstallMedia = Join-Path -Path $TempDir -ChildPath 'SumatraPDF-3.1.2-64.zip'
    }

    if (Test-Path -Path $Application.Executable -PathType Leaf) {
        Write-Message -Install -Type Info -Message "$($Application.Name) executable file already exists: $($Application.Executable)"
    } else {
        if (-not (Test-Path -Path $Application.InstallMedia -PathType Leaf)) {
            Write-Message -Install -Type Error -Message "Missing $($Application.Name) installation media: $($Application.InstallMedia)"
        } else {
            Write-Message -Install -Type Info -Message "Installing $($Application.Name) into: $($Application.Executable)"
            Exec {
                & $SevenZip x "`"$($Application.InstallMedia)`"" -o"`"${BinDir}`""
            }
        }
    }

    # ================================================================

    $Application = @{
        Name = 'WinDjView'
        UninstallRegKey = Join-Path -Path $UninstallRegKey32 -ChildPath 'WinDjView'
        InstallMedia = Join-Path -Path $TempDir -ChildPath 'WinDjView-2.1-Setup.exe'
    }

    if (Test-Path -Path $Application.UninstallRegKey -PathType Container) {
        Write-Message -Install -Type Info -Message "$($Application.Name) already installed: $((Get-ItemProperty $Application.UninstallRegKey).InstallLocation)"
    } else {
        if (-not (Test-Path -Path $Application.InstallMedia -PathType Leaf)) {
            Write-Message -Install -Type Error -Message "Missing $($Application.Name) installation media: $($Application.InstallMedia)"
        } else {
            if (Invoke-YesNoQuestion -title "Installation of $($Application.Name)" -message "Do you want to run this installer? : $($Application.InstallMedia)") {
                Write-Message -Install -Type Info -Message "Installing $($Application.Name) with: $($Application.InstallMedia)"
                Exec {
                    & $Application.InstallMedia
                }
            }
        }
    }

    # ================================================================

    $Application = @{
        Name = 'DjVuLibre'
        UninstallRegKey = Join-Path -Path $UninstallRegKey64 -ChildPath 'DjVuLibre+DjView'
        InstallMedia = Join-Path -Path $TempDir -ChildPath 'DjVuLibre-3.5.27_DjView-4.11_Setup.exe'
    }

    if (Test-Path -Path $Application.UninstallRegKey -PathType Container) {
        Write-Message -Install -Type Info -Message "$($Application.Name) already installed: $(Split-Path -Path (Get-ItemProperty $Application.UninstallRegKey).UninstallString)"
    } else {
        if (-not (Test-Path -Path $Application.InstallMedia -PathType Leaf)) {
            Write-Message -Install -Type Error -Message "Missing $($Application.Name) installation media: $($Application.InstallMedia)"
        } else {
            if (Invoke-YesNoQuestion -title "Installation of $($Application.Name)" -message "Do you want to run this installer? : $($Application.InstallMedia)") {
                Write-Message -Install -Type Info -Message "Installing $($Application.Name) with: $($Application.InstallMedia)"
                Exec {
                    & $Application.InstallMedia
                }
            }
        }
    }

    # ================================================================

    $Application = @{
        Name = 'InkScape'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'inkscape'
        InstallMedia = Join-Path -Path $TempDir -ChildPath 'inkscape-0.92.4-x64.7z'
    }

    if (Test-Path -Path $Application.Directory -PathType Container) {
        Write-Message -Install -Type Info -Message "$($Application.Name) directory already exists: $($Application.Directory)"
    } else {
        if (-not (Test-Path -Path $Application.InstallMedia -PathType Leaf)) {
            Write-Message -Install -Type Error -Message "Missing $($Application.Name) installation media: $($Application.InstallMedia)"
        } else {
            Write-Message -Install -Type Info -Message "Installing $($Application.Name) into: $($Application.Directory)"
            Exec {
                & $SevenZip x "`"$($Application.InstallMedia)`"" -o"`"${ProgramDir}`""
            }
        }
    }

    # ================================================================

    $Application = @{
        Name = 'Emacs'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'emacs'
        InstallMedia = Join-Path -Path $TempDir -ChildPath 'emacs-26.3-x86_64.zip'
    }

    if (Test-Path -Path $Application.Directory -PathType Container) {
        Write-Message -Install -Type Info -Message "$($Application.Name) directory already exists: $($Application.Directory)"
    } else {
        if (-not (Test-Path -Path $Application.InstallMedia -PathType Leaf)) {
            Write-Message -Install -Type Error -Message "Missing $($Application.Name) installation media: $($Application.InstallMedia)"
        } else {
            Write-Message -Install -Type Info -Message "Installing $($Application.Name) into: $($Application.Directory)"
            Exec {
                & $SevenZip x "`"$($Application.InstallMedia)`"" -o"`"$($Application.Directory)`""
            }
        }
    }

    # ================================================================

}