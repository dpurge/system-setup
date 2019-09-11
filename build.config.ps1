@{
    SystemRootDir = if (Test-Path env:JDP_SYSTEM_ROOT) { $env:JDP_SYSTEM_ROOT } else { 'D:\' }
    SystemScope = 'Machine'
}