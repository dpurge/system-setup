Task DownloadBaseSystemTools `
    -description "Download installation media for base system tools" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        TempDir `
{
    foreach ($uri in @(
        'https://github.com/Wyse-/ungoogled-chromium-binaries/releases/download/67.0.3396.87-3/ungoogled-chromium_67.0.3396.87-3_windows.zip'
        'https://github.com/Maximus5/ConEmu/releases/download/v19.07.14/ConEmuPack.190714.7z'
        'https://www.farmanager.com/files/Far30b5454.x64.20190823.7z'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Invoke-DownloadResource -uri $uri -output "${TempDir}\${filename}"
    }
}
