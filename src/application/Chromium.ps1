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
        Uri = 'https://github.com/tangalbert919/ungoogled-chromium-binaries/releases/download/89.0.4389.114-1/ungoogled-chromium_89.0.4389.114-1.1_windows-x64.zip'
        Media = Join-Path -Path $TempDir -ChildPath 'ungoogled-chromium_89.0.4389.114-1.1_windows-x64.zip'
        Directory = Join-Path -Path $ProgramDir -ChildPath 'Chromium'
        Script = {
            param($InstallMedia, $Directory)
            & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
            Rename-Item -Path (Join-Path -Path "${Directory}\.." -ChildPath 'ungoogled-chromium_89.0.4389.114-1.1_windows') -NewName $Directory
            [Environment]::SetEnvironmentVariable('CHROME_EXECUTABLE', "${Directory}\chrome.exe", $SystemScope)
        }
    }
}