Task DownloadOtherTools `
    -description "Download other miscelaneous tools" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        TempDir `
{
    foreach ($uri in @(
        'https://youtube-dl.org/downloads/latest/youtube-dl.exe'
        #'https://www.fosshub.com/Universal-Character-Transliteration-Utility.html?dwl=Universal_Transliteration_v1.0.zip'
        'https://download.fosshub.com/Protected/expiretime=1568294294;badurl=aHR0cHM6Ly93d3cuZm9zc2h1Yi5jb20vVW5pdmVyc2FsLUNoYXJhY3Rlci1UcmFuc2xpdGVyYXRpb24tVXRpbGl0eS5odG1s/68d631f2c893debaaeb173734af39e8105ac70c34b255f7fcb0b741a8687f646/5becae1b4f6487156b10a6f4/5bee4147cb8bb415b5028144/Universal_Transliteration_v1.0.zip'
        'https://statics.teams.microsoft.com/production-windows-x64/1.2.00.24753/Teams_windows_x64.exe'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Download-Resource -uri $uri -output "${TempDir}\${filename}"
    }
}
