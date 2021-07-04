Task TestWindows `
    -description "Test Windows" `
{
    $AllowCortana = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana'
    if ($AllowCortana) {
        Write-Message -Install -Type Error -Message "Cortana is enabled!"
    } else {
        Write-Message -Install -Type Success -Message "Cortana is disabled."
    }

    # ---------- # ---------- # ---------- # ---------- # ---------- #

    $DisposableClientVM = Get-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM
    if ($DisposableClientVM.State -eq 'Enabled') {
        Write-Message -Install -Type Success -Message "Containers-DisposableClientVM is enabled."
    } else {
        Write-Message -Install -Type Error -Message "Containers-DisposableClientVM is disabled."
    }

    # ---------- # ---------- # ---------- # ---------- # ---------- #

    $WindowsSubsystemLinux = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    if ($WindowsSubsystemLinux.State -eq 'Enabled') {
        Write-Message -Install -Type Success -Message "Microsoft-Windows-Subsystem-Linux is enabled."
    } else {
        Write-Message -Install -Type Error -Message "Microsoft-Windows-Subsystem-Linux is disabled."
    }

    # ---------- # ---------- # ---------- # ---------- # ---------- #

    $VirtualMachinePlatform = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
    if ($VirtualMachinePlatform.State -eq 'Enabled') {
        Write-Message -Install -Type Success -Message "VirtualMachinePlatform is enabled."
    } else {
        Write-Message -Install -Type Error -Message "VirtualMachinePlatform is disabled."
    }
}