/// <summary>
/// Component: CateringOrders
/// </summary>
codeunit 50017 "HWM CTR Cat.Order Trip Service"
{
    Subtype = Normal;

    var
        mCateringOrder: Codeunit "HWM CTR Catering Order Mngt.";
        sCommon: Codeunit "HWM CTR Common Service";
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
        HasCateringOrderTrip: Boolean;
        GlobalCateringOrderNo: Code[10];
        GlobalDeparturePointCode: Code[20];
        GlobalArrivalPointCode: Code[20];
        GlobalStatusIsSet: Boolean;
        GlobalStatus: Enum "HWM CTR Status";
        GlobalProcessingStatusIsSet: Boolean;
        GlobalProcessingStatus: Enum "HWM CTR Process Status";
        ErrorRecIsNotSetUp: Label 'Catering Order Trip is not initialized. Use SetCateringOrderTrip function first.';

    /// <summary>
    /// SetByPK.
    /// </summary>
    /// <param name="CateringOrderNo">Code[10].</param>
    /// <param name="PointOfDepartureCode">Code[10].</param>
    /// <param name="PointOfArrivalCode">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(CateringOrderNo: Code[10]; PointOfDepartureCode: Code[20]; PointOfArrivalCode: Code[20]): Boolean
    begin
        sCommon.TestEmpty(CateringOrderNo, 'CateringOrderNo');
        sCommon.TestEmpty(PointOfDepartureCode, 'DeparturePointCode');
        sCommon.TestEmpty(PointOfArrivalCode, 'ArrivalPointCode');
        if HasCateringOrderTrip
            and (CateringOrderTrip."Catering Order No." = CateringOrderNo)
            and (CateringOrderTrip."Point of Departure Code" = PointOfDepartureCode)
            and (CateringOrderTrip."Point of Arrival Code" = PointOfArrivalCode) then
            exit(true);
        HasCateringOrderTrip := CateringOrderTrip.Get(CateringOrderNo, PointOfDepartureCode, PointOfArrivalCode);
        exit(HasCateringOrderTrip);
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
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order Trip".</param>
    procedure InitBufferByGetSet(var RecBuffer: Record "HWM CTR Catering Order Trip")
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        if GetSetOfRec(CateringOrderTrip) then begin
            CateringOrderTrip.FindSet(false);
            repeat
                RecBuffer.Init();
                RecBuffer.TransferFields(CateringOrderTrip, true);
                RecBuffer.Insert(false);
            until CateringOrderTrip.Next() = 0;
        end;
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasCateringOrderTrip then
            Error(ErrorRecIsNotSetUp);
        exit(CateringOrderTrip.Status = CateringOrderTrip.Status::Active)
    end;
    /// <summary>
    /// ExistRec.
    /// </summary>
    /// <returns>Return variable ExistRec of type Boolean.</returns>
    procedure ExistRec() ExistRec: Boolean
    var
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
    begin
        ExistRec := GetSetOfRec(CateringOrderTrip);
    end;
    /// <summary>
    /// ExistByPK.
    /// </summary>
    /// <param name="CateringOrderNo">Code[10].</param>
    /// <param name="DeparturePointCode">Code[20].</param>
    /// <param name="ArrivalPointCode">Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ExistByPK(CateringOrderNo: Code[10]; DeparturePointCode: Code[20]; ArrivalPointCode: Code[20]): Boolean
    var
        CateringOrderTrip: Record "HWM CTR Catering Order";
    begin
        exit(CateringOrderTrip.Get(CateringOrderNo, DeparturePointCode, ArrivalPointCode));
    end;
    /// <summary>
    /// OpenList.
    /// </summary>
    procedure OpenList()
    var
        CateringOrderTripList: Page "HWM CTR Catering Order Trip L";
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
    begin
        if GetSetOfRec(CateringOrderTrip) then begin
            CateringOrderTrip.FindSet(false);
        end;
        CateringOrderTripList.SetTableView(CateringOrderTrip);
        CateringOrderTripList.Run();
    end;
    /// <summary>
    /// LookupRec.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order Trip".</param>
    procedure LookupRec(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    var
        CateringOrderTripList: Page "HWM CTR Catering Order Trip L";
    begin
        if GetSetOfRec(CateringOrderTrip) then
            CateringOrderTrip.FindSet(false);

        CateringOrderTripList.SetTableView(CateringOrderTrip);
        CateringOrderTripList.LookupMode(true);
        if CateringOrderTripList.RunModal() = ACTION::LookupOK then begin
            CateringOrderTripList.GetRecord(CateringOrderTrip);
        end;
    end;
    /// <summary>
    /// LookupNo.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure LookupNo(): Code[10]
    var
        CateringOrderTripList: Page "HWM CTR Catering Order Trip L";
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
    begin
        if GetSetOfRec(CateringOrderTrip) then
            CateringOrderTrip.FindSet(false);

        CateringOrderTripList.SetTableView(CateringOrderTrip);
        CateringOrderTripList.LookupMode(true);
        if CateringOrderTripList.RunModal() = ACTION::LookupOK then begin
            CateringOrderTripList.GetRecord(CateringOrderTrip);
            exit(CateringOrderTrip."Catering Order No.");
        end;
    end;
    /// <summary>
    /// LookupTripSequenceNo.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure LookupTripSequenceNo(): Integer
    var
        CateringOrderList: Page "HWM CTR Catering Order Trip L";
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
    begin
        if GetSetOfRec(CateringOrderTrip) then
            CateringOrderTrip.FindSet(false);

        CateringOrderList.SetTableView(CateringOrderTrip);
        CateringOrderList.LookupMode(true);
        if CateringOrderList.RunModal() = ACTION::LookupOK then begin
            CateringOrderList.GetRecord(CateringOrderTrip);
            exit(CateringOrderTrip."Order Trip No.");
        end;
    end;
    /// <summary>
    /// GetLastTripSequenceNo.
    /// </summary>
    /// <param name="CateringOrderNo">Code[10].</param>    
    /// <returns>Return value of type Integer.</returns>
    procedure GetLastTripSequenceNo(CateringOrderNo: Code[10]): Integer
    var
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
    begin
        CateringOrderTrip.Reset();
        CateringOrderTrip.SetCurrentKey("Catering Order No.", "Order Trip No.");
        CateringOrderTrip.SetRange("Catering Order No.", CateringOrderNo);
        if CateringOrderTrip.FindLast() then
            exit(CateringOrderTrip."Order Trip No.");
    end;
    /// <summary>
    /// GetTripSequenceNo.
    /// </summary>
    /// <returns>Return variable TripSequenceNo of type Code[10].</returns>
    procedure GetTripSequenceNo() TripSequenceNo: Integer
    begin
        if not HasCateringOrderTrip then
            Error(ErrorRecIsNotSetUp);
        exit(CateringOrderTrip."Order Trip No.");
    end;

    /// <summary>
    /// GetSetOfRec.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order".</param>
    /// <returns>Return variable RecordExist of type Boolean.</returns>
    procedure GetSetOfRec(var CateringOrderTrip: Record "HWM CTR Catering Order Trip") RecordExist: Boolean
    begin
        CateringOrderTrip.Reset();
        ApplyFiltersForCateringOrderNo(CateringOrderTrip);
        ApplyFiltersForDeparturePointCode(CateringOrderTrip);
        ApplyFiltersForArrivalPointCode(CateringOrderTrip);
        ApplyFiltersForStatus(CateringOrderTrip);
        ClearFilters();
        exit(not CateringOrderTrip.IsEmpty);
    end;

    local procedure ApplyFiltersForCateringOrderNo(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    begin
        if GlobalCateringOrderNo = '' then
            exit;

        CateringOrderTrip.SetCurrentKey("Catering Order No.", "Point of Departure Code", "Point of Arrival Code");
        CateringOrderTrip.SetRange("Catering Order No.", GlobalCateringOrderNo);
    end;

    local procedure ApplyFiltersForDeparturePointCode(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    begin
        if GlobalDeparturePointCode = '' then
            exit;

        CateringOrderTrip.SetCurrentKey("Catering Order No.", "Point of Departure Code", "Point of Arrival Code");
        CateringOrderTrip.SetRange("Point of Departure Code", GlobalDeparturePointCode);
    end;

    local procedure ApplyFiltersForArrivalPointCode(var CateringOrder: Record "HWM CTR Catering Order Trip")
    begin
        if GlobalArrivalPointCode = '' then
            exit;

        CateringOrder.SetCurrentKey("Catering Order No.", "Point of Departure Code", "Point of Arrival Code");
        CateringOrder.SetRange("Point of Arrival Code", GlobalArrivalPointCode);
    end;

    local procedure ApplyFiltersForStatus(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    begin
        if not GlobalStatusIsSet then
            exit;

        CateringOrderTrip.SetCurrentKey(Status, "Processing Status");
        CateringOrderTrip.SetRange("Status", GlobalStatus);
    end;

    local procedure ApplyFiltersForProcessingStatus(var CateringOrder: Record "HWM CTR Catering Order")
    begin
        if not GlobalProcessingStatusIsSet then
            exit;

        CateringOrder.SetCurrentKey(Status, "Processing Status");
        CateringOrder.SetRange("Processing Status", GlobalProcessingStatus);
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
    /// SetRangeCateringOrderNo.
    /// </summary>
    /// <param name="NewNo">Code[10].</param>
    procedure SetRangeCateringOrderNo(NewNo: Code[10])
    begin
        sCommon.TestEmpty(NewNo, 'NewNo');
        GlobalCateringOrderNo := NewNo;
    end;
    /// <summary>
    /// SetRangeDeparturePointCode.
    /// </summary>
    /// <param name="NewCode">Code[10].</param>
    procedure SetRangeDeparturePointCode(NewCode: Code[20])
    begin
        sCommon.TestEmpty(NewCode, 'NewCode');
        GlobalDeparturePointCode := NewCode;
    end;
    /// <summary>
    /// SetRangeArrivalPointCode.
    /// </summary>
    /// <param name="NewCode">Code[10].</param>
    procedure SetRangeArrivalPointCode(NewCode: Code[20])
    begin
        sCommon.TestEmpty(NewCode, 'NewCode');
        GlobalArrivalPointCode := NewCode;
    end;

    local procedure ClearFilters()
    begin
        Clear(GlobalCateringOrderNo);
        Clear(GlobalDeparturePointCode);
        Clear(GlobalArrivalPointCode);
        Clear(GlobalStatusIsSet);
        Clear(GlobalProcessingStatusIsSet);
    end;
    /// <summary>
    /// CreateOrModifyList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order Trip".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyList(var RecBuffer: Record "HWM CTR Catering Order Trip"; RunTrigger: Boolean) NoList: List of [Code[10]]
    begin
        NoList := mCateringOrder.CreateOrModifyCateringOrderTripList(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// CreateOrModifySingle.
    /// </summary>
    /// <param name="RecBuffer">Record "HWM CTR Catering Order Trip".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure CreateOrModifySingle(RecBuffer: Record "HWM CTR Catering Order Trip"; RunTrigger: Boolean) No: Code[10]
    begin
        No := mCateringOrder.CreateOrModifySingleCateringOrderTrip(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// DeleteByPK.
    /// </summary>
    /// <param name="CateringOrderNo">Code[10].</param>
    /// <param name="DeparturePointCode">Code[20].</param>
    /// <param name="ArrivalPointCode">Code[20].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteByPK(CateringOrderNo: Code[10]; DeparturePointCode: Code[20]; ArrivalPointCode: Code[20]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
        IsHandled: Boolean;
    begin
        sCommon.TestEmpty(CateringOrderNo, 'CateringOrderNo');
        sCommon.TestEmpty(DeparturePointCode, 'DeparturePointCode');
        sCommon.TestEmpty(ArrivalPointCode, 'ArrivalPointCode');

        OnBeforeDeleteRecCateringOrderTrip(CateringOrderTrip, RunTrigger, IsHandled);
        if IsHandled then
            exit;
        mCateringOrder.DeleteSingleCateringOrderTrip(CateringOrderNo, DeparturePointCode, ArrivalPointCode, SuppressDialog, RunTrigger);
        OnAfterDeleteRecCateringOrderTrip(CateringOrderTrip, RunTrigger);
    end;
    /// <summary>
    /// OnBeforeDeleteRecCateringOrderTrip.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order Trip".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnBeforeDeleteRecCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var RunTrigger: Boolean; IsHandled: Boolean)
    begin

    end;
    /// <summary>
    /// OnAfterDeleteRecCateringOrderTrip.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order Trip".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterDeleteRecCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var RunTrigger: Boolean)
    begin

    end;
}