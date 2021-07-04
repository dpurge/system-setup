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