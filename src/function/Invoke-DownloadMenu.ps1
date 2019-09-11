function Invoke-DownloadMenu {
    do {
        $choice = $host.ui.PromptForChoice(
            'Download menu',
            'Please choose what to download...',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit install menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Base system tools","Download base system tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Programming tools","Download programming tools")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting install menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadBaseSystemTools }
            2 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task DownloadProgrammingTools }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
