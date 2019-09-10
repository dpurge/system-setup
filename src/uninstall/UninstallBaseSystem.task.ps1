Task UninstallBaseSystem `
    -description "Uninstall base system" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        SystemRootDir, SystemScope, SystemDir `
{
    $SystemRootVar = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_ROOT', $SystemScope)
    if ($SystemRootVar -and $SystemRootVar -ne $SystemRootDir) {
        Write-Message -Uninstall -Type Error -Message "Environment variable JDP_SYSTEM_ROOT does not match system root directory: ${SystemRootDir}"
    }

    $PathVar = [Environment]::GetEnvironmentVariable('Path', $SystemScope)
    $BinPath = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['bin']
    if ($PathVar.split(';') -notcontains $BinPath) {
        Write-Message -Uninstall -Type Info -Message "PATH environment variable in '${SystemScope}' scope does not contain 'bin' directory: ${BinPath}"
    } else {
        $PathVar = (${PathVar}.split(';') | Where-Object {$_ -and $_ -ne $BinPath}) -join ';'
        Write-Message -Uninstall -Type Info -Message "Setting PATH in '${SystemScope}' scope: ${PathVar}"
        [Environment]::SetEnvironmentVariable('Path', $PathVar, $SystemScope)
    }

    foreach ($dir in $SystemDir.GetEnumerator()) {
        $DirPath = Join-Path -Path $SystemRootDir -ChildPath $dir.Value
        if (-not (Test-Path -Path $DirPath -PathType Container)) {
            Write-Message -Uninstall -Type Info -Message "'$($dir.Name)' directory does not exist: ${DirPath}"
        } else {
            Write-Message -Uninstall -Type Info -Message "Removing '$($dir.Name)' directory: ${DirPath}"
            switch ($dir.Name) {
                'bin' {
                    Remove-Item -LiteralPath $DirPath -Force -Recurse
                }
                'dat' {
                    #Remove-Item -LiteralPath $DirPath -Force -Recurse
                }
                'doc' {
                    #Remove-Item -LiteralPath $DirPath -Force -Recurse
                }
                'pgm' {
                    Remove-Item -LiteralPath $DirPath -Force -Recurse
                }
                'src' {
                    #Remove-Item -LiteralPath $DirPath -Force -Recurse
                }
                'tmp' {
                    Remove-Item -LiteralPath $DirPath -Force -Recurse
                }
                default {Write-Message -Uninstall -Type Error -Message "Missing logic to uninstall $($dir.Name) directory: ${DirPath}"}
            }
        }
    }
    
    if (Test-Path -Path $SystemRootDir -PathType Container) {
        Write-Message -Uninstall -Type Info -Message "Removing system root directory: ${SystemRootDir}"
        Remove-Item -LiteralPath $SystemRootDir -Force -Recurse
    } else {
        Write-Message -Uninstall -Type Info -Message "System root directory already removed: ${SystemRootDir}"
    }
    
    if ($SystemRootVar) {
        Write-Message -Install -Type Info -Message "Removing environment variable JDP_SYSTEM_ROOT from scope '${SystemScope}'"
        [Environment]::SetEnvironmentVariable('JDP_SYSTEM_ROOT', $null, $SystemScope)
    } else {
        Write-Message -Uninstall -Type Info -Message "Environment variable JDP_SYSTEM_ROOT in scope ${SystemScope} does not exist."
    }
}
