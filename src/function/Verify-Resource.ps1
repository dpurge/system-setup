function Verify-Resource {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Application,

        $Directory = @(),
        $File = @(),
        $EnvVar = @(),
        $Path = @()
    )

    [bool] $Verified = $True

    foreach ($DirName in $Directory) {
        if (Test-Path -Path $DirName -PathType Container) {
            Write-Message -Install -Type Info -Message "${Application} directory exists: ${DirName}"
        } else {
            $Verified = $False
            Write-Message -Install -Type Warning -Message "Missing ${Application} directory: ${DirName}"
        }
    }

    foreach ($FileName in $File) {
        if (Test-Path -Path $FileName -PathType Leaf) {
            Write-Message -Install -Type Info -Message "${Application} file exists: ${FileName}"
        } else {
            $Verified = $False
            Write-Message -Install -Type Warning -Message "Missing ${Application} file: ${FileName}"
        }
    }

    foreach ($Var in $EnvVar) {
    }

    foreach ($Entry in $Path) {
    }

    return $Verified
}