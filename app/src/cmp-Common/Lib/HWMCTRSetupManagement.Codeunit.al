/// <summary>
/// Component: Common
/// </summary>
codeunit 50002 "HWM CTR Setup Management"
{
    var
        Setup: Record "HWM CTR Setup";

    /// <summary>
    /// CreateSetup.
    /// </summary>
    procedure CreateSetup()
    begin
        if not Setup.Get() then begin
            Setup.Init();
            Setup.Insert(true);
        end;
    end;
}