Task GetLearningTools `
    -description "Install learning tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip `
{

    # Changing global state variable

    $Script:Applications += @(

        @{
            Name = 'Translit'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'Translit')
                )
            }
            Install = @{
                #'https://www.fosshub.com/Universal-Character-Transliteration-Utility.html?dwl=Universal_Transliteration_v1.0.zip'
                Uri = 'https://download.fosshub.com/Protected/expiretime=1568294294;badurl=aHR0cHM6Ly93d3cuZm9zc2h1Yi5jb20vVW5pdmVyc2FsLUNoYXJhY3Rlci1UcmFuc2xpdGVyYXRpb24tVXRpbGl0eS5odG1s/68d631f2c893debaaeb173734af39e8105ac70c34b255f7fcb0b741a8687f646/5becae1b4f6487156b10a6f4/5bee4147cb8bb415b5028144/Universal_Transliteration_v1.0.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'Universal_Transliteration_v1.0.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'Translit'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
                }
            }
        }

        # ----------

        @{
            Name = 'Anki'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'Anki')
                )
            }
            Install = @{
                Uri = 'https://apps.ankiweb.net/downloads/current/anki-2.1.15-windows.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'anki-2.1.15-windows.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'Anki'
                Script = {
                    param($InstallMedia, $Directory)
                    & $InstallMedia
                }
            }
        }

        # ----------

    )
}