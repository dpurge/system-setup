Task GetProgrammingTools `
    -description "Install application development tools" `
    -requiredVariable `
        ProgramDir, TempDir, SevenZip `
{

    $apps = @(
        'Git'
        'VSCode'
        'VisualStudio'
        'Python'
        'NodeJS'
        'GoLang'
        'AndroidStudio'
        'DartSDK'
        'Flutter'
    )

    foreach ($app in $apps) {
        $Script:Applications += . "$PsScriptRoot\..\application\${app}.ps1"
    }

    <#
    'https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_windows-x64_bin.zip'
    #>
}