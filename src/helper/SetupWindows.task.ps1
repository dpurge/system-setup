Task SetupWindows `
    -description "Set up Windows" `
    -depends `
        CreateWorkDirectory `
{
    $AllowCortana = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana'
    if ($AllowCortana) {
        if (Invoke-YesNoQuestion `
            -title "Disabling Cortana" `
            -message "Do you want to disable Cortana?")
        {
            Write-Message -Install -Type Info -Message "Disabling Cortana"
            New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\' -Name 'Windows Search' | Out-Null
            New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -PropertyType DWORD -Value '0' | Out-Null
        }
    } else {
        Write-Message -Install -Type Success -Message "Cortana is disabled."
    }

    # ---------- # ---------- # ---------- # ---------- # ---------- #

    $DisposableClientVM = Get-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM
    if ($DisposableClientVM.State -eq 'Enabled') {
        Write-Message -Install -Type Success -Message "Containers-DisposableClientVM is enabled."
    } else {
        if (Invoke-YesNoQuestion `
            -title "Containers-DisposableClientVM" `
            -message "Do you want to enable Containers-DisposableClientVM?")
        {
            Write-Message -Install -Type Info -Message "Enabling Containers-DisposableClientVM"
            Enable-WindowsOptionalFeature -All -Online -FeatureName Containers-DisposableClientVM
        }
    }

    # ---------- # ---------- # ---------- # ---------- # ---------- #

    $WindowsSubsystemLinux = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    if ($WindowsSubsystemLinux.State -eq 'Enabled') {
        Write-Message -Install -Type Success -Message "Microsoft-Windows-Subsystem-Linux is enabled."
    } else {
        if (Invoke-YesNoQuestion `
            -title "Microsoft-Windows-Subsystem-Linux" `
            -message "Do you want to enable Microsoft-Windows-Subsystem-Linux?")
        {
            Write-Message -Install -Type Info -Message "Enabling Microsoft-Windows-Subsystem-Linux"
            Enable-WindowsOptionalFeature -All -Online -FeatureName Microsoft-Windows-Subsystem-Linux
            Set-NetFirewallProfile -DisabledInterfaceAliases "vEthernet (WSL)"
        }
    }

    # ---------- # ---------- # ---------- # ---------- # ---------- #

    $VirtualMachinePlatform = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
    if ($VirtualMachinePlatform.State -eq 'Enabled') {
        Write-Message -Install -Type Success -Message "VirtualMachinePlatform is enabled."
    } else {
        if (Invoke-YesNoQuestion `
            -title "VirtualMachinePlatform" `
            -message "Do you want to enable VirtualMachinePlatform?")
        {
            Write-Message -Install -Type Info -Message "Enabling VirtualMachinePlatform"
            Enable-WindowsOptionalFeature -All -Online -FeatureName VirtualMachinePlatform
            $KernelMedia = Join-Path -Path $TempDir -ChildPath 'wsl_update_x64.msi'
            Download-Resource -uri 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi' -output $KernelMedia
            Write-Message -Install -Type Info -Message "Installing WSL2 Linux kernel"
            msiexec /i "`"${KernelMedia}`"" /qb
            wsl --set-default-version 2
        }
    }
}