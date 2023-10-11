/// <summary>
/// Component: Routes
/// </summary>
codeunit 50015 "HWM CTR Route Point Service"
{
    Subtype = Normal;

    var
        mRoute: Codeunit "HWM CTR Route Management";
        sCommon: Codeunit "HWM CTR Common Service";
        RoutePoint: Record "HWM CTR Route Point";
        HasRoutePoint: Boolean;
        GlobalNo: Code[10];
        GlobalStatusIsSet: Boolean;
        GlobalStatus: Enum "HWM CTR Status";
        GlobalProcessingStatusIsSet: Boolean;
        GlobalProcessingStatus: Enum "HWM CTR Process Status";
        ErrorIsNotSetUp: Label 'Route Point is not initialized. Use SetRoutePoint function first.';

    /// <summary>
    /// SetRoutePoint.
    /// </summary>
    /// <param name="PointCode">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetRoutePoint(PointCode: Code[10]): Boolean
    begin
        sCommon.TestEmpty(PointCode, 'No');
        if HasRoutePoint and (RoutePoint.Code = PointCode) then
            exit(true);
        HasRoutePoint := RoutePoint.Get(PointCode);
        exit(HasRoutePoint);
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

        if GetSetOfRec(RoutePoint) then begin
            RoutePoint.FindSet(false);
            repeat
                RecBuffer.Init();
                RecBuffer.TransferFields(RoutePoint, true);
                RecBuffer.Insert(false);
            until RoutePoint.Next() = 0;
        end;
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasRoutePoint then
            Error(ErrorIsNotSetUp);
        exit(RoutePoint.Status = RoutePoint.Status::Active)
    end;
    /// <summary>
    /// ExistRec.
    /// </summary>
    /// <returns>Return variable ExistRec of type Boolean.</returns>
    procedure ExistRec() ExistRec: Boolean
    var
        RoutePoint: Record "HWM CTR Route Point";
    begin
        ExistRec := GetSetOfRec(RoutePoint);
    end;
    /// <summary>
    /// ExistByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ExistByNo(No: Code[10]): Boolean
    var
        RoutePoint: Record "HWM CTR Route Point";
    begin
        exit(RoutePoint.Get(No));
    end;
    /// <summary>
    /// OpenCard.
    /// </summary>
    procedure OpenCard()
    var
        Card: Page "HWM CTR Route Point Card";
        RoutePoint: Record "HWM CTR Route Point";
    begin
        if GetSetOfRec(RoutePoint) then begin
            RoutePoint.FindSet(false);
        end;
        Card.SetTableView(RoutePoint);
        Card.Run();
    end;
    /// <summary>
    /// OpenList.
    /// </summary>
    procedure OpenList()
    var
        RoutePointList: Page "HWM CTR Route Point List";
        RoutePoint: Record "HWM CTR Route Point";
    begin
        if GetSetOfRec(RoutePoint) then begin
            RoutePoint.FindSet(false);
        end;
        RoutePointList.SetTableView(RoutePoint);
        RoutePointList.Run();
    end;
    /// <summary>
    /// LookupRec.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    procedure LookupRec(var RoutePoint: Record "HWM CTR Route Point")
    var
        RoutePointList: Page "HWM CTR Route Point List";
    begin
        if GetSetOfRec(RoutePoint) then
            RoutePoint.FindSet(false);

        RoutePointList.SetTableView(RoutePoint);
        RoutePointList.LookupMode(true);
        if RoutePointList.RunModal() = ACTION::LookupOK then begin
            RoutePointList.GetRecord(RoutePoint);
        end;
    end;
    /// <summary>
    /// LookupNo.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure LookupNo(): Code[10]
    var
        RoutePointList: Page "HWM CTR Route Point List";
        RoutePoint: Record "HWM CTR Route Point";
    begin
        if GetSetOfRec(RoutePoint) then
            RoutePoint.FindSet(false);

        RoutePointList.SetTableView(RoutePoint);
        RoutePointList.LookupMode(true);
        if RoutePointList.RunModal() = ACTION::LookupOK then begin
            RoutePointList.GetRecord(RoutePoint);
            exit(RoutePoint.Code);
        end;
    end;
    /// <summary>
    /// GetNo.
    /// </summary>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure GetNo() No: Code[10]
    begin
        if not HasRoutePoint then
            Error(ErrorIsNotSetUp);
        exit(RoutePoint.Code);
    end;

    /// <summary>
    /// GetSetOfRec.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    /// <returns>Return variable RecordExist of type Boolean.</returns>
    procedure GetSetOfRec(var RoutePoint: Record "HWM CTR Route Point") RecordExist: Boolean
    begin
        RoutePoint.Reset();
        ApplyFiltersForNo(RoutePoint);
        ApplyFiltersForStatus(RoutePoint);
        ClearFilters();
        exit(not RoutePoint.IsEmpty);
    end;

    local procedure ApplyFiltersForNo(var RoutePoint: Record "HWM CTR Route Point")
    begin
        if GlobalNo = '' then
            exit;

        RoutePoint.SetCurrentKey(Code);
        RoutePoint.SetRange(Code, GlobalNo);
    end;

    local procedure ApplyFiltersForStatus(var RoutePoint: Record "HWM CTR Route Point")
    begin
        if not GlobalStatusIsSet then
            exit;

        RoutePoint.SetCurrentKey(Status, "Processing Status");
        RoutePoint.SetRange("Status", GlobalStatus);
    end;

    local procedure ApplyFiltersForProcessingStatus(var RoutePoint: Record "HWM CTR Route Point")
    begin
        if not GlobalProcessingStatusIsSet then
            exit;

        RoutePoint.SetCurrentKey(Status, "Processing Status");
        RoutePoint.SetRange("Processing Status", GlobalProcessingStatus);
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
    /// <param name="RecBuffer">VAR Record "HWM CTR Route Point".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable RoutePointNoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyList(var RecBuffer: Record "HWM CTR Route Point"; RunTrigger: Boolean) NoList: List of [Code[10]]
    begin
        NoList := mRoute.CreateOrModifyRoutePointList(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// CreateOrModifySingle.
    /// </summary>
    /// <param name="RecBuffer">Record "HWM CTR Route Point".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure CreateOrModifySingle(RecBuffer: Record "HWM CTR Route Point"; RunTrigger: Boolean) No: Code[10]
    begin
        No := mRoute.CreateOrModifySingleRoutePoint(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// DeleteByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteByNo(No: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        RoutePoint: Record "HWM CTR Route Point";
        IsHandled: Boolean;
    begin
        sCommon.TestEmpty(No, 'No');

        OnBeforeDeleteRoutePoint(RoutePoint, RunTrigger, IsHandled);
        if IsHandled then
            exit;
        mRoute.DeleteSingleRoutePoint(No, SuppressDialog, RunTrigger);
        OnAfterDeleteRoutePoint(RoutePoint, RunTrigger);
    end;
    /// <summary>
    /// OnBeforeDeleteRoutePoint.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM SPC Route Point".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnBeforeDeleteRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var RunTrigger: Boolean; IsHandled: Boolean)
    begin

    end;
    /// <summary>
    /// OnAfterDeleteRoutePoint.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterDeleteRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var RunTrigger: Boolean)
    begin

    end;
}