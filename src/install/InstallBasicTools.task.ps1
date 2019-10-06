
<#


    $ApplicationDir = Join-Path -Path $ProgramDir -ChildPath 'Translit'
    if (Test-Path -Path $ApplicationDir -PathType Container) {
        Write-Message -Install -Type Info -Message "Translit directory already exists: ${ApplicationDir}"
    } else {
        $ZipFile = Join-Path -Path $TempDir -ChildPath 'Universal_Transliteration_v1.0.zip'
        if (-not (Test-Path -Path $ZipFile)) {
            Write-Message -Install -Type Error -Message "Missing Translit installation media: ${ZipFile}"
        } else {
            Write-Message -Install -Type Info -Message "Installing Translit into: ${ApplicationDir}"
            Exec {
                & $SevenZip x "`"${ZipFile}`"" -o"`"${ProgramDir}`""
            }
        }
        
    }

#>