Task InstallProgrammingTools `
    -description "Install programming tools" `
    -depends `
        DownloadProgrammingTools, InstallBaseSystemTools `
    -requiredVariable `
        SystemRootDir, TempDir, SystemDir `
{
    $ProgramDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['pgm']
    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7z\7z.exe'

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'VSCode'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "VSCode directory already exists: ${ApplicationDir}"
    } else {
        $InstallExe = Join-Path -Path $TempDir -ChildPath 'VSCodeSetup-x64-1.38.1.exe'
        if (-not (Test-Path -Path $InstallExe)) {
            Write-Message -Install -Type Error -Message "Missing VSCode installation media: ${InstallExe}"
        } else {
            Write-Message -Install -Type Info -Message "Installing VSCode into: ${ApplicationDir}"
            Exec {
                & $InstallExe /VERYSILENT /NORESTART /DIR "`"${ApplicationDir}`""
            }
        }
        
    }

    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'jdk'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "JDK directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'openjdk-13_windows-x64_bin.zip'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing JDK installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing JDK into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ProgramDir}`""
            }
            Rename-Item -Path "${ProgramDir}\jdk-13" -NewName $ApplicationDir
        }
        
    }
    <#
    $JavaHomeVar = [Environment]::GetEnvironmentVariable('JAVA_HOME', $SystemScope)
    if ($JavaHomeVar) {
        Write-Message -Install -Type Info -Message "JAVA_HOME environment variable in '${SystemScope}' scope exists: ${JavaHomeVar}"
    } else {
        Write-Message -Install -Type Info -Message "Setting JAVA_HOME in '${SystemScope}' scope: ${ApplicationDir}"
        [Environment]::SetEnvironmentVariable('Path', $ApplicationDir, $SystemScope)
    }
    $PathVar = [Environment]::GetEnvironmentVariable('Path', $SystemScope)
    if ($PathVar.split(';') -contains '%JAVA_HOME%\bin') {
        Write-Message -Install -Type Info -Message "PATH environment variable in '${SystemScope}' scope contains '%JAVA_HOME%\bin' directory."
    } else {
        $PathVar = "${PathVar};%JAVA_HOME%\bin"
        Write-Message -Install -Type Info -Message "Setting PATH in '${SystemScope}' scope: ${PathVar}"
        [Environment]::SetEnvironmentVariable('Path', $PathVar, $SystemScope)
    }
    #>


    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'Go'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "Go directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'go1.13.windows-amd64.zip'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing Go installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing Go into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ProgramDir}`""
            }
        }
        
    }

}