Task GetDocumentTools `
    -description "Install document viewing and document editing tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip `
{

    # Changing global state variable

    $Script:Applications += @(

        @{
            Name = 'MuPdf'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'MuPdf')
                )
            }
            Install = @{
                Uri = 'https://www.mupdf.com/downloads/archive/mupdf-1.16.0-windows.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'mupdf-1.16.0-windows.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'MuPdf'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                    Rename-Item -Path (Join-Path -Path "`"${Directory}\..`"" -ChildPath 'mupdf-1.16.0-windows') -NewName $Directory
                }
            }
        }

        # ----------

        @{
            Name = 'Poppler'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'Poppler')
                )
            }
            Install = @{
                Uri = 'http://blog.alivate.com.au/wp-content/uploads/2018/10/poppler-0.68.0_x86.7z'
                Media = Join-Path -Path $TempDir -ChildPath 'poppler-0.68.0_x86.7z'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'Poppler'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                    Rename-Item -Path (Join-Path -Path "${Directory}\.." -ChildPath 'poppler-0.68.0') -NewName $Directory
                }
            }
        }

        # ----------

        @{
            Name = 'SumatraPDF'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'SumatraPDF')
                )
            }
            Install = @{
                Uri = 'https://www.sumatrapdfreader.org/dl/SumatraPDF-3.1.2-64-install.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'SumatraPDF-3.1.2-64-install.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'SumatraPDF'
                Script = {
                    param($InstallMedia, $Directory)
                    & $InstallMedia
                }
            }
        }

        # ----------

        @{
            Name = 'Recoll'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'Recoll')
                )
            }
            Install = @{
                Uri = 'https://www.lesbonscomptes.com/recoll/downloads/downwin-29216b70/recoll-setup-1.25.22-20190827-8d156f50.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'recoll-setup-1.25.22-20190827-8d156f50.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'Recoll'
                Script = {
                    param($InstallMedia, $Directory)
                    & $InstallMedia
                }
            }
        }

        # ----------

        @{
            Name = 'WinDjView'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'WinDjView')
                )
            }
            Install = @{
                Uri = 'https://netix.dl.sourceforge.net/project/windjview/WinDjView/2.1/WinDjView-2.1-Setup.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'WinDjView-2.1-Setup.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'WinDjView'
                Script = {
                    param($InstallMedia, $Directory)
                    Write-Message -Install -Type Info -Message "Running installer: ${InstallMedia}"
                    & $InstallMedia
                }
            }
        }

        # ----------

        @{
            Name = 'DjVuLibre'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'DjVuLibre')
                )
            }
            Install = @{
                Uri = 'https://netcologne.dl.sourceforge.net/project/djvu/DjVuLibre_Windows/3.5.27%2B4.11/DjVuLibre-3.5.27_DjView-4.11_Setup.exe'
                Media = Join-Path -Path $TempDir -ChildPath 'DjVuLibre-3.5.27_DjView-4.11_Setup.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'DjVuLibre'
                Script = {
                    param($InstallMedia, $Directory)
                    Write-Message -Install -Type Info -Message "Running installer: ${InstallMedia}"
                    & $InstallMedia
                }
            }
        }

        # ----------

        @{
            Name = 'InkScape'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'InkScape')
                )
            }
            Install = @{
                Uri = 'https://inkscape.org/gallery/item/13317/inkscape-0.92.4-x64.7z'
                Media = Join-Path -Path $TempDir -ChildPath 'inkscape-0.92.4-x64.7z'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'InkScape'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}\..`""
                }
            }
        }

        # ----------

        @{
            Name = 'Emacs'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'Emacs')
                )
            }
            Install = @{
                Uri = 'http://ftp.task.gda.pl/pub/gnu/emacs/windows/emacs-26/emacs-26.3-x86_64.zip'
                Media = Join-Path -Path $TempDir -ChildPath 'emacs-26.3-x86_64.zip'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'Emacs'
                Script = {
                    param($InstallMedia, $Directory)
                    & $SevenZip x "`"${InstallMedia}`"" -o"`"${Directory}`""
                }
            }
        }

        # ----------

        @{
            Name = 'ScanTailor'
            Verify = @{
                Directory = @(
                    (Join-Path -Path $ProgramDir -ChildPath 'ScanTailor')
                )
            }
            Install = @{
                Uri = 'https://github-production-release-asset-2e65be.s3.amazonaws.com/18495032/1b62c9b6-bdb9-11e3-82e8-cc77f2ca071a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20191013%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20191013T205702Z&X-Amz-Expires=300&X-Amz-Signature=4c4270650108e5685729c99d6563437adcd4492b01f4c2638b01fc031f4309a4&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dscantailor-0.9.11.1-64bit-install.exe&response-content-type=application%2Foctet-stream'
                Media = Join-Path -Path $TempDir -ChildPath 'scantailor-0.9.11.1-64bit-install.exe'
                Directory = Join-Path -Path $ProgramDir -ChildPath 'ScanTailor'
                Script = {
                    param($InstallMedia, $Directory)
                    & $InstallMedia
                }
            }
        }

        # ----------

    )
}