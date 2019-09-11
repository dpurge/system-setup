function Invoke-MainMenu {
    # Clear-Host

    do {
        $choice = $host.ui.PromptForChoice(
            'Main menu',
            'Please choose the operation to execute',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit main menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Test","Test current system")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Install","Install new applications")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Uninstall","Remove some applications")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Download","Download installation files")
            ),
            0)
        try {
            switch ($choice) {
                0 { Write-Host 'Exitting main menu...' }
                1 { Invoke-TestMenu }
                2 { Invoke-InstallMenu }
                3 { Invoke-UninstallMenu }
                4 { Invoke-DownloadMenu }
                default { throw "Unsupported menu choice: ${choice}"}
            }
        }
        catch {
            Write-Message -Menu -Type Error -Message $_.Message
        }

    } until ($choice -eq 0)
}