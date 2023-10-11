/// <summary>
/// Component:  Loadings
/// </summary>
codeunit 50014 "HWM CTR Loading Management"
{
    var
        Loading: Record "HWM CTR Loading Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        sSetup: Codeunit "HWM CTR Setup Service";
        sCommon: Codeunit "HWM CTR Common Service";
        sLoading: Codeunit "HWM CTR Loading Service";

    /// <summary>
    /// ValidateTblLoadingOnInsert.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM CTR Loading Header".</param>
    /// <param name="xLoading">Record "HWM CTR Loading Header".</param>    
    procedure ValidateTblLoadingOnInsert(var Loading: Record "HWM CTR Loading Header"; xLoading: Record "HWM CTR Loading Header")
    begin
        if Loading."No." = '' then
            NoSeriesMgt.InitSeries(sSetup.GetLoadingNos(true), xLoading."No. Series", 0D, Loading."No.", Loading."No. Series");
    end;
    /// <summary>
    /// ValidateTblLoadingOnModify.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM CTR Loading Header".</param>
    procedure ValidateTblLoadingOnModify(var Loading: Record "HWM CTR Loading Header")
    begin

    end;
    /// <summary>
    /// ValidateTblLoadingOnDelete.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM CTR Loading Header".</param>
    procedure ValidateTblLoadingOnDelete(var Loading: Record "HWM CTR Loading Header")
    begin

    end;
    /// <summary>
    /// ValidateTblLoadingOnRename.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM CTR Loading Header".</param>
    procedure ValidateTblLoadingOnRename(var Loading: Record "HWM CTR Loading Header")
    begin

    end;
    /// <summary>
    /// ValidateFldLoadingOnNo.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM CTR Loading Header".</param>
    /// <param name="xLoading">Record "HWM CTR Loading Header".</param>
    procedure ValidateFldLoadingOnNo(var Loading: Record "HWM CTR Loading Header"; xLoading: Record "HWM CTR Loading Header")
    begin
        if Loading."No." <> xLoading."No." then begin
            NoSeriesMgt.TestManual(sSetup.GetRouteNos(false));
            Loading."No. Series" := '';
        end;
    end;
    /// <summary>
    /// CreateOrModifyLoadingList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Loading Header".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyLoadingList(var RecBuffer: Record "HWM CTR Loading Header"; RunTrigger: Boolean) NoList: List of [Code[10]]
    var
        No: Code[10];
    begin
        TestCreateOrModifyBufferForLoading(RecBuffer, false);
        RecBuffer.Reset();
        Loading.LockTable();

        if RecBuffer.FindSet(false) then
            repeat
                No := CreateOrModifyLoading(RecBuffer, RunTrigger);
                NoList.Add(No);
            until RecBuffer.Next() = 0;
    end;
    /// <summary>
    /// CreateOrModifySingleLoading.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Loading Header".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure CreateOrModifySingleLoading(var RecBuffer: Record "HWM CTR Loading Header"; RunTrigger: Boolean): Code[10]
    begin
        TestCreateOrModifyBufferForLoading(RecBuffer, true);
        Loading.LockTable();

        if RecBuffer.FindFirst() then
            exit(CreateOrModifyLoading(RecBuffer, RunTrigger));
    end;

    local procedure CreateOrModifyLoading(RecBuffer: Record "HWM CTR Loading Header"; RunTrigger: Boolean) RecordNo: Code[10]
    var
        Loading: Record "HWM CTR Loading Header";
        Create: Boolean;
    begin
        if not Loading.Get(RecBuffer."No.") then
            Create := true;

        If Create then begin
            Loading.Init();
            Loading.TransferFields(RecBuffer, true);
            Loading.Insert(RunTrigger);
            RecordNo := Loading."No.";
        end else begin
            Loading.TransferFields(RecBuffer, false);
            Loading.Modify(RunTrigger);
            RecordNo := Loading."No.";
        end;
    end;
    /// <summary>
    /// TestCreateOrModifyBufferForLoading.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Loading Header".</param>
    /// <param name="OneRecordOnly">Boolean.</param>
    procedure TestCreateOrModifyBufferForLoading(var RecBuffer: Record "HWM CTR Loading Header"; OneRecordOnly: Boolean)
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
    /// DeleteSingleLoading.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteSingleLoading(No: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        DeleteQst: Label 'Are you sure to delete Loading: %1 ?';
    begin
        if (not SuppressDialog) then
            if (not Confirm(StrSubstNo(DeleteQst, No), true)) then
                exit;
        TestDeleteLoading(No);
        Loading.Get(No);
        Loading.Delete(RunTrigger);
    end;
    /// <summary>
    /// TestDeleteLoading.
    /// </summary>
    /// <param name="No">Code[10].</param>
    procedure TestDeleteLoading(No: Code[10])
    var
        ErrorCannotDeleteLoading: Label 'Loading cannot be deleted.';
    begin

    end;
}