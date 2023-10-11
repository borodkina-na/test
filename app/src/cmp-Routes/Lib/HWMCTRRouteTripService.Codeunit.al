/// <summary>
/// Component: Routes
/// </summary>
codeunit 50008 "HWM CTR Route Trip Service"
{
    Subtype = Normal;

    var
        mRoute: Codeunit "HWM CTR Route Management";
        sCommon: Codeunit "HWM CTR Common Service";
        RouteTrip: Record "HWM CTR Route Trip";
        HasRouteTrip: Boolean;
        GlobalNo: Integer;
        GlobalStatusIsSet: Boolean;
        GlobalStatus: Enum "HWM CTR Status";
        GlobalProcessingStatusIsSet: Boolean;
        GlobalProcessingStatus: Enum "HWM CTR Process Status";
        ErrorRouteTripIsNotSetUp: Label 'Route Trip is not initialized. Use SetByPK function first.';
        ErrorVarIsEmpty: Label '%1 is empty';

    /// <summary>
    /// SetByPK.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    /// <param name="TripSequenceNo">Integer.</param>    
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(RouteNo: Code[10]; TripSequenceNo: Integer): Boolean
    begin
        if HasRouteTrip and (RouteTrip."Route No." = RouteNo) and (RouteTrip."Trip Sequence No." = TripSequenceNo) then
            exit(true);
        HasRouteTrip := RouteTrip.Get(RouteNo, TripSequenceNo);
        exit(HasRouteTrip);
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
    /// <param name="RecBuffer">VAR Record "HWM CTR Route Trip".</param>
    procedure InitBufferByGetSet(var RecBuffer: Record "HWM CTR Route Trip")
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        //TODO: test SetRouteTrip

        if GetSetOfRec(RouteTrip) then begin
            RouteTrip.FindSet(false);
            repeat
                RecBuffer.Init();
                RecBuffer.TransferFields(RouteTrip, true);
                RecBuffer.Insert(false);
            until RouteTrip.Next() = 0;
        end;
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasRouteTrip then
            Error(ErrorRouteTripIsNotSetUp);
        exit(RouteTrip.Status = RouteTrip.Status::Active)
    end;
    /// <summary>
    /// ExistRec.
    /// </summary>
    /// <returns>Return variable ExistRouteTrip of type Boolean.</returns>
    procedure ExistRec() ExistRouteTrip: Boolean
    begin
        ExistRouteTrip := (not RouteTrip.IsEmpty);
    end;
    /// <summary>
    /// ExistByPK.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    /// <param name="RouteSeqNo">Integer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ExistByPK(RouteNo: Code[10]; RouteSeqNo: Integer): Boolean
    begin
        sCommon.TestEmpty(RouteNo, 'RouteNo');
        sCommon.TestEmpty(RouteSeqNo, 'RouteSeqNo');
        exit(RouteTrip.Get(RouteNo, RouteSeqNo));
    end;
    /// <summary>
    /// OpenCard.
    /// </summary>
    procedure OpenCard()
    var
        Card: Page "HWM CTR Route Trip Card";
        Route: Record "HWM CTR Route Trip";
    begin
        if GetSetOfRec(RouteTrip) then begin
            RouteTrip.FindSet(false);
        end;
        Card.SetTableView(RouteTrip);
        Card.Run();
    end;
    /// <summary>
    /// OpenList.
    /// </summary>
    procedure OpenList()
    var
        RouteTripList: Page "HWM CTR Route Trip List";
        Route: Record "HWM CTR Route Trip";
    begin
        if GetSetOfRec(RouteTrip) then begin
            RouteTrip.FindSet(false);
        end;
        RouteTripList.SetTableView(RouteTrip);
        RouteTripList.Run();
    end;
    /// <summary>
    /// LookupRec.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    procedure LookupRec(var RouteTrip: Record "HWM CTR Route Trip")
    var
        RouteTripList: Page "HWM CTR Route Trip List";
    begin
        if GetSetOfRec(RouteTrip) then
            RouteTrip.FindSet(false);

        RouteTripList.SetTableView(RouteTrip);
        RouteTripList.LookupMode(true);
        if RouteTripList.RunModal() = ACTION::LookupOK then begin
            RouteTripList.GetRecord(RouteTrip);
        end;
    end;
    /// <summary>
    /// LookupTripSequenceNo.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure LookupTripSequenceNo(): Integer
    var
        RouteTripList: Page "HWM CTR Route Trip List";
        RouteTrip: Record "HWM CTR Route Trip";
    begin
        if GetSetOfRec(RouteTrip) then
            RouteTrip.FindSet(false);

        RouteTripList.SetTableView(RouteTrip);
        RouteTripList.LookupMode(true);
        if RouteTripList.RunModal() = ACTION::LookupOK then begin
            RouteTripList.GetRecord(RouteTrip);
            exit(RouteTrip."Trip Sequence No.");
        end;
    end;
    /// <summary>
    /// GetLastTripSequenceNo.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>    
    /// <returns>Return value of type Integer.</returns>
    procedure GetLastTripSequenceNo(RouteNo: Code[10]): Integer
    var
        RouteTrip: Record "HWM CTR Route Trip";
    begin
        RouteTrip.Reset();
        RouteTrip.SetCurrentKey("Route No.", "Trip Sequence No.");
        RouteTrip.SetRange("Route No.", RouteNo);
        if RouteTrip.FindLast() then
            exit(RouteTrip."Trip Sequence No.");
    end;
    /// <summary>
    /// GetTripSequenceNo.
    /// </summary>
    /// <returns>Return variable RouteTripNo of type Code[10].</returns>
    procedure GetTripSequenceNo() RouteTripNo: Integer
    begin
        if not HasRouteTrip then
            Error(ErrorRouteTripIsNotSetUp);
        exit(RouteTrip."Trip Sequence No.");
    end;
    /// <summary>
    /// GetSetOfRec.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    /// <returns>Return variable RecordExist of type Boolean.</returns>
    procedure GetSetOfRec(var RouteTrip: Record "HWM CTR Route Trip") RecordExist: Boolean
    begin
        RouteTrip.Reset();
        ApplyFiltersForTripNo(RouteTrip);
        ApplyFiltersForStatus(RouteTrip);
        ClearFilters();
        exit(not RouteTrip.IsEmpty);
    end;

    local procedure ApplyFiltersForTripNo(var RouteTrip: Record "HWM CTR Route Trip")
    begin
        if GlobalNo = 0 then
            exit;

        RouteTrip.SetCurrentKey("Route No.", "Trip Sequence No.");
        RouteTrip.SetRange("Trip Sequence No.", GlobalNo);
    end;

    local procedure ApplyFiltersForStatus(var RouteTrip: Record "HWM CTR Route Trip")
    begin
        if not GlobalStatusIsSet then
            exit;

        RouteTrip.SetCurrentKey("Status");
        RouteTrip.SetRange("Status", GlobalStatus);
    end;

    local procedure ApplyFiltersForProcessingStatus(var RouteTrip: Record "HWM CTR Route Trip")
    begin
        if not GlobalProcessingStatusIsSet then
            exit;

        RouteTrip.SetCurrentKey("Processing Status");
        RouteTrip.SetRange("Processing Status", GlobalProcessingStatus);
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
    /// <param name="NewNo">Integer.</param>    
    procedure SetRangeNo(NewNo: Integer)
    begin
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
    /// <param name="RecBuffer">VAR Record "HWM CTR Route Trip".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of Integer.</returns>
    procedure CreateOrModifyList(var RecBuffer: Record "HWM CTR Route Trip"; RunTrigger: Boolean) NoList: List of [Integer]
    begin
        NoList := mRoute.CreateOrModifyRouteTripList(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// CreateOrModifySingle.
    /// </summary>
    /// <param name="RecBuffer">Record "HWM CTR Route Trip".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable RouteTripNo of type Integer.</returns>
    procedure CreateOrModifySingle(RecBuffer: Record "HWM CTR Route Trip"; RunTrigger: Boolean) RouteTripNo: Integer
    begin
        RouteTripNo := mRoute.CreateOrModifySingleRouteTrip(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// DeleteByPK.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    /// <param name="RouteTripNo">Integer.</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteByPK(RouteNo: Code[10]; RouteTripNo: Integer; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        RouteTrip: Record "HWM CTR Route Trip";
        IsHandled: Boolean;
    begin
        sCommon.TestEmpty(RouteTripNo, 'RouteTripNo');

        OnBeforeDeleteRouteTrip(RouteTrip, RunTrigger, IsHandled);
        if IsHandled then
            exit;
        mRoute.DeleteSingleRouteTrip(RouteNo, RouteTripNo, SuppressDialog, RunTrigger);
        OnAfterDeleteRouteTrip(RouteTrip, RunTrigger);
    end;
    /// <summary>
    /// OnBeforeDeleteRouteTrip.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnBeforeDeleteRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var RunTrigger: Boolean; IsHandled: Boolean)
    begin

    end;
    /// <summary>
    /// OnAfterDeleteRouteTrip.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterDeleteRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var RunTrigger: Boolean)
    begin

    end;
}