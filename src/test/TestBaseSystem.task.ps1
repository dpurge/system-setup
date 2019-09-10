Task TestBaseSystem `
    -description "Test base system" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        SystemRootDir, SystemScope, SystemDir `
{
    $SystemRootVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_ROOT', $SystemScope)

    if (-not $SystemRootVar) {
        Write-Message -Test -Type Error -Message "${SystemScope} environment variable JDP_SYSTEM_ROOT is not defined!"
    } else {
        Write-Message -Test -Type Success -Message "${SystemScope} environment variable JDP_SYSTEM_ROOT is defined."

        if (-not (Test-Path -Path $SystemRootVar -PathType Container)) {
            Write-Message -Test -Type Error -Message "System root directory does not exist: ${SystemRootVar}"
        } else {
            Write-Message -Test -Type Success -Message "System root directory exists: ${SystemRootVar}"

            foreach ($dir in $SystemDir.GetEnumerator()) {
                $DirPath = Join-Path -Path $SystemRootVar -ChildPath $dir.Value

                if (-not (Test-Path -Path $DirPath -PathType Container)) {
                    Write-Message -Test -Type Error -Message "$($dir.Name) directory does not exist: ${DirPath}"
                } else {
                    Write-Message -Test -Type Success -Message "$($dir.Name) directory exists: ${DirPath}"
                    if ($dir.Name -eq 'bin') {
                        if ([Environment]::GetEnvironmentVariable('Path', $SystemScope).split(';') -notcontains $DirPath) {
                            Write-Message -Test -Type Error -Message "PATH environment variable in '${SystemScope}' scope is missing 'bin' directory: ${DirPath}"
                        } else {
                            Write-Message -Test -Type Success -Message "PATH environment variable in '${SystemScope}' scope contains 'bin' directory: ${DirPath}"
                        }
                    }
                }
            }
        }
    }
}
