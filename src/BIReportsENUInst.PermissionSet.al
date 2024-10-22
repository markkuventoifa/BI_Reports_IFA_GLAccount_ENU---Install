permissionset 66095 "BI Reports ENU Inst"
{
    Access = Internal;
    Assignable = true;
    Caption = 'BI_Reports_GLAccount_ENU_Install', Locked = true;

    Permissions =
         codeunit BIReportsGLAccountENUInstalIfe = X,
         codeunit BIReportsGLAccountENUUpgradIfe = X;
}