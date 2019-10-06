Task InstallOtherTools `
    -description "Install other tools" `
    -depends `
        InstallBaseSystemTools `
    -requiredVariable `
        SystemRootDir, TempDir, SystemDir `
{
    $BinDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['bin']
    $ProgramDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['pgm']
    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7z\7z.exe'

    # ================================================================

    $Applications = @(

        @{
            Name = 'PuTTy'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'PuTTy')
                )
            }
            Install = @{
                Uri = 'https://the.earth.li/~sgtatham/putty/0.73/w64/putty.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'putty-0.73-x64.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'PuTTy'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
                }
            }
        }

        # ----------

        @{
            Name = 'YouTube-Dl'
            Verify = @{
                File = @(
                    (Join-Path -Path $BinDir -ChildPath 'youtube-dl.exe')
                )
            }
            Install = @{
                Uri = 'https://youtube-dl.org/downloads/latest/youtube-dl.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'youtube-dl.exe'
                Directory = $BinDir
                Script = {
                    param($InstallMedia, $Directory)
                    Copy-Item -Path $InstallMedia -Destination $Directory
                }
            }
        }

    )

    # ================================================================

    foreach ($Application in $Applications) {
        Install-Application @Application
    }

}