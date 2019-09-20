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
        #'https://www.fosshub.com/Universal-Character-Transliteration-Utility.html?dwl=Universal_Transliteration_v1.0.zip'
        'https://download.fosshub.com/Protected/expiretime=1568294294;badurl=aHR0cHM6Ly93d3cuZm9zc2h1Yi5jb20vVW5pdmVyc2FsLUNoYXJhY3Rlci1UcmFuc2xpdGVyYXRpb24tVXRpbGl0eS5odG1s/68d631f2c893debaaeb173734af39e8105ac70c34b255f7fcb0b741a8687f646/5becae1b4f6487156b10a6f4/5bee4147cb8bb415b5028144/Universal_Transliteration_v1.0.zip'
        'https://www.mupdf.com/downloads/archive/mupdf-1.16.0-windows.zip'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Invoke-DownloadResource -uri $uri -output "${TempDir}\${filename}"
    }
}
