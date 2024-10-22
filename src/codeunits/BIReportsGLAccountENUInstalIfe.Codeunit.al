codeunit 66095 BIReportsGLAccountENUInstalIfe
{
    Subtype = Install;
    Permissions = tableData "G/L Account" = rm;

    trigger OnInstallAppPerCompany()
    begin
        // Code to perform company related table upgrade tasks
        if IsFreshInstall() then
            UpdateGLAccountENUNameComp();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", 'OnCompanyInitialize', '', false, false)]
    local procedure CompanyInitialize()
    begin
        // To run installation processes when new company is created.
        //UpdateGLAccountENUNameComp();
    end;

    procedure IsFreshInstall() FirstTimeInstall: Boolean
    var
        modulInfo: ModuleInfo;
    begin
        Clear(modulInfo);
        NavApp.GetCurrentModuleInfo(modulInfo); // Get info about the currently executing module
        // 'DataVersion' of 0.0.0.0 indicates a 'fresh/new' install
        firstTimeInstall := modulInfo.DataVersion() = Version.Create(0, 0, 0, 0);
        exit(FirstTimeInstall);
    end;

    procedure UpdateGLAccountENUNameComp()
    var
        GLAccount: Record "G/L Account";
    begin
        if GLAccount.FindSet() then
            repeat
                GLAccount.CalcFields("APS365 Translated Name");
                if GLAccount."APS365 Translated Name" <> '' then begin
                    GLAccount.ENUNameIfe := GLAccount."APS365 Translated Name";
                    GLAccount.Modify(false);
                end;
            until GLAccount.Next() = 0;
    end;

}
