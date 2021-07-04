Task GetBasicTools `
    -description "Install base system tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip, SystemScope `
{

    # Changing global state variable

    $apps = @(
        'WindowsTerminal'
        '7-Zip'
        'Notepad++'
        'Chromium'
        # 'PowerShell'
        # 'ConEmu'
        # 'Far'
        # 'PuTTy'
        # 'VcXsrv'
    )

    foreach ($app in $apps) {
        $Script:Applications += . "$PsScriptRoot\..\application\${app}.ps1"
    }
}