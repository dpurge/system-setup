Task InstallSystem `
    -description "Install base system" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        SystemRoot, SystemScope, SystemDir `
{
    $SystemRootVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_ROOT', $SystemScope)

    if ($SystemRootVar) {
        Write-Message -Install -Type Info -Message "Environment variable JDP_SYSTEM_ROOT in scope ${SystemScope} exists: ${SystemRootVar}"
        if ($SystemRootVar -ne $SystemRoot) {
            Write-Message -Install -Type Error -Message "Environment variable JDP_SYSTEM_ROOT does not match system root directory: ${SystemRoot}"
        }
    } else {
        Write-Message -Install -Type Info -Message "Creating environment variable JDP_SYSTEM_ROOT in scope '${SystemScope}': ${SystemRoot}"
        [Environment]::SetEnvironmentVariable('JDP_SYSTEM_ROOT', $SystemRoot, $SystemScope)
    }

    if (Test-Path -Path $SystemRoot -PathType Container) {
        Write-Message -Install -Type Info -Message "System root directory exists: ${SystemRoot}"
    } else {
        Write-Message -Install -Type Info -Message "Creating system root directory: ${SystemRoot}"
        New-Item -ItemType Directory -Force -Path $SystemRootDir | Out-Null
    }

    foreach ($item in $SystemDir.GetEnumerator()) {
        $DirPath = $item.Value
        if (Test-Path -Path $DirPath -PathType Container) {
            Write-Message -Install -Type Info -Message "Directory '$($item.Name)'' already exists: $($item.Value)"
        } else {
            Write-Message -Install -Type Info -Message "Creating '$($item.Name)'' directory: $($item.Value)"
            New-Item -ItemType Directory -Force -Path $item.Value | Out-Null
        }
    }


    $SystemPathVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemScope)
    $BinDir = $SystemDir['bin']

    if ($SystemPathVar) {
        Write-Message -Install -Type Info -Message "Environment variable JDP_SYSTEM_PATH in scope ${SystemScope} already exists."
    } else {
        Write-Message -Install -Type Info -Message "Creating environment variable JDP_SYSTEM_PATH in scope '${SystemScope}': ${BinDir}"
        [Environment]::SetEnvironmentVariable('JDP_SYSTEM_PATH', $BinDir, $SystemScope)
        $SystemPathVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemScope)
    }

    if ($SystemPathVar.split(';') -contains $BinDir) {
        Write-Message -Install -Type Info -Message "JDP_SYSTEM_PATH environment variable in '${SystemScope}' scope contains 'bin' direcory: ${BinDir}"
    } else {
        $SystemPathVar += ";${BinDir}"
        Write-Message -Install -Type Info -Message "Setting environment variable JDP_SYSTEM_PATH in scope '${SystemScope}': ${SystemPathVar}"
        [Environment]::SetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemPathVar, $SystemScope)
    }
    
    $PathVar = [Environment]::GetEnvironmentVariable('Path', $SystemScope)
    if ($PathVar.split(';') -contains '%JDP_SYSTEM_PATH%') {
        Write-Message -Install -Type Info -Message "PATH environment variable in '${SystemScope}' scope contains system path: %JDP_SYSTEM_PATH%"
    } else {
        $PathVar += ';%JDP_SYSTEM_PATH%'
        Write-Message -Install -Type Info -Message "Setting PATH in '${SystemScope}' scope: ${PathVar}"
        [Environment]::SetEnvironmentVariable('Path', $PathVar, $SystemScope)
        Write-Message -Install -Type Warning -Message "System path has been changed - please restart your console session!"
    }
}
