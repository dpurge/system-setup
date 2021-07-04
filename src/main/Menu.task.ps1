Task Menu `
    -description "Execute tasks interactively" `
{
    Start-Process -FilePath 'pwsh' -Verb runAs -WorkingDirectory $pwd.Path -ArgumentList @('-NoExit', '-Command', 'Invoke-PSake ./build.psake.ps1 -Task DisplayMenu')
}