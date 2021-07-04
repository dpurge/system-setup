
Task DownloadBasicTools `
    -description "Download installation media for basic tools" `
    -depends `
        GetBasicTools, `
        DownloadApplication

Task TestBasicTools `
    -description "Verify installation of basic tools" `
    -depends `
        GetBasicTools, `
        TestApplication

Task InstallBasicTools `
    -description "Install basic system tools" `
    -depends `
        InstallSystem, `
        GetBasicTools, `
        InstallApplication
    

Task DownloadDocumentTools `
    -description "Download installation media for document processing tools" `
    -depends `
        GetDocumentTools, `
        DownloadApplication

Task TestDocumentTools `
    -description "Verify installation of document processing tools" `
    -depends `
        GetDocumentTools, `
        TestApplication

Task InstallDocumentTools `
    -description "Install document processing tools" `
    -depends `
        InstallSystem, `
        GetDocumentTools, `
        InstallApplication


Task DownloadMediaTools `
    -description "Download installation files for media tools" `
    -depends `
        GetMediaTools, `
        DownloadApplication

Task TestMediaTools `
    -description "Verify installation of media tools" `
    -depends `
        GetMediaTools, `
        TestApplication

Task InstallMediaTools `
    -description "Install media tools" `
    -depends `
        InstallSystem, `
        GetMediaTools, `
        InstallApplication


Task DownloadLearningTools `
    -description "Download installation files for learning tools" `
    -depends `
        GetLearningTools, `
        DownloadApplication

Task TestLearningTools `
    -description "Verify installation of learning tools" `
    -depends `
        GetLearningTools, `
        TestApplication

Task InstallLearningTools `
    -description "Install learning tools" `
    -depends `
        InstallSystem, `
        GetLearningTools, `
        InstallApplication
    

Task DownloadProgrammingTools `
    -description "Download installation media for application development tools" `
    -depends `
        GetProgrammingTools, `
        DownloadApplication

Task TestProgrammingTools `
    -description "Verify installation of application development tools" `
    -depends `
        GetProgrammingTools, `
        TestApplication

Task InstallProgrammingTools `
    -description "Install application development tools" `
    -depends `
        InstallSystem, `
        GetProgrammingTools, `
        InstallApplication


Task DownloadOtherTools `
    -description "Download other miscelaneous tools" `
    -depends `
        GetOtherTools, `
        DownloadApplication

Task TestOtherTools `
    -description "Verify installation of other miscelaneous tools" `
    -depends `
        GetOtherTools, `
        TestApplication

Task InstallOtherTools `
    -description "Install other miscelaneous tools" `
    -depends `
        InstallSystem, `
        GetOtherTools, `
        InstallApplication


Task DownloadEverything `
    -description "Download everything" `
    -depends `
        GetBasicTools, `
        GetDocumentTools, `
        GetMediaTools, `
        GetLearningTools, `
        GetProgrammingTools, `
        GetOtherTools, `
        DownloadApplication

Task TestEverything `
    -description "Verify installation of everything" `
    -depends `
        TestSystem, `
        GetBasicTools, `
        GetDocumentTools, `
        GetMediaTools, `
        GetLearningTools, `
        GetProgrammingTools, `
        GetOtherTools, `
        TestApplication

Task InstallEverything `
    -description "Install everything" `
    -depends `
        InstallSystem, `
        GetBasicTools, `
        GetDocumentTools, `
        GetMediaTools, `
        GetLearningTools, `
        GetProgrammingTools, `
        GetOtherTools, `
        InstallApplication
