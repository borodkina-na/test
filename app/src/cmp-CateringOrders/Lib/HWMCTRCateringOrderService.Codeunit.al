/// <summary>
/// Component: CateringOrders
/// </summary>
codeunit 50012 "HWM CTR Catering Order Service"
{
    Subtype = Normal;

    var
        mCateringOrder: Codeunit "HWM CTR Catering Order Mngt.";
        sCommon: Codeunit "HWM CTR Common Service";
        CateringOrder: Record "HWM CTR Catering Order";
        HasCateringOrder: Boolean;
        GlobalRecNo: Code[10];
        GlobalStatusIsSet: Boolean;
        GlobalStatus: Enum "HWM CTR Status";
        GlobalProcessingStatusIsSet: Boolean;
        GlobalProcessingStatus: Enum "HWM CTR Process Status";
        ErrorRecIsNotSetUp: Label 'Catering Order is not initialized. Use SetByNo function first.';

    /// <summary>
    /// SetByNo.
    /// </summary>
    /// <param name="CateringOrderNo">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByNo(CateringOrderNo: Code[10]): Boolean
    begin
        sCommon.TestEmpty(CateringOrderNo, 'No');
        if HasCateringOrder and (CateringOrder."No." = CateringOrderNo) then
            exit(true);
        HasCateringOrder := CateringOrder.Get(CateringOrderNo);
        exit(HasCateringOrder);
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
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order".</param>
    procedure InitBufferByGetSet(var RecBuffer: Record "HWM CTR Catering Order")
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        if GetSetOf(CateringOrder) then begin
            CateringOrder.FindSet(false);
            repeat
                RecBuffer.Init();
                RecBuffer.TransferFields(CateringOrder, true);
                RecBuffer.Insert(false);
            until CateringOrder.Next() = 0;
        end;
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasCateringOrder then
            Error(ErrorRecIsNotSetUp);
        exit(CateringOrder.Status = CateringOrder.Status::Active)
    end;
    /// <summary>
    /// ExistRec.
    /// </summary>
    /// <returns>Return variable ExistRec of type Boolean.</returns>
    procedure ExistRec() ExistRec: Boolean
    var
        CateringOrder: Record "HWM CTR Catering Order";
    begin
        ExistRec := GetSetOf(CateringOrder);
    end;
    /// <summary>
    /// ExistByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ExistByNo(No: Code[10]): Boolean
    var
        CateringOrder: Record "HWM CTR Catering Order";
    begin
        exit(CateringOrder.Get(No));
    end;
    /// <summary>
    /// OpenCard.
    /// </summary>
    procedure OpenCard()
    var
        Card: Page "HWM CTR Catering Order Card";
        CateringOrder: Record "HWM CTR Catering Order";
    begin
        if GetSetOf(CateringOrder) then begin
            CateringOrder.FindSet(false);
        end;
        Card.SetTableView(CateringOrder);
        Card.Run();
    end;
    /// <summary>
    /// OpenList.
    /// </summary>
    procedure OpenList()
    var
        CateringOrderList: Page "HWM CTR Catering Order List";
        CateringOrder: Record "HWM CTR Catering Order";
    begin
        if GetSetOf(CateringOrder) then begin
            CateringOrder.FindSet(false);
        end;
        CateringOrderList.SetTableView(CateringOrder);
        CateringOrderList.Run();
    end;
    /// <summary>
    /// LookupRec.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    procedure LookupRec(var CateringOrder: Record "HWM CTR Catering Order")
    var
        CateringOrderList: Page "HWM CTR Catering Order List";
    begin
        if GetSetOf(CateringOrder) then
            CateringOrder.FindSet(false);

        CateringOrderList.SetTableView(CateringOrder);
        CateringOrderList.LookupMode(true);
        if CateringOrderList.RunModal() = ACTION::LookupOK then begin
            CateringOrderList.GetRecord(CateringOrder);
        end;
    end;
    /// <summary>
    /// LookupNo.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure LookupNo(): Code[10]
    var
        CaterigOrderList: Page "HWM CTR Catering Order List";
        CateringOrder: Record "HWM CTR Catering Order";
    begin
        if GetSetOf(CateringOrder) then
            CateringOrder.FindSet(false);

        CaterigOrderList.SetTableView(CateringOrder);
        CaterigOrderList.LookupMode(true);
        if CaterigOrderList.RunModal() = ACTION::LookupOK then begin
            CaterigOrderList.GetRecord(CateringOrder);
            exit(CateringOrder."No.");
        end;
    end;
    /// <summary>
    /// GetNewNo.
    /// </summary>
    /// <returns>Return variable NewNo of type Code[10].</returns>
    procedure GetNewNo() NewNo: Code[10]
    var
        Setup: Record "HWM CTR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        Setup.Get();
        Setup.TestField("Catering Order Nos.");
        NoSeriesMgt.InitSeries(Setup."Catering Order Nos.", Setup."Route Nos.", 0D, NewNo, Setup."Catering Order Nos.");
    end;
    /// <summary>
    /// GetNo.
    /// </summary>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure GetNo() No: Code[10]
    begin
        if not HasCateringOrder then
            Error(ErrorRecIsNotSetUp);
        exit(CateringOrder."No.");
    end;
    /// <summary>
    /// GetSetOf.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    /// <returns>Return variable RecordExist of type Boolean.</returns>
    procedure GetSetOf(var CateringOrder: Record "HWM CTR Catering Order") RecordExist: Boolean
    begin
        CateringOrder.Reset();
        ApplyFiltersForNo(CateringOrder);
        ApplyFiltersForStatus(CateringOrder);
        ClearFilters();
        exit(not CateringOrder.IsEmpty);
    end;

    local procedure ApplyFiltersForNo(var CateringOrder: Record "HWM CTR Catering Order")
    begin
        if GlobalRecNo = '' then
            exit;

        CateringOrder.SetCurrentKey("No.");
        CateringOrder.SetRange("No.", GlobalRecNo);
    end;

    local procedure ApplyFiltersForStatus(var CateringOrder: Record "HWM CTR Catering Order")
    begin
        if not GlobalStatusIsSet then
            exit;

        CateringOrder.SetCurrentKey(Status, "Processing Status");
        CateringOrder.SetRange("Status", GlobalStatus);
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
    /// SetRangeNo.
    /// </summary>
    /// <param name="NewNo">Code[10].</param>
    procedure SetRangeNo(NewNo: Code[10])
    begin
        sCommon.TestEmpty(NewNo, 'NewNo');
        GlobalRecNo := NewNo;
    end;

    local procedure ClearFilters()
    begin
        Clear(GlobalRecNo);
        Clear(GlobalStatusIsSet);
        Clear(GlobalProcessingStatusIsSet);
    end;
    /// <summary>
    /// CreateOrModifyList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyList(var RecBuffer: Record "HWM CTR Catering Order"; RunTrigger: Boolean) NoList: List of [Code[10]]
    begin
        NoList := mCateringOrder.CreateOrModifyCateringOrderList(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// CreateOrModifySingle.
    /// </summary>
    /// <param name="RecBuffer">Record "HWM CTR Catering Order".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure CreateOrModifySingle(RecBuffer: Record "HWM CTR Catering Order"; RunTrigger: Boolean) No: Code[10]
    begin
        No := mCateringOrder.CreateOrModifySingleCateringOrder(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// DeleteByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteByNo(No: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        CateringOrder: Record "HWM CTR Catering Order";
        IsHandled: Boolean;
    begin
        sCommon.TestEmpty(No, 'No');

        OnBeforeDeleteCateringOrder(CateringOrder, RunTrigger, IsHandled);
        if IsHandled then
            exit;
        mCateringOrder.DeleteSingleCateringOrder(No, SuppressDialog, RunTrigger);
        OnAfterDeleteCateringOrder(CateringOrder, RunTrigger);
    end;
    /// <summary>
    /// OnBeforeDeleteRec.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnBeforeDeleteCateringOrder(var CateringOrder: Record "HWM CTR Catering Order"; var RunTrigger: Boolean; IsHandled: Boolean)
    begin

    end;
    /// <summary>
    /// OnAfterDeleteRec.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterDeleteCateringOrder(var CateringOrder: Record "HWM CTR Catering Order"; var RunTrigger: Boolean)
    begin

    end;
}