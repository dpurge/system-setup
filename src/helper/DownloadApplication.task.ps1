Task DownloadApplication `
    -description "Download all selected applications" `
    -depends `
        CreateWorkDirectory `
{
    foreach ($Application in $Script:Applications) {
        Download-Resource -uri $Application.Install.Uri -output $Application.Install.Media
    }
    $Script:Applications = @()
}