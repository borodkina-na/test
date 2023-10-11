/// <summary>
/// Component: Loadings
/// </summary>
codeunit 50018 "HWM CTR Loading Service"
{
    Subtype = Normal;

    var
        mLoading: Codeunit "HWM CTR Loading Management";
        sCommon: Codeunit "HWM CTR Common Service";
        Loading: Record "HWM CTR Loading Header";
        HasLoading: Boolean;
        GlobalNo: Code[10];
        GlobalStatusIsSet: Boolean;
        GlobalStatus: Enum "HWM CTR Status";
        GlobalProcessingStatusIsSet: Boolean;
        GlobalProcessingStatus: Enum "HWM CTR Process Status";
        ErrorLoadingIsNotSetUp: Label 'Loading is not initialized. Use SetLoading function first.';

    /// <summary>
    /// SetLoading.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetLoading(No: Code[10]): Boolean
    begin
        sCommon.TestEmpty(No, 'No');
        HasLoading := Loading.Get(No);
        exit(HasLoading);
    end;
    /// <summary>
    /// ClearLoading.
    /// </summary>
    procedure ClearLoading()
    begin
        ClearAll();
    end;
    /// <summary>
    /// InitBufferByGetSet.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM CTR Loading Header".</param>
    procedure InitBufferByGetSet(var RecBuffer: Record "HWM CTR Loading Header")
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RouteBuffer');

        if GetSetOf(Loading) then begin
            Loading.FindSet(false);
            repeat
                RecBuffer.Init();
                RecBuffer.TransferFields(Loading, true);
                RecBuffer.Insert(false);
            until Loading.Next() = 0;
        end;
    end;
    /// <summary>
    /// IsActive.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsActive(): Boolean
    begin
        if not HasLoading then
            Error(ErrorLoadingIsNotSetUp);
        exit(Loading.Status = Loading.Status::Active)
    end;
    /// <summary>
    /// ExistRec.
    /// </summary>
    /// <returns>Return variable ExistLoading of type Boolean.</returns>
    procedure ExistRec() ExistLoading: Boolean
    var
        Loading: Record "HWM CTR Loading Header";
    begin
        ExistLoading := GetSetOf(Loading);
    end;
    /// <summary>
    /// ExistByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ExistByNo(No: Code[10]): Boolean
    var
        Loading: Record "HWM CTR Loading Header";
    begin
        exit(Loading.Get(No));
    end;
    /// <summary>
    /// OpenCard.
    /// </summary>
    procedure OpenCard()
    var
        LoadingCard: Page "HWM CTR Loading Document Card";
        Loading: Record "HWM CTR Loading Header";
    begin
        if GetSetOf(Loading) then begin
            Loading.FindSet(false);
        end;
        LoadingCard.SetTableView(Loading);
        LoadingCard.Run();
    end;
    /// <summary>
    /// OpenList.
    /// </summary>
    procedure OpenList()
    var
        LoadingList: Page "HWM CTR Loading Document List";
        Loading: Record "HWM CTR Loading Header";
    begin
        if GetSetOf(Loading) then begin
            Loading.FindSet(false);
        end;
        LoadingList.SetTableView(Loading);
        LoadingList.Run();
    end;
    /// <summary>
    /// LookupRec.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM CTR Loading Header".</param>
    procedure LookupRec(var Loading: Record "HWM CTR Loading Header")
    var
        LoadingList: Page "HWM CTR Loading Document List";
    begin
        if GetSetOf(Loading) then
            Loading.FindSet(false);

        LoadingList.SetTableView(Loading);
        LoadingList.LookupMode(true);
        if LoadingList.RunModal() = ACTION::LookupOK then begin
            LoadingList.GetRecord(Loading);
        end;
    end;
    /// <summary>
    /// LookupNo.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure LookupNo(): Code[10]
    var
        LoadingList: Page "HWM CTR Route List";
        Loading: Record "HWM CTR Loading Header";
    begin
        if GetSetOf(Loading) then
            Loading.FindSet(false);

        LoadingList.SetTableView(Loading);
        LoadingList.LookupMode(true);
        if LoadingList.RunModal() = ACTION::LookupOK then begin
            LoadingList.GetRecord(Loading);
            exit(Loading."No.");
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
        Setup.TestField("Loading Nos.");
        NoSeriesMgt.InitSeries(Setup."Loading Nos.", Setup."Loading Nos.", 0D, NewNo, Setup."Loading Nos.");
    end;
    /// <summary>
    /// GetNo.
    /// </summary>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure GetNo() No: Code[10]
    begin
        if not HasLoading then
            Error(ErrorLoadingIsNotSetUp);
        exit(Loading."No.");
    end;
    /// <summary>
    /// GetSetOf.
    /// </summary>
    /// <param name="Location">VAR Record "HWM CTR Loading Header".</param>
    /// <returns>Return variable RecordExist of type Boolean.</returns>
    procedure GetSetOf(var Location: Record "HWM CTR Loading Header") RecordExist: Boolean
    begin
        Loading.Reset();
        ApplyFiltersForNo(Loading);
        ApplyFiltersForStatus(Loading);
        ApplyFiltersForProcessingStatus(Loading);
        ClearFilters();
        exit(not Loading.IsEmpty);
    end;

    local procedure ApplyFiltersForNo(var Loading: Record "HWM CTR Loading Header")
    begin
        if GlobalNo = '' then
            exit;

        Loading.SetCurrentKey("No.");
        Loading.SetRange("No.", GlobalNo);
    end;

    local procedure ApplyFiltersForStatus(var Loading: Record "HWM CTR Loading Header")
    begin
        if not GlobalStatusIsSet then
            exit;

        Loading.SetCurrentKey(Status, "Processing Status");
        Loading.SetRange("Status", GlobalStatus);
    end;

    local procedure ApplyFiltersForProcessingStatus(var Loading: Record "HWM CTR Loading Header")
    begin
        if not GlobalProcessingStatusIsSet then
            exit;

        Loading.SetCurrentKey(Status, "Processing Status");
        Loading.SetRange("Processing Status", GlobalProcessingStatus);
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
    /// <param name="RecBuffer">VAR Record "HWM CTR Loading Header".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyList(var RecBuffer: Record "HWM CTR Loading Header"; RunTrigger: Boolean) NoList: List of [Code[10]]
    begin
        NoList := mLoading.CreateOrModifyLoadingList(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// CreateOrModifySingleRec.
    /// </summary>
    /// <param name="RecBuffer">Record "HWM CTR Loading Header".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable No of type Code[10].</returns>
    procedure CreateOrModifySingleRec(RecBuffer: Record "HWM CTR Loading Header"; RunTrigger: Boolean) No: Code[10]
    begin
        No := mLoading.CreateOrModifySingleLoading(RecBuffer, RunTrigger);
    end;
    /// <summary>
    /// DeleteByNo.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteByNo(No: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        Loading: Record "HWM CTR Loading Header";
        IsHandled: Boolean;
    begin
        sCommon.TestEmpty(No, 'No');

        OnBeforeDeleteLoading(Loading, RunTrigger, IsHandled);
        if IsHandled then
            exit;
        mLoading.DeleteSingleLoading(No, SuppressDialog, RunTrigger);
        OnAfterDeleteLoading(Loading, RunTrigger);
    end;
    /// <summary>
    /// OnBeforeDeleteLoading.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM SPC Loading Header".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnBeforeDeleteLoading(var Loading: Record "HWM CTR Loading Header"; var RunTrigger: Boolean; IsHandled: Boolean)
    begin

    end;
    /// <summary>
    /// OnAfterDeleteLoading.
    /// </summary>
    /// <param name="Loading">VAR Record "HWM CTR Loading Header".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterDeleteLoading(var Loading: Record "HWM CTR Loading Header"; var RunTrigger: Boolean)
    begin

    end;
}