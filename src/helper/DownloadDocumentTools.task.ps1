Task DownloadDocumentTools `
    -description "Download tools for processing documents" `
    -depends `
        CreateWorkDirectory `
    -requiredVariable `
        TempDir `
{
    foreach ($uri in @(
        'https://www.mupdf.com/downloads/archive/mupdf-1.16.0-windows.zip'
        'https://www.sumatrapdfreader.org/dl/SumatraPDF-3.1.2-64.zip'
        'https://netix.dl.sourceforge.net/project/windjview/WinDjView/2.1/WinDjView-2.1-Setup.exe'
        'https://netcologne.dl.sourceforge.net/project/djvu/DjVuLibre_Windows/3.5.27%2B4.11/DjVuLibre-3.5.27_DjView-4.11_Setup.exe'
        'https://inkscape.org/gallery/item/13317/inkscape-0.92.4-x64.7z'
        'http://ftp.task.gda.pl/pub/gnu/emacs/windows/emacs-26/emacs-26.3-x86_64.zip'
        'https://apps.ankiweb.net/downloads/current/anki-2.1.15-windows.exe'
        'https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20191004-e6625ca-win64-static.zip'
        'https://ftp.icm.edu.pl/pub/video/vlc/vlc/3.0.8/win64/vlc-3.0.8-win64.exe'
        'https://www.lesbonscomptes.com/recoll/downloads/downwin-29216b70/recoll-setup-1.25.22-20190827-8d156f50.exe'
        'https://www.foobar2000.org/files/edcaa07128d5bb8485a19ff8edfb48c5/foobar2000_v1.4.8.exe'
    )) {
        $filename = Split-Path -Path $uri -Leaf
        Download-Resource -uri $uri -output "${TempDir}\${filename}"
    }
}
