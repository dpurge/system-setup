@{
    Name = 'VisualStudio'
    Verify = @{
        Directory = @(
            "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Community"
        )
    }
    Install = @{
        Uri = 'https://download.visualstudio.microsoft.com/download/pr/9dc321fd-8a9b-47ef-98a9-af0515e08d6f/533c91be0b61f481cb93758a3c6af09cef719cedbaa6e9916232918649fd4a35/vs_Community.exe'
        Media = Join-Path -Path $TempDir -ChildPath 'vs_Community.exe'
        Directory = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Community"
        Script = {
            param($InstallMedia, $Directory)
            & $InstallMedia `
              --add Microsoft.VisualStudio.Workload.CoreEditor `
              --add Microsoft.VisualStudio.Workload.Azure `
              --add Microsoft.VisualStudio.Workload.ManagedDesktop `
              --add Microsoft.VisualStudio.Workload.NativeCrossPlat `
              --add Microsoft.VisualStudio.Workload.NativeDesktop `
              --add Microsoft.VisualStudio.Workload.NetCoreTools `
              --add Microsoft.VisualStudio.Workload.Universal
        }
    }
}