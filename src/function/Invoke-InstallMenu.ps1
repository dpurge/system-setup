function Invoke-InstallMenu {
    do {
        $choice = $host.ui.PromptForChoice(
            'Install menu',
            'Please choose what to install...',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit install menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Base system","Install base system")
                (New-Object System.Management.Automation.Host.ChoiceDescription "Base system &tools","Install base system tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Programming tools","Install programming tools")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting install menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallBaseSystem }
            2 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallBaseSystemTools }
            3 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallProgrammingTools }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
