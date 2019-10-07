function Invoke-TestMenu {
    do {
        $choice = $host.ui.PromptForChoice(
            'Test menu',
            'Please choose the test...',
            @(
                (New-Object System.Management.Automation.Host.ChoiceDescription "E&xit","Exit test menu")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&System","Test system")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Basic tools","Test basic tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Programming tools","Test programming tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Document tools","Test document tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Media tools","Test media tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Learning tools","Test learning tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&Other tools","Test other miscelaneous tools")
                (New-Object System.Management.Automation.Host.ChoiceDescription "&All tools","Test everything")
            ),
            0)
        
        switch ($choice) {
            0 { Write-Host 'Exitting test menu...' }
            1 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestSystem }
            2 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestBasicTools }
            3 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestProgrammingTools }
            4 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestDocumentTools }
            5 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestMediaTools }
            6 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestLearningTools }
            7 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestOtherTools }
            8 { Invoke-PSake "$($psake.build_script_dir)\build.psake.ps1" -Task TestEverything }
            default { throw "Unsupported menu choice: ${choice}"}
        }

    } until ($choice -eq 0)
}
