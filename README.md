# Windows system setup

## Directories to create

- bin
- dat
- doc
- pgm
- src
- tmp

## Environment variables

Name      | Value
--------- | -------------
ConEmuDir | D:\pgm\conemu
FarHome   | D:\pgm\far

## Applications to install

- [Powershell Core](https://github.com/PowerShell/PowerShell/releases)
- [ConEmu](https://conemu.github.io)
- [Far Manager](https://www.farmanager.com/download.php)
- [Ungoogled Chromium](https://github.com/Eloston/ungoogled-chromium)
- [Git for Windows](https://git-scm.com/download/win)
- [Visual Studio Code](https://code.visualstudio.com/)
- [VcXsrv](https://sourceforge.net/projects/vcxsrv/)

```powershell
git config --global user.email "david@example.com"
git config --global user.name "David P."
git config --global credential.helper wincred
Install-Module psake
```

## Windows Subsystem for Linux Installation

In PowerShell as Administrator:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

From Microsoft Store:

- Alpine
- Ubuntu

Add link in Quick Access to `\\wsl$\`

In Ubuntu console:

```bash
sudo apt update
sudo apt upgrade
sudo git config --global credential.helper "/mnt/d/pgm/Git/mingw64/libexec/git-core/git-credential-wincred.exe"
sudo apt install python3-pip
sudo apt install nodejs
```

To disable password prompts for sudo:

```bash
sudo visudo
david ALL=(root) NOPASSWD: /home/david/.local/bin/start_postgresql.sh
```

Linux services to start from Windows task scheduler:

Program                      | Arguments
---------------------------- | ------------------------------------------
C:\Windows\System32\bash.exe | -c "sudo ~/.local/bin/start_postgresql.sh"

## Chromium extensions

Configuration settings for Ungoogled Chromium 67.0:

Setting URI                                     | Setting Value
----------------------------------------------- | ------------------------------------------------------------
chrome://settings/searchEngines                 | https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=67.0&x=id%3D%s%26installsource%3Dondemand%26uc
chrome://flags/#extension-mime-request-handling | Always prompt for install

Install extensions:

Extension name | Extension ID
-------------- | --------------------------------
Save to Pocket | niloccemoadcdkdjlinkgdfekeahmflj

## VSCode extensions

Command to install extensions

```batch
code --install-extension {extension-id}
```

Extensions to install in Windows

Extension name | Extension ID | Extension URI
-------------- | ------------ | -------------
markdownlint | davidanson.vscode-markdownlint | xxx
Remote - WSL | ms-vscode-remote.remote-ws | xxx

Extesions to install in WSL:Ubuntu

Extension name | Extension ID | Extension URI
-------------- | ------------ | -------------
markdownlint | davidanson.vscode-markdownlint | xxx
Python | ms-python.python | xxx

## ConEmu setup

Task                       | Command
-------------------------- | -------------------------------------------------------------------------
Shells::PowerShell         | D:\pgm\powershell\pwsh.exe
Shells::PowerShell (Admin) | D:\pgm\powershell\pwsh.exe -new_console:a
Tools::Far Manager         | %FarHome%\Far.exe /w /p"%ConEmuDir%\Plugins\ConEmu;%FarHome%\Plugins"

## Windows shortcuts

Shortcut | Action
-------- | ------
TODO     | TODO
