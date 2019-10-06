function Invoke-InstallMenu {
    do {
        $choice = $host.ui.PromptForChoice(
            'Install menu',
            'Please choose what to install...',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit install menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&System","Install base system")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Basic tools","Install basic tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Programming tools","Install programming tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Document tools","Install document tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Other tools","Install other tools")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting install menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallSystem }
            2 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallBasicTools }
            3 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallProgrammingTools }
            4 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallDocumentTools }
            5 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task InstallOtherTools }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
