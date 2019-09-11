Task DownloadProgrammingTools `
    -description "Download installation media for programming" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        TempDir `
{
    foreach ($uri in @(
        'https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.3/PowerShell-7.0.0-preview.3-win-x64.zip'
        'https://www.python.org/ftp/python/3.7.4/python-3.7.4-amd64.exe'
        'https://nodejs.org/dist/v12.10.0/node-v12.10.0-x64.msi'
        'https://dl.google.com/go/go1.13.windows-amd64.zip'
        'https://az764295.vo.msecnd.net/stable/b37e54c98e1a74ba89e03073e5a3761284e3ffb0/VSCodeSetup-x64-1.38.1.exe'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Invoke-DownloadResource -uri $uri -output "${TempDir}\${filename}"
    }
}
