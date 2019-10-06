function Install-Application {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Name,

        [Parameter(Mandatory=$true)]
        $Verify,

        [Parameter(Mandatory=$true)]
        $install
    )

    if (-not (Verify-Resource -Application $Name @Verify)) {
        if (Invoke-YesNoQuestion `
            -title "Installation of ${Name}" `
            -message "Do you want to install ${Name}?")
        {
            Download-Resource -uri $Install.Uri -output $Install.Media
            Write-Message -Install -Type Info -Message "Installing application: ${Name}"
            Exec { & $Install.Script -InstallMedia $Install.Media -Directory $Install.Directory }
            <#
            if (Verify-Resource -Application $Name @Verify) {
                Write-Message -Install -Type Success -Message "Application installed successfully: ${Name}"
            } else {
                Write-Message -Install -Type Error -Message "Failed to install application: ${Name}"
            }
            #>
        }
    }
}