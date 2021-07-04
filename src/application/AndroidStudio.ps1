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