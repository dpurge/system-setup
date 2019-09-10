function Write-Message {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Success', 'Info', 'Error', 'Warning')]
        [string] $Type,

        [Parameter(Mandatory=$true)]
        [string] $Message,

        [switch] $test,
        [switch] $install,
        [switch] $uninstall
    )

    $Color = switch ($Type) {
        'Success' { 'green' }
        'Error' { 'red' }
        'Warning' { 'yellow' }
        'Info' { 'white' }
        default {throw "Invalid message type: ${Type}"}
    }

    $Timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

    $FormattedMessage = "[${Type}]`t${Timestamp}`t${Message}"

    Write-Host $FormattedMessage -ForegroundColor $Color

    if ( $test ) { Add-Content -Path (Join-Path -Path $LogDir -ChildPath 'test.log') -Value $FormattedMessage }
    if ( $install ) { Add-Content -Path (Join-Path -Path $LogDir -ChildPath 'install.log') -Value $FormattedMessage }
    if ( $uninstall ) { Add-Content -Path (Join-Path -Path $LogDir -ChildPath 'uninstall.log') -Value $FormattedMessage }

    if ($Type -eq 'Error') {throw $FormattedMessage}
    
}