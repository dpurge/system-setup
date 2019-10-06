function Invoke-DownloadMenu {
    do {
        $choice = $host.ui.PromptForChoice(
            'Download menu',
            'Please choose what to download...',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit install menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Basic tools","Download basic tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Programming tools","Download programming tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Document tools","Download document tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Other tools","Download other miscelaneous tools")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting install menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadBasicTools }
            2 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadProgrammingTools }
            3 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadDocumentTools }
            4 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadOtherTools }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
