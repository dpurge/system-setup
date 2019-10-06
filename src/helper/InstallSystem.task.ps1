Task InstallSystem `
    -description "Install base system" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        SystemRootDir, SystemScope, SystemDir `
{
    $SystemRootVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_ROOT', $SystemScope)

    if ($SystemRootVar) {
        Write-Message -Install -Type Info -Message "Environment variable JDP_SYSTEM_ROOT in scope ${SystemScope} exists: ${SystemRootVar}"
        if ($SystemRootVar -ne $SystemRootDir) {
            Write-Message -Install -Type Error -Message "Environment variable JDP_SYSTEM_ROOT does not match system root directory: ${SystemRootDir}"
        }
    } else {
        Write-Message -Install -Type Info -Message "Creating environment variable JDP_SYSTEM_ROOT in scope '${SystemScope}': ${SystemRootDir}"
        [Environment]::SetEnvironmentVariable('JDP_SYSTEM_ROOT', $SystemRootDir, $SystemScope)
    }

    if (Test-Path -Path $SystemRootDir -PathType Container) {
        Write-Message -Install -Type Info -Message "System root directory exists: ${SystemRootDir}"
    } else {
        Write-Message -Install -Type Info -Message "Creating system root directory: ${SystemRootDir}"
        New-Item -ItemType Directory -Force -Path $SystemRootDir | Out-Null
    }

    foreach ($dir in $SystemDir.GetEnumerator()) {
        $DirPath = Join-Path -Path $SystemRootDir -ChildPath $dir.Value
        if (Test-Path -Path $DirPath -PathType Container) {
            Write-Message -Install -Type Info -Message "$($dir.Name) already exists: ${DirPath}"
        } else {
            Write-Message -Install -Type Info -Message "Creating $($dir.Name) directory: ${DirPath}"
            New-Item -ItemType Directory -Force -Path $DirPath | Out-Null
        }
    }

    $BinPath = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['bin']

    $SystemPathVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemScope)

    if ($SystemPathVar) {
        Write-Message -Install -Type Info -Message "Environment variable JDP_SYSTEM_PATH in scope ${SystemScope} already exists."
        if ($SystemPathVar.split(';') -contains $BinPath) {
            Write-Message -Install -Type Info -Message "JDP_SYSTEM_PATH environment variable in '${SystemScope}' scope contains 'bin' path: ${BinPath}"
        } else {
            $SystemPathVar += ";${BinPath}"
            Write-Message -Install -Type Info -Message "Setting environment variable JDP_SYSTEM_PATH in scope '${SystemScope}': ${SystemPathVar}"
            [Environment]::SetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemPathVar, $SystemScope)
        }
    } else {
        Write-Message -Install -Type Info -Message "Creating environment variable JDP_SYSTEM_PATH in scope '${SystemScope}': ${SystemRootDir}"
        [Environment]::SetEnvironmentVariable('JDP_SYSTEM_PATH', $BinPath, $SystemScope)
    }

    
    $PathVar = [Environment]::GetEnvironmentVariable('Path', $SystemScope)
    if ($PathVar.split(';') -contains $BinPath) {
        Write-Message -Install -Type Info -Message "PATH environment variable in '${SystemScope}' scope contains 'bin' path: ${BinPath}"
    } else {
        $PathVar += ';%JDP_SYSTEM_PATH%'
        Write-Message -Install -Type Info -Message "Setting PATH in '${SystemScope}' scope: ${PathVar}"
        [Environment]::SetEnvironmentVariable('Path', $PathVar, $SystemScope)
        Write-Message -Install -Type Warning -Message "System path has been changed - please restart your console session!"
    }
}
