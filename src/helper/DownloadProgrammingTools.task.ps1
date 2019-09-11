Task DownloadProgrammingTools `
    -description "Download installation media for programming" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        TempDir `
{
    foreach ($uri in @(
        'powershell'
        'python'
        'nodejs'
        'msys'
        'golang'
        'vscode'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Invoke-DownloadResource -uri $uri -output "${TempDir}\${filename}"
    }
}
