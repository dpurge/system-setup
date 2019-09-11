function Invoke-TestMenu {
    do {
        $choice = $host.ui.PromptForChoice(
            'Test menu',
            'Please choose the test...',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit test menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Base system","Test base system")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting test menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestBaseSystem }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
