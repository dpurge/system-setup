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
- [VLC media player](https://get.videolan.org/vlc/3.0.8/win64/vlc-3.0.8-win64.exe)
- [Zoom](https://zoom.us/support/download)

```bash
git config --global user.email "david@example.com"
git config --global user.name "David P."
git config --global credential.helper wincred
```

```powershell
Install-Module psake
```

Add to the VSCode's `settings.json`:

```json
{
   "terminal.integrated.shell.windows" : "D:\\pgm\\powershell\\pwsh.exe"
}
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

Export settings for X applications:

```bash
export DISPLAY=:0
export LIBGL_ALWAYS_INDIRECT=1
```

In windows, configure VcXsrv to use:

- multiple windows
- display number `0`
- start no client
- enable clipboard and primary selection
- enable native opengl

change target of `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\XLaunch.lnk`
to: `D:\pgm\VcXsrv\xlaunch.exe -run %userprofile%\Documents\config.xlaunch`

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
Ad block       | gighmmpiobklfepjocnamgkkbiglidom

Add bookmarks:

Bookmark | URL
-------- | ---------------------------
Apps     | chrome://apps/

Add shortcuts:

Shortcut | URL
-------- | ---------------------------
Gmail    | https://mail.google.com/mail/
Maps     | https://www.google.com/maps/
Calendar | https://calendar.google.com/calendar/
Azure    | https://portal.azure.com/
GitHub   | https://github.com/
Teams    | https://teams.microsoft.com/

## VSCode extensions

Command to install extensions

```batch
code --install-extension {extension-id}
```

Extensions to install in Windows

Extension name | Extension ID                   | Extension URI
-------------- | ------------------------------ | -------------
markdownlint   | davidanson.vscode-markdownlint | xxx
Remote - WSL   | ms-vscode-remote.remote-ws     | xxx
Dart           | dart-code.dart-code            | https://dartcode.org/
Flutter        | dart-code.flutter              | https://dartcode.org/

Extesions to install in WSL:Ubuntu

Extension name | Extension ID | Extension URI
-------------- | ------------ | -------------
markdownlint | davidanson.vscode-markdownlint | xxx
Python | ms-python.python | xxx

## Android SDK

Enable *Windows Hypervisor Platform*.

```bash
sdkmanager --update
sdkmanager "build-tools;29.0.2" "extras;google;usb_driver" "platforms;android-29" "platform-tools"
sdkmanager "system-images;android-29;google_apis;x86_64"
sdkmanager emulator
avdmanager create avd --name test-01 --package "system-images;android-29;google_apis;x86_64" --abi x86_64 --sdcard 100M --device 34 --force --path D:/dat/android/test-01
avdmanager delete avd --name test-01
emulator -avd test-01
emulator -avd test-01 -gpu host
emulator -avd test-01 -gpu angle_indirect
emulator -avd test-01 -gpu swiftshader_indirect

flutter devices
flutter run -d emulator-5554
flutter run

flutter channel master
flutter upgrade
flutter config --enable-web
cd flutter_hello_world
flutter run -d chrome
flutter build web
```

## ConEmu setup

Task                       | Command
-------------------------- | -------------------------------------------------------------------------
Shells::PowerShell         | D:\pgm\powershell\pwsh.exe
Shells::PowerShell (Admin) | D:\pgm\powershell\pwsh.exe -new_console:a
Tools::Far Manager         | %FarHome%\Far.exe /w /p"%ConEmuDir%\Plugins\ConEmu;%FarHome%\Plugins"

## Environment variables and path

Environemnt variables:

Name              | Value
----------------- | ---------------
JAVA_HOME         | D:\pgm\jdk
ANDROID_HOME      | D:\pgm\android
GOPATH            | D:\
CHROME_EXECUTABLE | D:\pgm\Chromium\chrome.exe
FarHome           | D:\pgm\far
JDP_SYSTEM_ROOT   | D:\
JDP_SYSTEM_PATH   | ...

Default path entries:

- %SystemRoot%\system32;
- %SystemRoot%;
- %SystemRoot%\System32\Wbem;
- %SystemRoot%\System32\WindowsPowerShell\v1.0\;
- %SystemRoot%\System32\OpenSSH\;
- %USERPROFILE%\AppData\Local\Microsoft\WindowsApps;

JDP_SYSTEM_PATH entries:

- D:\bin;
- D:\pgm\powershell;
- D:\pgm\conemu;
- D:\pgm\conemu\ConEmu;
- D:\pgm\Far
- D:\pgm\Git\cmd;
- D:\pgm\VSCode\bin;
- D:\pgm\go\bin;
- %JAVA_HOME%\bin
- %ANDROID_HOME%\emulator
- %ANDROID_HOME%\tools
- %ANDROID_HOME%\platform-tools
- %ANDROID_HOME%\tools\bin
- D:\pgm\dart-sdk\bin;
- D:\pgm\flutter\bin;

## Windows shortcuts

Shortcut | Action
-------- | ------
TODO     | TODO
