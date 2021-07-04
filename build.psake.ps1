$psake.use_exit_on_error = $true
$config = & "$($psake.build_script_dir)\build.config.ps1"

properties {
    $CurrentDir = Resolve-Path .
    $BaseDir = $psake.build_script_dir
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
	
	$SourceDir = "$BaseDir\src"
	$LogDir = "$BaseDir\log"
    $TempDir   = "$BaseDir\tmp"

    # Parameters

    $SystemRoot = if ($config.ContainsKey('SystemRoot')) `
        { $config['SystemRoot'] } `
            else { Read-Host "JDP system root directory:" }

    $DocumentRoot = if ($config['DocumentRoot']) `
        { $config['DocumentRoot'] } `
            else { $SystemRoot }

    $SystemScope = if ($config.ContainsKey('SystemScope')) `
        { $config['SystemScope'] } `
            else { 'User' }
    
    $SystemDir = @{
        bin = Join-Path -Path $SystemRoot -ChildPath 'bin'
        dat = Join-Path -Path $SystemRoot -ChildPath 'dat'
        doc = Join-Path -Path $DocumentRoot -ChildPath 'doc'
        pgm = Join-Path -Path $SystemRoot -ChildPath 'pgm'
        src = Join-Path -Path $DocumentRoot -ChildPath 'src'
        tmp = Join-Path -Path $SystemRoot -ChildPath 'tmp'
    }

    # Commonly used variables

    $ProgramDir = $SystemDir['pgm']
    $BinDir = $SystemDir['bin']
    $SevenZip = Join-Path -Path $ProgramDir -ChildPath '7-Zip\7z.exe'

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
