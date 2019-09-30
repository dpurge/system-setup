Task DownloadBaseSystemTools `
    -description "Download installation media for base system tools" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        TempDir `
{
    foreach ($uri in @(
        'https://www.7-zip.org/a/7z1900-x64.msi'
        'https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.3/PowerShell-7.0.0-preview.3-win-x64.zip'
        'https://github.com/Wyse-/ungoogled-chromium-binaries/releases/download/67.0.3396.87-3/ungoogled-chromium_67.0.3396.87-3_windows.zip'
        'https://github.com/Maximus5/ConEmu/releases/download/v19.07.14/ConEmuPack.190714.7z'
        'https://www.farmanager.com/files/Far30b5454.x64.20190823.7z'
        'https://datapacket.dl.sourceforge.net/project/vcxsrv/vcxsrv/1.20.5.1/vcxsrv-64.1.20.5.1.installer.exe'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Invoke-DownloadResource -uri $uri -output "${TempDir}\${filename}"
    }
}
