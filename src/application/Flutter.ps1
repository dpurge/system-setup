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