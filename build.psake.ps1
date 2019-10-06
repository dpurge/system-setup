$psake.use_exit_on_error = $true
$config = & "$($psake.build_script_dir)\build.config.ps1"

properties {
    $CurrentDir = Resolve-Path .
    $BaseDir = $psake.build_script_dir
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
	
	$SourceDir = "$BaseDir\src"
	$LogDir = "$BaseDir\log"
    $TempDir   = "$BaseDir\tmp"
    
    $SystemDir = @{
        bin = 'bin'
        dat = 'dat'
        doc = 'doc'
        pgm = 'pgm'
        src = 'src'
        tmp = 'tmp'
    }

    # Parameters

    $SystemRootDir = if ($config.ContainsKey('SystemRootDir')) `
        { $config['SystemRootDir'] } `
            else { Read-Host "JDP system root directory:" }

    $SystemScope = if ($config.ContainsKey('SystemScope')) `
        { $config['SystemScope'] } `
            else { 'User' }

    # Commonly used variables

    $ProgramDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['pgm']
    $BinDir = Join-Path -Path $SystemRootDir -ChildPath $SystemDir['bin']
    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7z\7z.exe'
    $UninstallRegKey32 = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    $UninstallRegKey64 = "HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

    # Global state

    $Applications = @()
}

foreach ($item in (Get-ChildItem -Path "$($psake.build_script_dir)\src\function\" -Recurse -Include '*.ps1')) {
    Include $item.FullName
}

foreach ($item in (Get-ChildItem -Path "$($psake.build_script_dir)\src\" -Recurse -Include '*.task.ps1')) {
    Include $item.FullName
}

Task default -depends Menu

# ---------- # ---------- # ---------- # ---------- # ---------- #

Task DownloadBasicTools `
    -description "Download installation media for basic tools" `
    -depends `
        GetBasicTools, DownloadApplication

Task TestBasicTools `
    -description "Verify installation of basic tools" `
    -depends `
        GetBasicTools, TestApplication

Task InstallBasicTools `
    -description "Install basic system tools" `
    -depends `
        InstallSystem, GetBasicTools, InstallApplication
    

Task DownloadDocumentTools `
    -description "Download installation media for document processing tools" `
    -depends `
        GetDocumentTools, DownloadApplication

Task TestDocumentTools `
    -description "Verify installation of document processing tools" `
    -depends `
        GetDocumentTools, TestApplication

Task InstallDocumentTools `
    -description "Install document processing tools" `
    -depends `
        InstallSystem, GetDocumentTools, InstallApplication


Task DownloadMediaTools `
    -description "Download installation files for media tools" `
    -depends `
        GetMediaTools, DownloadApplication

Task TestMediaTools `
    -description "Verify installation of media tools" `
    -depends `
        GetMediaTools, TestApplication

Task InstallMediaTools `
    -description "Install media tools" `
    -depends `
        InstallSystem, GetMediaTools, InstallApplication


Task DownloadLearningTools `
    -description "Download installation files for learning tools" `
    -depends `
        GetLearningTools, DownloadApplication

Task TestLearningTools `
    -description "Verify installation of learning tools" `
    -depends `
        GetLearningTools, TestApplication

Task InstallLearningTools `
    -description "Install learning tools" `
    -depends `
        InstallSystem, GetLearningTools, InstallApplication
    

Task DownloadProgrammingTools `
    -description "Download installation media for application development tools" `
    -depends `
        GetProgrammingTools, DownloadApplication

Task TestProgrammingTools `
    -description "Verify installation of application development tools" `
    -depends `
        GetProgrammingTools, TestApplication

Task InstallProgrammingTools `
    -description "Install application development tools" `
    -depends `
        InstallSystem, GetProgrammingTools, InstallApplication


Task DownloadOtherTools `
    -description "Download other miscelaneous tools" `
    -depends `
        GetOtherTools, DownloadApplication

Task TestOtherTools `
    -description "Verify installation of other miscelaneous tools" `
    -depends `
        GetOtherTools, TestApplication

Task InstallOtherTools `
    -description "Install other miscelaneous tools" `
    -depends `
        InstallSystem, GetOtherTools, InstallApplication
