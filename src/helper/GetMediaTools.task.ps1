Task GetMediaTools `
    -description "Install media tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip `
{

    # Changing global state variable

    $Script:Applications += @(

        @{
            Name = 'ffmpeg'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'ffmpeg')
                )
            }
            Install = @{
                Uri = 'https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20191004-e6625ca-win64-static.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'ffmpeg-20191004-e6625ca-win64-static.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'ffmpeg'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
                    Rename-Item -Path (Join-Path -Path "`"${Directory}\..`"" -ChildPath 'ffmpeg-20191004-e6625ca-win64-static') -NewName $Directory
                }
            }
        }

        # ----------

        @{
            Name = 'Foobar2000'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'foobar2000')
                )
            }
            Install = @{
                Uri = 'https://www.foobar2000.org/files/edcaa07128d5bb8485a19ff8edfb48c5/foobar2000_v1.4.8.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'foobar2000_v1.4.8.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'foobar2000'
                Script = {
                    param($InstallMedia, $Directory)
                    & $InstallMedia
                }
            }
        }

        # ----------

        @{
            Name = 'VLC'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'VLC')
                )
            }
            Install = @{
                Uri = 'https://ftp.icm.edu.pl/pub/video/vlc/vlc/3.0.8/win64/vlc-3.0.8-win64.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'vlc-3.0.8-win64.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'VLC'
                Script = {
                    param($InstallMedia, $Directory)
                    & $InstallMedia
                }
            }
        }

        # ----------

    )
}