function New-PathItem {
    param (
        [Parameter(Mandatory=$true)]
        [string[]] $PathItem
    )

    $SystemPathVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemScope)
    $SystemPathItems = $SystemPathVar.split(';')

    foreach ($item in $PathItem) {
        if ($SystemPathItems -notcontains $item) {
            $SystemPathItems += $item
        }
    }

    $NewPathVar = $SystemPathItems -join ';'
    if ($NewPathVar -ne $SystemPathVar) {
        Write-Message -Install -Type Info -Message "Setting 'JDP_SYSTEM_PATH': ${NewPathVar}"
        [Environment]::SetEnvironmentVariable('JDP_SYSTEM_PATH', $NewPathVar, $SystemScope)
    }
}
