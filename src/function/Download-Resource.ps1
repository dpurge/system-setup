function Download-Resource {
    param (
        [Parameter(Mandatory=$true)]
        [string] $uri,

        [Parameter(Mandatory=$true)]
        [string] $output
    )

    if (Test-Path -Path $output) {
        Write-Message -download -Type Success -Message "Download resource already exists: ${output}"
    } else {
        $WebClient = New-Object System.Net.WebClient
        Write-Message -download -Type Info -Message "Downloading: ${uri}"
        $WebClient.DownloadFile($uri, $output)
        if (Test-Path -Path $output) {
            Write-Message -download -Type Success -Message "Resource downloaded: ${output}"
        }
    }
}