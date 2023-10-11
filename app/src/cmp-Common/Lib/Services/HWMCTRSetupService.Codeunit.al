/// <summary>
/// Component: Common
/// </summary>
codeunit 50005 "HWM CTR Setup Service"
{
    var
        mSetup: Codeunit "HWM CTR Setup Management";
        GlobalSetup: Record "HWM CTR Setup";
        HasSetup: Boolean;

    /// <summary>
    /// CreateSetup.
    /// </summary>
    procedure SetSetup()
    begin
        if not GlobalSetup.Get() then
            mSetup.CreateSetup();
        GetSetup(GlobalSetup);
    end;
    /// <summary>
    /// GetSetup.
    /// </summary>
    /// <param name="Setup">VAR Record "HWM SPC Setup".</param>
    procedure GetSetup(var Setup: Record "HWM CTR Setup")
    begin
        if not HasSetup then
            GlobalSetup.Get();

        Setup := GlobalSetup;
    end;
    /// <summary>
    /// GetRouteNos.
    /// </summary>
    /// <param name="DoTestField">Boolean.</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetRouteNos(DoTestField: Boolean): Code[20]
    begin
        if not HasSetup then
            GlobalSetup.Get();
        if DoTestField then
            GlobalSetup.TestField("Route Nos.");
        exit(GlobalSetup."Route Nos.");
    end;
    /// <summary>
    /// GetCateringOrderNos.
    /// </summary>
    /// <param name="DoTestField">Boolean.</param>
    /// <returns>Return value of type Code[20].</returns>    
    procedure GetCateringOrderNos(DoTestField: Boolean): Code[20]
    begin
        if not HasSetup then
            GlobalSetup.Get();
        if DoTestField then
            GlobalSetup.TestField("Catering Order Nos.");
        exit(GlobalSetup."Catering Order Nos.");
    end;
    /// <summary>
    /// GetLoadingNos.
    /// </summary>
    /// <param name="DoTestField">Boolean.</param>
    /// <returns>Return value of type Code[20].</returns>    
    procedure GetLoadingNos(DoTestField: Boolean): Code[20]
    begin
        if not HasSetup then
            GlobalSetup.Get();
        if DoTestField then
            GlobalSetup.TestField("Loading Nos.");
        exit(GlobalSetup."Loading Nos.");
    end;
}