Task DownloadProgrammingTools `
    -description "Download installation media for programming" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        TempDir `
{
    foreach ($uri in @(
        'https://az764295.vo.msecnd.net/stable/b37e54c98e1a74ba89e03073e5a3761284e3ffb0/VSCodeSetup-x64-1.38.1.exe'
        'https://www.python.org/ftp/python/3.7.4/python-3.7.4-amd64.exe'
        'https://nodejs.org/dist/v12.10.0/node-v12.10.0-x64.msi'
        'https://dl.google.com/go/go1.13.windows-amd64.zip'
        'https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_windows-x64_bin.zip'
        'https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip'
        'https://dl.google.com/android/repository/android-ndk-r20-windows-x86_64.zip'
        'https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.1.0/sdk/dartsdk-windows-x64-release.zip'
        'https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_v1.9.1+hotfix.2-stable.zip'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Invoke-DownloadResource -uri $uri -output "${TempDir}\${filename}"
    }
}
