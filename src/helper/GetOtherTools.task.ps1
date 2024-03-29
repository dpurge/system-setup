Task GetOtherTools `
    -description "Install other miscelaneous tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip `
{

    # Changing global state variable

    $Script:Applications += @(

        @{
            Name = 'Torrent-File-Editor'
            Verify = @{
                File = @(
                    (Join-Path -Path $BinDir -ChildPath 'torrent-file-editor.exe')
                )
            }
            Install = @{
                Uri = 'https://netix.dl.sourceforge.net/project/torrent-file-editor/v0.3.14/torrent-file-editor-0.3.14-x64.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'torrent-file-editor-0.3.14-x64.exe'
                Directory = $BinDir
                Script = {
                    param($InstallMedia, $Directory)
                    Copy-Item -Path $InstallMedia -Destination $Directory\torrent-file-editor.exe
                }
            }
        }

        # ----------

        @{
            Name = 'YouTube-Dl'
            Verify = @{
                File = @(
                    (Join-Path -Path $BinDir -ChildPath 'youtube-dl.exe')
                )
            }
            Install = @{
                Uri = 'https://youtube-dl.org/downloads/latest/youtube-dl.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'youtube-dl.exe'
                Directory = $BinDir
                Script = {
                    param($InstallMedia, $Directory)
                    Copy-Item -Path $InstallMedia -Destination $Directory
                }
            }
        }

        # ----------

        @{
            Name = 'MSTeams'
            Verify = @{
            }
            Install = @{
                Uri = 'https://statics.teams.microsoft.com/production-windows-x64/1.2.00.24753/Teams_windows_x64.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'Teams_windows_x64-1.2.00.24753.exe'
                Directory = $null
                Script = {
                    param($InstallMedia, $Directory)
                    Write-Message -Install -Type Info -Message "Running installer: ${InstallMedia}"
                    & $InstallMedia
                }
            }
        }

        <#
            #'https://www.fosshub.com/Universal-Character-Transliteration-Utility.html?dwl=Universal_Transliteration_v1.0.zip'
            'https://download.fosshub.com/Protected/expiretime=1568294294;badurl=aHR0cHM6Ly93d3cuZm9zc2h1Yi5jb20vVW5pdmVyc2FsLUNoYXJhY3Rlci1UcmFuc2xpdGVyYXRpb24tVXRpbGl0eS5odG1s/68d631f2c893debaaeb173734af39e8105ac70c34b255f7fcb0b741a8687f646/5becae1b4f6487156b10a6f4/5bee4147cb8bb415b5028144/Universal_Transliteration_v1.0.zip'
        #>

    )
}