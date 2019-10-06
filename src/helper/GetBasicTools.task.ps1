Task GetBasicTools `
    -description "Install base system tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip, SystemScope `
{

    # Changing global state variable

    $Script:Applications += @(

        @{
            Name = 'SevenZip'
            Verify = @{
                File = @(
                    $SevenZip
                )
            }
            Install = @{
                Uri = 'https://www.7-zip.org/a/7z1900-x64.msi'
                Media = Join-Path -Path $TempDir -ChildPath '7z1900-x64.msi'
                Directory = Join-Path -Path $ProgramDir -ChildPath '7z'
                Script = {
                    param($InstallMedia, $Directory)
                    Write-Message -Install -Type Info -Message "Installing 7z into: ${Directory}"
                    msiexec /i "`"${InstallMedia}`"" INSTALLDIR="`"${Directory}`"" /qb
                }
            }
        }

        # ----------

        @{
            Name = 'PowerShell'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'PowerShell')
                )
            }
            Install = @{
                Uri = 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.3/PowerShell-7.0.0-preview.3-win-x64.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'PowerShell-7.0.0-preview.3-win-x64.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'PowerShell'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
                }
            }
        }

        # ----------

        @{
            Name = 'Chromium'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'Chromium')
                )
                EnvVar = @{
                    CHROME_EXECUTABLE = Join-Path -Path $ProgramDir -ChildPath 'Chromium\chrome.exe'
                }
            }
            Install = @{
                Uri = 'https://github.com/Wyse-/ungoogled-chromium-binaries/releases/download/67.0.3396.87-3/ungoogled-chromium_67.0.3396.87-3_windows.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'ungoogled-chromium_67.0.3396.87-3_windows.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'Chromium'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                    Rename-Item -Path (Join-Path -Path "`"${Directory}\..`"" -ChildPath 'ungoogled-chromium_67.0.3396.87-3_windows') -NewName $Directory
                    [Environment]::SetEnvironmentVariable('CHROME_EXECUTABLE', "${Directory}\chrome.exe", $SystemScope)
                }
            }
        }

        # ----------

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

        # ----------

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

        # ----------

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

        # ----------

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

    )
}