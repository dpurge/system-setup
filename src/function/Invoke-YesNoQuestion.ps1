function Invoke-YesNoQuestion {
    param (
        [Parameter(Mandatory=$true)]
        [string] $title,

        [Parameter(Mandatory=$true)]
        [string] $message
    )

    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Confirm that this action should be executed"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Skip this action"

    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

    do {
        $choice = $host.ui.PromptForChoice($title, $message, $options, 1)
        switch ($choice) {
            0 { Write-Host 'Operation confirmed...' }
            1 { Write-Host 'Operation skipped...' }
            default { Write-Host "Please choose 'yes' or 'no'. Unsupported choice: ${choice}"}
        }
    } until ($choice -eq 0 -or $choice -eq 1)

    return ($choice -eq 0)
}