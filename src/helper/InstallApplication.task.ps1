Task InstallApplication `
    -description "Install all selected applications" `
{
    foreach ($Application in $Script:Applications) {
        Install-Application @Application
    }
    $Script:Applications = @()
}