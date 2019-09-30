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
    $choice = $host.ui.PromptForChoice($title, $message, $options, 1)

    return ($choice -eq 0)
}