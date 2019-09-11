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

    $DownloadUri = if ($config.ContainsKey('DownloadUri')) `
        { $config['DownloadUri'] } `
            else { @{} }
}

foreach ($item in (Get-ChildItem -Path "$($psake.build_script_dir)\src\function\" -Recurse -Include '*.ps1')) {
    Include $item.FullName
}

foreach ($item in (Get-ChildItem -Path "$($psake.build_script_dir)\src\" -Recurse -Include '*.task.ps1')) {
    Include $item.FullName
}

Task default -depends Menu

# ---------- # ---------- # ---------- # ---------- # ---------- #

<#
Task Install `
    -description "Install powershell modules on the local system" `
    -depends Package `
    -requiredVariable OutputDir, Modules, Version `
{
    foreach ($Module in $Modules) {
	    $NugetFile = Join-Path -Path $OutputDir -ChildPath "${Module}.${script:Version}.nupkg"
	    Write-Host "Installing powershell module $Module from: $NugetFile"
		if (-not (Test-Path $NugetFile)) { throw "File does not exist: $NugetFile" }
		Exec {
			Install-Module -Name $Module -RequiredVersion $script:Version -Repository $OutputDir -Force
		}
    }
}
#>

