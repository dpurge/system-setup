function Invoke-YesNoQuestion {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Title,

        [Parameter(Mandatory=$true)]
        [string] $Message
    )

    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Confirm that this action should be executed"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Skip this action"

    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $choice = $host.ui.PromptForChoice($Title, $Message, $options, 1)

    return ($choice -eq 0)
}