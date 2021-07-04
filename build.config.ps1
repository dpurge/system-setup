@{
    SystemRoot = if ($env:JDP_SYSTEM_ROOT) { $env:JDP_SYSTEM_ROOT } else { 'D:\' }
    DocumentRoot = $env:JDP_DOCUMENT_ROOT
    SystemScope = 'Machine'
}