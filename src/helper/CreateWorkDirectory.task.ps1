Task CreateWorkDirectory `
    -description "Create working directories" `
    -requiredVariable TempDir, LogDir `
{
    foreach ($Dir in $TempDir, $LogDir) {
        if (-not (Test-Path -Path $Dir -PathType Container)) {
            Write-Message -Type Info -Message "Creating directory: $Dir"
            New-Item -ItemType Directory -Force -Path $Dir | Out-Null
        }
    }
}
