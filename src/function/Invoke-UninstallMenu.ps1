function Invoke-UninstallMenu {
    do {
        $choice = $host.ui.PromptForChoice(
            'Uninstall menu',
            'Please choose what to uninstall...',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit uninstall menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Base","Uninstall base system")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting uninstall menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task UninstallBaseSystem }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
