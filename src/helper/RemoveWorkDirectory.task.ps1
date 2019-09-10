Task RemoveWorkDirectory `
    -description "Remove working directories" `
    -requiredVariable TempDir, LogDir `
{
    foreach ($Dir in $TempDir, $LogDir) {
        if (Test-Path $Dir) {
            Write-Message -Type Info -Message "Removing directory: $Dir"
            Remove-Item $Dir -Force -Recurse
        }
    }
}
