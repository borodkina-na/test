/// <summary>
/// Component: Routes
/// </summary>
codeunit 50007 "HWM CTR Route Service"
{
    Subtype = Normal;

    var
        mRoute: Codeunit "HWM CTR Route Management";
        sCommon: Codeunit "HWM CTR Common Service";
        Route: Record "HWM CTR Route";
        HasRoute: Boolean;
        GlobalNo: Code[10];
        GlobalStatusIsSet: Boolean;
        GlobalStatus: Enum "HWM CTR Status";
        GlobalProcessingStatusIsSet: Boolean;
        GlobalProcessingStatus: Enum "HWM CTR Process Status";
        ErrorRouteIsNotSetUp: Label 'Route is not initialized. Use SetRoute function first.';

    /// <summary>
    /// SetRoute.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetRoute(RouteNo: Code[10]): Boolean
    begin
        sCommon.TestEmpty(RouteNo, 'RouteNo');
        if HasRoute and (Route."No." = RouteNo) then
            exit(true);
        HasRoute := Route.Get(RouteNo);
        exit(HasRoute);
    end;
    /// <summary>
    /// ClearRec.
    /// </summary>
    procedure ClearRec()
    begin
        ClearAll();
    end;
    /// <summary>
    /// InitBufferByGetSet.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Route".</param>
    procedure InitBufferByGetSet(var RecBuffer: Record "HWM CTR Route")
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        //TODO: test SetRoute

        if GetSetOfRec(Route) then begin
            Route.FindSet(false);
            repeat
                RecBuffer.Init();
                RecBuffer.TransferFields(Route, true);
                RecBuffer.Insert(false);
            until Route.Next() = 0;
        end;
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasRoute then
            Error(ErrorRouteIsNotSetUp);
        exit(Route.Status = Route.Status::Active)
    end;
    /// <summary>
    /// ExistRec.
    /// </summary>
    /// <returns>Return variable ExistRoute of type Boolean.</returns>
    procedure ExistRec() ExistRoute: Boolean
    var
        Route: Record "HWM CTR Route";
    begin
        ExistRoute := GetSetOfRec(Route);
    end;
    /// <summary>
    /// ExistByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ExistByNo(No: Code[10]): Boolean
    var
        Route: Record "HWM CTR Route";
    begin
        exit(Route.Get(No));
    end;
    /// <summary>
    /// OpenCard.
    /// </summary>
    procedure OpenCard()
    var
        Card: Page "HWM CTR Route Card";
        Route: Record "HWM CTR Route";
    begin
        if GetSetOfRec(Route) then begin
            Route.FindSet(false);
        end;
        Card.SetTableView(Route);
        Card.Run();
    end;
    /// <summary>
    /// OpenList.
    /// </summary>
    procedure OpenList()
    var
        RouteList: Page "HWM CTR Route List";
        Route: Record "HWM CTR Route";
    begin
        if GetSetOfRec(Route) then begin
            Route.FindSet(false);
        end;
        RouteList.SetTableView(Route);
        RouteList.Run();
    end;
    /// <summary>
    /// LookupRec.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    procedure LookupRec(var Route: Record "HWM CTR Route")
    var
        RouteList: Page "HWM CTR Route List";
    begin
        if GetSetOfRec(Route) then
            Route.FindSet(false);

        RouteList.SetTableView(Route);
        RouteList.LookupMode(true);
        if RouteList.RunModal() = ACTION::LookupOK then begin
            RouteList.GetRecord(Route);
        end;
    end;
    /// <summary>
    /// LookupNo.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure LookupNo(): Code[10]
    var
        RouteList: Page "HWM CTR Route List";
        Route: Record "HWM CTR Route";
    begin
        if GetSetOfRec(Route) then
            Route.FindSet(false);

        RouteList.SetTableView(Route);
        RouteList.LookupMode(true);
        if RouteList.RunModal() = ACTION::LookupOK then begin
            RouteList.GetRecord(Route);
            exit(Route."No.");
        end;
    end;
    /// <summary>
    /// GetNewNo.
    /// </summary>
    /// <returns>Return variable NewRouteNo of type Code[10].</returns>
    procedure GetNewNo() NewNo: Code[10]
    var
        Setup: Record "HWM CTR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        Setup.Get();
        Setup.TestField("Route Nos.");
        NoSeriesMgt.InitSeries(Setup."Route Nos.", Setup."Route Nos.", 0D, NewNo, Setup."Route Nos.");
    end;
    /// <summary>
    /// GetNo.
    /// </summary>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure GetNo() No: Code[10]
    begin
        if not HasRoute then
            Error(ErrorRouteIsNotSetUp);
        exit(Route."No.");
    end;

    /// <summary>
    /// GetSetOfRec.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    /// <returns>Return variable RecordExist of type Boolean.</returns>
    procedure GetSetOfRec(var Route: Record "HWM CTR Route") RecordExist: Boolean
    begin
        Route.Reset();
        ApplyFiltersForNo(Route);
        ApplyFiltersForStatus(Route);
        ClearFilters();
        exit(not Route.IsEmpty);
    end;

    local procedure ApplyFiltersForNo(var Route: Record "HWM CTR Route")
    begin
        if GlobalNo = '' then
            exit;

        Route.SetCurrentKey("No.");
        Route.SetRange("No.", GlobalNo);
    end;

    local procedure ApplyFiltersForStatus(var Route: Record "HWM CTR Route")
    begin
        if not GlobalStatusIsSet then
            exit;

        Route.SetCurrentKey(Status, "Processing Status");
        Route.SetRange("Status", GlobalStatus);
    end;

    local procedure ApplyFiltersForProcessingStatus(var Route: Record "HWM CTR Route")
    begin
        if not GlobalProcessingStatusIsSet then
            exit;

        Route.SetCurrentKey(Status, "Processing Status");
        Route.SetRange("Processing Status", GlobalProcessingStatus);
    end;

    /// <summary>
    /// SetRangeStatus.
    /// </summary>
    /// <param name="NewStatus">Enum "HWM CTR Status".</param>
    procedure SetRangeStatus(NewStatus: Enum "HWM CTR Status")
    begin
        GlobalStatus := NewStatus;
        GlobalStatusIsSet := true;
    end;
    /// <summary>
    /// SetRangeProcessingStatus.
    /// </summary>
    /// <param name="NewStatus">Enum "HWM CTR Process Status".</param>
    procedure SetRangeProcessingStatus(NewStatus: Enum "HWM CTR Process Status")
    begin
        GlobalProcessingStatus := NewStatus;
        GlobalProcessingStatusIsSet := true;
    end;
    /// <summary>
    /// SetRangeNo.
    /// </summary>
    /// <param name="NewNo">Code[10].</param>
    procedure SetRangeNo(NewNo: Code[10])
    begin
        sCommon.TestEmpty(NewNo, 'NewNo');
        GlobalNo := NewNo;
    end;

    local procedure ClearFilters()
    begin
        Clear(GlobalNo);
        Clear(GlobalStatusIsSet);
        Clear(GlobalProcessingStatusIsSet);
    end;
    /// <summary>
    /// CreateOrModifyList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Route".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable RouteNoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyList(var RecBuffer: Record "HWM CTR Route"; RunTrigger: Boolean) NoList: List of [Code[10]]
    begin
        NoList := mRoute.CreateOrModifyRouteList(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// CreateOrModifySingle.
    /// </summary>
    /// <param name="RecBuffer">Record "HWM CTR Route".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable PersonNo of type Code[10].</returns>
    procedure CreateOrModifySingle(RecBuffer: Record "HWM CTR Route"; RunTrigger: Boolean) RouteNo: Code[10]
    begin
        RouteNo := mRoute.CreateOrModifySingleRoute(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// DeleteByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteByNo(No: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        Route: Record "HWM CTR Route";
        IsHandled: Boolean;
    begin
        sCommon.TestEmpty(No, 'RouteNo');

        OnBeforeDeleteRoute(Route, RunTrigger, IsHandled);
        if IsHandled then
            exit;
        mRoute.DeleteSingleRoute(No, SuppressDialog, RunTrigger);
        OnAfterDeleteRoute(Route, RunTrigger);
    end;
    /// <summary>
    /// OnBeforeDeleteRoute.
    /// </summary>
    /// <param name="Route">VAR Record "HWM SPC Person".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnBeforeDeleteRoute(var Route: Record "HWM CTR Route"; var RunTrigger: Boolean; IsHandled: Boolean)
    begin

    end;
    /// <summary>
    /// OnAfterDeleteRoute.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterDeleteRoute(var Route: Record "HWM CTR Route"; var RunTrigger: Boolean)
    begin

    end;
}