function Verify-Resource {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Application,

        $Directory = @(),
        $File = @(),
        $EnvVar = @(),
        $RegKey = @(),
        $Path = @()
    )

    [bool] $Verified = $True

    foreach ($DirName in $Directory) {
        if (Test-Path -Path $DirName -PathType Container) {
            Write-Message -Test -Type Info -Message "${Application} directory exists: ${DirName}"
        } else {
            $Verified = $False
            Write-Message -Test -Type Warning -Message "Missing ${Application} directory: ${DirName}"
        }
    }

    foreach ($FileName in $File) {
        if (Test-Path -Path $FileName -PathType Leaf) {
            Write-Message -Test -Type Info -Message "${Application} file exists: ${FileName}"
        } else {
            $Verified = $False
            Write-Message -Test -Type Warning -Message "Missing ${Application} file: ${FileName}"
        }
    }

    foreach ($VarName in $EnvVar.Keys) {
        $VarValue = [Environment]::GetEnvironmentVariable($VarName, $SystemScope)
        if ($VarValue) {
            if ($VarValue -eq $EnvVar.Item($VarName)) {
                Write-Message -Test -Type Info -Message "${Application} environment variable ${VarName}: ${VarValue}"
            } else {
                $Verified = $False
                Write-Message -Test -Type Warning -Message "Wrong value for ${Application} environment variable ${VarName}: ${VarValue} (expected '$($EnvVar.Item($VarName))'"
            }
        } else {
            $Verified = $False
            Write-Message -Test -Type Warning -Message "Missing ${Application} environment variable: ${VarName}"
        }
    }

    foreach ($Key in $RegKey) {
        if (Test-Path -Path $DirName -PathType Container) {
            Write-Message -Test -Type Info -Message "${Application} registry key exists: ${Key}"
        } else {
            $Verified = $False
            Write-Message -Test -Type Warning -Message "Missing ${Application} registry key: ${Key}"
        }
    }

    $SystemPathItems = [Environment]::GetEnvironmentVariable('JDP_SYSTEM_PATH', $SystemScope).split(';')

    foreach ($Entry in $Path) {
        if ($SystemPathItems -contains $Entry) {
            Write-Message -Test -Type Info -Message "${Application} path entry exists: ${Entry}"
        } else {
            $Verified = $False
            Write-Message -Test -Type Warning -Message "Missing ${Application} path entry: ${Entry}"
        }
    }

    return $Verified
}