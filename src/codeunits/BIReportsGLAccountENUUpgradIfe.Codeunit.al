codeunit 66096 BIReportsGLAccountENUUpgradIfe
{
    Subtype = Upgrade;
    Permissions = tableData "G/L Account" = rm;

    trigger OnUpgradePerCompany()
    begin
        UpdateGLAccountENUNameComp();
    end;

    procedure UpdateGLAccountENUNameComp()
    var
        GLAccount: Record "G/L Account";
    begin
        GLAccount.SetRange(ENUNameIfe, '');
        //GLAccount.SetRange("APS365 Lang. Code Filter",'ENU');
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
