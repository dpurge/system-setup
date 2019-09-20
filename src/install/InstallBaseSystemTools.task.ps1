Task InstallBaseSystemTools `
    -description "Install base system tools" `
    -depends `
        DownloadBaseSystemTools, InstallBaseSystem `
    -requiredVariable `
        SystemRootDir, TempDir, SystemDir `
{
    $ProgramDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['pgm']

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath '7z'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "7z directory already exists: ${ApplicationDir}"
    } else {
        $MsiFile = Join-Path -Path $TempDir -ChildPath '7z1900-x64.msi'
        if (-not (Test-Path -Path $MsiFile)) {
            Write-Message -Install -Type Error -Message "Missing 7z installation media: ${MsiFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing 7z into: ${ApplicationDir}"
            Exec {
                msiexec /i "`"${MsiFile}`"" INSTALLDIR="`"${ApplicationDir}`"" /qb
            }
        }
        
    }

    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7z\7z.exe'

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'PowerShell'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "Powershell directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'PowerShell-7.0.0-preview.3-win-x64.zip'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing Powershell installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing Powershell into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ApplicationDir}`""
            }
        }
        
    }

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'Chromium'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "Chromium directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'ungoogled-chromium_67.0.3396.87-3_windows.zip'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing chromium installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing chromium into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ProgramDir}`""
            }
            Rename-Item -Path (Join-Path -Path $ProgramDir -ChildPath 'ungoogled-chromium_67.0.3396.87-3_windows') -NewName $ApplicationDir
        }
        
    }

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'ConEmu'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "ConEmu directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'ConEmuPack.190714.7z'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing ConEmu installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing ConEmu into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ApplicationDir}`""
            }
        }
        
    }

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'Far'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "Far directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'Far30b5454.x64.20190823.7z'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing Far installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing Far into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ApplicationDir}`""
            }
        }
        
    }

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'MuPdf'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "MuPdf directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'mupdf-1.16.0-windows.zip'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing MuPdf installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing MuPdf into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ProgramDir}`""
            }
            Rename-Item -Path (Join-Path -Path $ProgramDir -ChildPath 'mupdf-1.16.0-windows') -NewName $ApplicationDir
        }
        
    }

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'Translit'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "Translit directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'Universal_Transliteration_v1.0.zip'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing Translit installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing Translit into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ProgramDir}`""
            }
        }
        
    }
}