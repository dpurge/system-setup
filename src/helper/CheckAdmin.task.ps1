Task CheckAdmin `
    -description "Check that we are running in the elevated shell" `
{
    If (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {    
        throw "This task needs to be run as Administrator!"
    }
}
