Task GetProgrammingTools `
    -description "Install application development tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip `
{

    # Changing global state variable

    $Script:Applications += @(

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

        # ----------

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
            Name = 'AndroidStudio'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'android-studio')
                    (Join-Path -Path $ProgramDir -ChildPath 'android')
                )
                Path = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'android-studio\jre\bin')
                    (Join-Path -Path $ProgramDir -ChildPath 'android\emulator')
                    (Join-Path -Path $ProgramDir -ChildPath 'android\tools')
                    (Join-Path -Path $ProgramDir -ChildPath 'android\platform-tools')
                    (Join-Path -Path $ProgramDir -ChildPath 'android\tools\bin')
                )
            }
            Install = @{
                Uri = 'https://dl.google.com/dl/android/studio/ide-zips/3.5.0.21/android-studio-ide-191.5791312-windows.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'android-studio-ide-191.5791312-windows.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'android-studio'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                    $AndroidDirectory = "${Directory}\..\android"
                    New-Item -ItemType Directory -Force -Path $AndroidDirectory
                    $AndroidDirectory = (Resolve-Path $AndroidDirectory).Path
                    [Environment]::SetEnvironmentVariable('JAVA_HOME', "${Directory}\jre", $SystemScope)
                    [Environment]::SetEnvironmentVariable('ANDROID_HOME', $AndroidDirectory, $SystemScope)
                    $PathItems = @(
                        '%JAVA_HOME%\bin'
                        '%ANDROID_HOME%\emulator'
                        '%ANDROID_HOME%\tools'
                        '%ANDROID_HOME%\platform-tools'
                        '%ANDROID_HOME%\tools\bin')
                    New-PathItem -PathItem $PathItems
                }
            }
        }

        # ----------

        @{
            Name = 'DartSDK'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'dart-sdk')
                )
                Path = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'dart-sdk\bin')
                )
            }
            Install = @{
                Uri = 'https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.1.0/sdk/dartsdk-windows-x64-release.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'dartsdk-windows-x64-release.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'dart-sdk'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                    New-PathItem -PathItem @("${Directory}\bin")
                }
            }
        }

        # ----------

        @{
            Name = 'Flutter'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'flutter')
                )
                Path = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'flutter\bin')
                )
            }
            Install = @{
                Uri = 'https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_v1.9.1+hotfix.2-stable.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'flutter_windows_v1.9.1+hotfix.2-stable.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'dart-sdk'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                    New-PathItem -PathItem @("${Directory}\bin")
                }
            }
        }

        # ----------

        <#
        'https://www.python.org/ftp/python/3.7.4/python-3.7.4-amd64.exe'
        'https://nodejs.org/dist/v12.10.0/node-v12.10.0-x64.msi'
        'https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_windows-x64_bin.zip'
        #>

    )
}