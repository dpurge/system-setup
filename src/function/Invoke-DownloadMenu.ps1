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
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Media tools","Download media tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Learning tools","Download learning tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Other tools","Download other miscelaneous tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&All tools","Download everything")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting install menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadBasicTools }
            2 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadProgrammingTools }
            3 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadDocumentTools }
            4 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadMediaTools }
            5 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadLearningTools }
            6 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadOtherTools }
            7 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadEverything }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
