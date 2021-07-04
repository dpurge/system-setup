Task TestSystem `
    -description "Test base system" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        SystemRoot, DocumentRoot, SystemScope, SystemDir `
{
    $SystemRootVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_ROOT', $SystemScope)
    $SystemPathVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemScope)

    $OK = $true

    if (-not $SystemRootVar) {
        Write-Message -Test -Type Error -Message "${SystemScope} environment variable JDP_SYSTEM_ROOT is not defined!"
        $OK = $false
    } else {
        Write-Message -Test -Type Info -Message "${SystemScope} environment variable JDP_SYSTEM_ROOT is defined: ${SystemRootVar}"
    }

    if (-not (Test-Path -Path $SystemRootVar -PathType Container)) {
        Write-Message -Test -Type Error -Message "System root directory does not exist: ${SystemRootVar}"
        $OK = $false
    } else {
        Write-Message -Test -Type Info -Message "System root directory exists: ${SystemRootVar}"
    }

    if (-not $SystemPathVar) {
        Write-Message -Test -Type Error -Message "${SystemScope} environment variable JDP_SYSTEM_PATH is not defined!"
        $OK = $false
    } else {
        Write-Message -Test -Type Info -Message "${SystemScope} environment variable JDP_SYSTEM_PATH is defined: ${SystemPathVar}"
    }

    if ([Environment]::GetEnvironmentVariable('Path', $SystemScope).split(';') -notcontains '%JDP_SYSTEM_PATH%') {
        Write-Message -Test -Type Error -Message "PATH environment variable in '${SystemScope}' scope is missing system path: %JDP_SYSTEM_PATH%"
        $OK = $false
    } else {
        Write-Message -Test -Type Info -Message "PATH environment variable in '${SystemScope}' scope contains system path: %JDP_SYSTEM_PATH%"
    }

    $BinDir = $SystemDir['bin']
    if ([Environment]::GetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemScope).split(';') -notcontains $BinDir) {
        Write-Message -Test -Type Error -Message "JDP_SYSTEM_PATH environment variable in '${SystemScope}' scope is missing 'bin' directory: ${BinDir}"
        $OK = $false
    } else {
        Write-Message -Test -Type Info -Message "JDP_SYSTEM_PATH environment variable in '${SystemScope}' scope contains 'bin' directory: ${BinDir}"
    }

    foreach ($item in $SystemDir.GetEnumerator()) {

        $DirName = $item.Name
        $DirPath = $item.Value

        if (Test-Path -Path $DirPath -PathType Container) {
            Write-Message -Test -Type Info -Message "'${DirName}' directory exists: ${DirPath}"
        } else {
            Write-Message -Test -Type Error -Message "'${DirName}' directory does not exist: ${DirPath}"
            $OK = $false
        }
    }

    if ($OK) {
        Write-Message -Test -Type Success -Message "System test succeeded."
    } else {
        Write-Message -Test -Type Error -Message "System test failed!"
    }
}
