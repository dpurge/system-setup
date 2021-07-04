Task TestApplication `
    -description "Test all selected applications" `
    -depends `
        CreateWorkDirectory `
{
    foreach ($Application in $Script:Applications) {
        $TestParams = @{}
        foreach ($Key in $Application.Verify.Keys) {
            $TestParams.Add($Key, $Application.Verify.Item($Key))
        }
        if (Verify-Resource -Application $Application.Name @TestParams) {
            Write-Message -Test -Type Success -Message "Application installed successfully: $($Application.Name)"
        } else {
            Write-Message -Test -Type Error -Message "Application not installed: $($Application.Name)"
        }
    }
    $Script:Applications = @()
}