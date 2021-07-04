Task DownloadSources `
    -description "Download sources" `
    -requiredVariable `
      SystemDir `
{
    $sources = @(
        @{
            Name = 'beatcracker/VSCELicense'
            Uri = 'https://github.com/beatcracker/VSCELicense.git'
            Directory = 'github.com/beatcracker/VSCELicense'
        }

        @{
            Name = 'beatcracker/PSDockerHub'
            Uri = 'https://github.com/beatcracker/PSDockerHub.git'
            Directory = 'github.com/beatcracker/PSDockerHub'
        }

        @{
            Name = 'beatcracker/toptout'
            Uri = 'https://github.com/beatcracker/toptout.git'
            Directory = 'github.com/beatcracker/toptout'
        }

        @{
            Name = 'microsoft/WSL-DistroLauncher'
            Uri = 'https://github.com/microsoft/WSL-DistroLauncher.git'
            Directory = 'github.com/microsoft/WSL-DistroLauncher'
        }

        @{
            Name = 'MicrosoftDocs/azure-docs'
            Uri = 'https://github.com/MicrosoftDocs/azure-docs.git'
            Directory = 'github.com/MicrosoftDocs/azure-docs'
            Depth = 20
        }

        @{
            Name = 'MicrosoftDocs/azure-devops-docs'
            Uri = 'https://github.com/MicrosoftDocs/azure-devops-docs.git'
            Directory = 'github.com/MicrosoftDocs/azure-devops-docs'
        }

        @{
            Name = 'MicrosoftDocs/visualstudio-docs'
            Uri = 'https://github.com/MicrosoftDocs/visualstudio-docs.git'
            Directory = 'github.com/MicrosoftDocs/visualstudio-docs'
        }

        @{
            Name = 'Opticos/GWSL-Source'
            Uri = 'https://github.com/Opticos/GWSL-Source.git'
            Directory = 'github.com/Opticos/GWSL-Source'
        }
    )

    foreach ($s in $sources) {
        $SrcDir = Join-Path -Path $SystemDir['src'] -ChildPath $s['Directory']
        if (Test-Path -Path $SrcDir -PathType Container) {
            Write-Message -Test -Type Success -Message "Sources for '$($s.Name)': ${SrcDir}"
        } else {
            Write-Message -Test -Type Info -Message "Downloading sources of '$($s.Name)' to: ${SrcDir}"
            $ParentDir = Split-Path -parent $SrcDir
            if (-not (Test-Path -Path $ParentDir -PathType Container)) {
                Write-Message -Test -Type Info -Message "Creating directory: ${ParentDir}"
                New-Item $ParentDir -ItemType Directory | Out-Null
            }

            if ($s.Depth) {
                git clone --depth $s.Depth $s.Uri $SrcDir
            } else {
                git clone $s.Uri $SrcDir
            }
        }
    }
}