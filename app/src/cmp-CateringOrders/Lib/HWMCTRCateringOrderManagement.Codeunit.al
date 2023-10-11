/// <summary>
/// Component:  CateringOrders
/// </summary>
codeunit 50011 "HWM CTR Catering Order Mngt."
{
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        sSetup: Codeunit "HWM CTR Setup Service";
        sCommon: Codeunit "HWM CTR Common Service";
        sCateringOrderTrip: Codeunit "HWM CTR Cat.Order Trip Service";
        CateringOrder: Record "HWM CTR Catering Order";
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";

    /// <summary>
    /// ValidateTblCateringOrderOnInsert.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="xCateringOrder">Record "HWM CTR Catering Order".</param>    
    procedure ValidateTblCateringOrderOnInsert(var CateringOrder: Record "HWM CTR Catering Order"; xCateringOrder: Record "HWM CTR Catering Order")
    begin
        if CateringOrder."No." = '' then
            NoSeriesMgt.InitSeries(sSetup.GetCateringOrderNos(true), xCateringOrder."No. Series", 0D, CateringOrder."No.", CateringOrder."No. Series");
    end;
    /// <summary>
    /// ValidateTblCategingOrderOnModify.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    procedure ValidateTblCateringOrderOnModify(var CateringOrder: Record "HWM CTR Catering Order")
    begin

    end;
    /// <summary>
    /// ValidateTblCateringOrderOnDelete.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    procedure ValidateTblCateringOrderOnDelete(var CateringOrder: Record "HWM CTR Catering Order")
    begin

    end;
    /// <summary>
    /// ValidateTblCateringOrderOnRename.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    procedure ValidateTblCateringOrderOnRename(var CateringOrder: Record "HWM CTR Catering Order")
    begin

    end;
    /// <summary>
    /// ValidateFldCateringOrderOnNo.
    /// </summary>
    /// <param name="CateringOrder">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="xCateringOrder">Record "HWM CTR Catering Order".</param>
    procedure ValidateFldCateringOrderOnNo(var CateringOrder: Record "HWM CTR Catering Order"; xCateringOrder: Record "HWM CTR Catering Order")
    begin
        if CateringOrder."No." = xCateringOrder."No." then
            exit;
        NoSeriesMgt.TestManual(sSetup.GetCateringOrderNos(false));
        CateringOrder."No. Series" := '';
    end;
    /// <summary>
    /// CreateOrModifyCateringOrderList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyCateringOrderList(var RecBuffer: Record "HWM CTR Catering Order"; RunTrigger: Boolean) NoList: List of [Code[10]]
    var
        No: Code[10];
    begin
        TestCreateOrModifyBufferForCateringOrder(RecBuffer, false);
        RecBuffer.Reset();
        CateringOrder.LockTable();

        if RecBuffer.FindSet(false) then
            repeat
                No := CreateOrModifyCateringOrder(RecBuffer, RunTrigger);
                NoList.Add(No);
            until RecBuffer.Next() = 0;
    end;
    /// <summary>
    /// CreateOrModifySingleCateringOrder.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure CreateOrModifySingleCateringOrder(var RecBuffer: Record "HWM CTR Catering Order"; RunTrigger: Boolean): Code[10]
    begin
        TestCreateOrModifyBufferForCateringOrder(RecBuffer, true);
        CateringOrder.LockTable();

        if RecBuffer.FindFirst() then
            exit(CreateOrModifyCateringOrder(RecBuffer, RunTrigger));
    end;

    local procedure CreateOrModifyCateringOrder(RecBuffer: Record "HWM CTR Catering Order"; RunTrigger: Boolean) RecordNo: Code[10]
    var
        CateringOrder: Record "HWM CTR Catering Order";
        Create: Boolean;
    begin
        if not CateringOrder.Get(RecBuffer."No.") then
            Create := true;

        If Create then begin
            CateringOrder.Init();
            CateringOrder.TransferFields(RecBuffer, true);
            CateringOrder.Insert(RunTrigger);
            RecordNo := CateringOrder."No.";
        end else begin
            CateringOrder.TransferFields(RecBuffer, false);
            CateringOrder.Modify(RunTrigger);
            RecordNo := CateringOrder."No.";
        end;
    end;
    /// <summary>
    /// TestCreateOrModifyBufferForCateringOrder.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order".</param>
    /// <param name="OneRecordOnly">Boolean.</param>
    procedure TestCreateOrModifyBufferForCateringOrder(var RecBuffer: Record "HWM CTR Catering Order"; OneRecordOnly: Boolean)
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        if OneRecordOnly then
            sCommon.TestOneRecordOnly(RecBuffer, 'RecBuffer');

        if RecBuffer.FindSet(false) then
            repeat
                RecBuffer.TestField("No.");
            until RecBuffer.Next() = 0;
    end;
    /// <summary>
    /// DeleteSingleCateringOrder.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteSingleCateringOrder(No: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        DeleteQst: Label 'Are you sure to delete Catering Order: %1 ?';
    begin
        if (not SuppressDialog) then
            if (not Confirm(StrSubstNo(DeleteQst, No), true)) then
                exit;
        TestDeleteCateringOrder(No);
        CateringOrder.Get(No);
        CateringOrder.Delete(RunTrigger);
    end;
    /// <summary>
    /// TestDeleteCateringOrder.
    /// </summary>
    /// <param name="No">Code[10].</param>
    procedure TestDeleteCateringOrder(No: Code[10])
    var
        ErrorCannotDeleteCateringOrder: Label 'Catering Order cannot be deleted.';
    begin

    end;
    /// <summary>
    /// ValidateTblCateringOrderTripOnInsert.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order Trip".</param>
    /// <param name="xCateringOrderTrip">Record "HWM CTR Catering Order Trip".</param>    
    procedure ValidateTblCateringOrderTripOnInsert(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; xCateringOrderTrip: Record "HWM CTR Catering Order Trip")
    begin
        SetCateringOrderTripNoOnEmptyTripNo(CateringOrderTrip);
    end;

    local procedure SetCateringOrderTripNoOnEmptyTripNo(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    var
        NewRouteTripNo: Integer;
    begin
        if CateringOrderTrip."Order Trip No." <> 0 then
            exit;

        NewRouteTripNo := sCateringOrderTrip.GetLastTripSequenceNo(CateringOrderTrip."Catering Order No.") + 10000;
        CateringOrderTrip."Order Trip No." := NewRouteTripNo;
    end;

    /// <summary>
    /// ValidateTblCategingOrderTripOnModify.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order".</param>
    procedure ValidateTblCategingOrderTripOnModify(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    begin

    end;
    /// <summary>
    /// ValidateTblCateringOrderTripOnDelete.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order Trip".</param>
    procedure ValidateTblCateringOrderTripOnDelete(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    begin

    end;
    /// <summary>
    /// ValidateTblCateringOrderTripOnRename.
    /// </summary>
    /// <param name="CateringOrderTrip">VAR Record "HWM CTR Catering Order Trip".</param>
    procedure ValidateTblCateringOrderTripOnRename(var CateringOrderTrip: Record "HWM CTR Catering Order Trip")
    begin

    end;
    /// <summary>
    /// CreateOrModifyCateringOrderTripList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order Trip".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyCateringOrderTripList(var RecBuffer: Record "HWM CTR Catering Order Trip"; RunTrigger: Boolean) NoList: List of [Code[10]]
    var
        No: Code[10];
    begin
        TestCreateOrModifyBufferForCateringOrderTrip(RecBuffer, false);
        RecBuffer.Reset();
        CateringOrderTrip.LockTable();

        if RecBuffer.FindSet(false) then
            repeat
                No := CreateOrModifyCateringOrderTrip(RecBuffer, RunTrigger);
                NoList.Add(No);
            until RecBuffer.Next() = 0;
    end;
    /// <summary>
    /// CreateOrModifySingleCateringOrderTrip.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order Trip".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure CreateOrModifySingleCateringOrderTrip(var RecBuffer: Record "HWM CTR Catering Order Trip"; RunTrigger: Boolean): Code[10]
    begin
        TestCreateOrModifyBufferForCateringOrderTrip(RecBuffer, true);
        CateringOrderTrip.LockTable();

        if RecBuffer.FindFirst() then
            exit(CreateOrModifyCateringOrderTrip(RecBuffer, RunTrigger));
    end;

    local procedure CreateOrModifyCateringOrderTrip(RecBuffer: Record "HWM CTR Catering Order Trip"; RunTrigger: Boolean) RecordNo: Code[10]
    var
        CateringOrderTrip: Record "HWM CTR Catering Order Trip";
        Create: Boolean;
    begin
        if not CateringOrderTrip.Get(RecBuffer."Catering Order No.", RecBuffer."Point of Departure Code", RecBuffer."Point of Arrival Code") then
            Create := true;

        If Create then begin
            CateringOrderTrip.Init();
            CateringOrderTrip.TransferFields(RecBuffer, true);
            CateringOrderTrip.Insert(RunTrigger);
            RecordNo := CateringOrderTrip."Catering Order No.";
        end else begin
            CateringOrderTrip.TransferFields(RecBuffer, false);
            CateringOrderTrip.Modify(RunTrigger);
            RecordNo := CateringOrderTrip."Catering Order No.";
        end;
    end;
    /// <summary>
    /// TestCreateOrModifyBufferForCateringOrderTrip.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Catering Order Trip".</param>
    /// <param name="OneRecordOnly">Boolean.</param>
    procedure TestCreateOrModifyBufferForCateringOrderTrip(var RecBuffer: Record "HWM CTR Catering Order Trip"; OneRecordOnly: Boolean)
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        if OneRecordOnly then
            sCommon.TestOneRecordOnly(RecBuffer, 'RecBuffer');

        if RecBuffer.FindSet(false) then
            repeat
                RecBuffer.TestField("Catering Order No.");
                RecBuffer.TestField("Point of Departure Code");
                RecBuffer.TestField("Point of Arrival Code");
            until RecBuffer.Next() = 0;
    end;
    /// <summary>
    /// DeleteSingleCateringOrderTrip.
    /// </summary>
    /// <param name="CateringOrderNo">Code[10].</param>
    /// <param name="OriginalPointCode">Code[20].</param>
    /// <param name="DestinationPointCode">Code[20].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteSingleCateringOrderTrip(CateringOrderNo: Code[10]; OriginalPointCode: Code[20]; DestinationPointCode: Code[20]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        DeleteQst: Label 'Are you sure to delete Catering Order Trip: %1 %2 %3 ?';
    begin
        if (not SuppressDialog) then
            if (not Confirm(StrSubstNo(DeleteQst, CateringOrderNo, OriginalPointCode, DestinationPointCode), true)) then
                exit;
        TestDeleteCateringOrderTrip(CateringOrderNo, OriginalPointCode, DestinationPointCode);
        CateringOrderTrip.Get(CateringOrderNo, OriginalPointCode, DestinationPointCode);
        CateringOrderTrip.Delete(RunTrigger);
    end;
    /// <summary>
    /// TestDeleteCateringOrderTrip.
    /// </summary>
    /// <param name="CateringOrderNo">Code[10].</param>
    /// <param name="OriginalPointCode">Code[10].</param>
    /// <param name="DestinationPointCode">Integer.</param>
    procedure TestDeleteCateringOrderTrip(CateringOrderNo: Code[10]; OriginalPointCode: Code[20]; DestinationPointCode: Code[20])
    var
        ErrorCannotDeleteCateringOrderTrip: Label 'Catering Order Trip cannot be deleted.';
    begin

    end;

}