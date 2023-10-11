/// <summary>
/// Component: Common
/// </summary>
codeunit 50001 "HWM Translation Install"
{
    Subtype = Install;

    var
        mSetup: Codeunit "HWM CTR Setup Management";

    trigger OnInstallAppPerCompany()
    begin
        mSetup.CreateSetup();
    end;

    trigger OnInstallAppPerDatabase()
    begin
    end;
}