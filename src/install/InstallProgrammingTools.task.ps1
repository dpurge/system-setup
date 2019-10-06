Task InstallProgrammingTools `
    -description "Install programming tools" `
    -depends `
        InstallBaseSystemTools `
    -requiredVariable `
        SystemRootDir, TempDir, SystemDir `
{
    $ProgramDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['pgm']
    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7z\7z.exe'

    # ================================================================

    $Applications = @(

        @{
            Name = 'GoLang'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'Go')
                )
            }
            Install = @{
                Uri = 'https://dl.google.com/go/go1.13.windows-amd64.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'go1.13.windows-amd64.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'Go'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                }
            }
        }

        # ----------

        @{
            Name = 'VSCode'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'VSCode')
                )
            }
            Install = @{
                Uri = 'https://az764295.vo.msecnd.net/stable/b37e54c98e1a74ba89e03073e5a3761284e3ffb0/VSCodeSetup-x64-1.38.1.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'VSCodeSetup-x64-1.38.1.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'VSCode'
                Script = {
                    param($InstallMedia, $Directory)
                    & $InstallMedia
                }
            }
        }

    )

    # ================================================================

    foreach ($Application in $Applications) {
        Install-Application @Application
    }

}