@{
    SystemRootDir = if (Test-Path env:JDP_SYSTEM_ROOT) { $env:JDP_SYSTEM_ROOT } else { 'D:\xxx' }
    SystemScope = 'Machine'
    DownloadUri = @{
        Powershell = 'https://github.com/PowerShell/PowerShell/releases'
        ConEmu = 'https://conemu.github.io'
    }
}