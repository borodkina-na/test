/// <summary>
/// Component: Countries
/// </summary>
codeunit 50016 "HWM CTR Post Code Service"
{
    Subtype = Normal;

    var
        GlobalNo: Code[20];
        GlobalCity: Code[30];
        HasPostCode: Boolean;
        sCommon: Codeunit "HWM CTR Common Service";
        PostCode: Record "Post Code";
        ErrorRecIsNotSetUp: Label 'Post Code is not initialized. Use SetByPK function first.';

    /// <summary>
    /// SetByPK.
    /// </summary>
    /// <param name="PostCodeNo">Code[20].</param>
    /// <param name="City">Text[30].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure SetByPK(PostCodeNo: Code[20]; City: Text[30]): Boolean
    begin
        sCommon.TestEmpty(PostCodeNo, 'PostCodeNo');
        sCommon.TestEmpty(City, 'City');
        if HasPostCode and (PostCode.Code = PostCodeNo) and (PostCode.City = City) then
            exit(true);
        HasPostCode := PostCode.Get(PostCodeNo, City);
        exit(HasPostCode);
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
    /// <param name="RecBuffer">VAR Record "Post Code".</param>
    procedure InitBufferByGetSet(var RecBuffer: Record "Post Code")
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        if GetSetOfRec(PostCode) then begin
            PostCode.FindSet(false);
            repeat
                RecBuffer.Init();
                RecBuffer.TransferFields(PostCode, true);
                RecBuffer.Insert(false);
            until PostCode.Next() = 0;
        end;
    end;
    /// <summary>
    /// ExistRec.
    /// </summary>
    /// <returns>Return variable ExistRec of type Boolean.</returns>
    procedure ExistRec() ExistRec: Boolean
    var
        PostCode: Record "Post Code";
    begin
        ExistRec := GetSetOfRec(PostCode);
    end;

    /// <summary>
    /// ExistByPK.
    /// </summary>
    /// <param name="PostCodeNo">Code[20].</param>
    /// <param name="City">Text[30].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure ExistByPK(PostCodeNo: Code[20]; City: Code[20]): Boolean
    var
        PostCode: Record "Post Code";
    begin
        exit(PostCode.Get(PostCodeNo, City));
    end;
    /// <summary>
    /// OpenList.
    /// </summary>
    procedure OpenList()
    var
        PostCodeList: Page "Post Codes";
        PostCode: Record "Post Code";
    begin
        if GetSetOfRec(PostCode) then begin
            PostCode.FindSet(false);
        end;
        PostCodeList.SetTableView(PostCode);
        PostCodeList.Run();
    end;
    /// <summary>
    /// LookupRec.
    /// </summary>
    /// <param name="PostCode">VAR Record "Post Code".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure LookupRec(var PostCode: Record "Post Code"): Boolean
    var
        PostCodeList: Page "Post Codes";
    begin
        if GetSetOfRec(PostCode) then
            PostCode.FindSet(false);

        PostCodeList.SetTableView(PostCode);
        PostCodeList.LookupMode(true);
        if PostCodeList.RunModal() = ACTION::LookupOK then begin
            PostCodeList.GetRecord(PostCode);
            exit(true);
        end;
    end;
    /// <summary>
    /// LookupNo.
    /// </summary>
    /// <returns>Return value of type Code[20].</returns>
    procedure LookupNo(): Code[20]
    var
        PostCodeList: Page "Post Codes";
        PostCode: Record "Post Code";
    begin
        if GetSetOfRec(PostCode) then
            PostCode.FindSet(false);

        PostCodeList.SetTableView(PostCode);
        PostCodeList.LookupMode(true);
        if PostCodeList.RunModal() = ACTION::LookupOK then begin
            PostCodeList.GetRecord(PostCode);
            exit(PostCode.Code);
        end;
    end;
    /// <summary>
    /// LookupCity.
    /// </summary>
    /// <returns>Return value of type Text[30].</returns>
    procedure LookupCity(): Text[30]
    var
        PostCodeList: Page "Post Codes";
        PostCode: Record "Post Code";
    begin
        if GetSetOfRec(PostCode) then
            PostCode.FindSet(false);

        PostCodeList.SetTableView(PostCode);
        PostCodeList.LookupMode(true);
        if PostCodeList.RunModal() = ACTION::LookupOK then begin
            PostCodeList.GetRecord(PostCode);
            exit(PostCode.City);
        end;
    end;
    /// <summary>
    /// GetNo.
    /// </summary>
    /// <returns>Return variable No of type Code[20].</returns>
    procedure GetCode() No: Code[20]
    begin
        if not HasPostCode then
            Error(ErrorRecIsNotSetUp);

        PostCode.TestField("Code");

        exit(PostCode."Code");
    end;
    /// <summary>
    /// GetCity.
    /// </summary>
    /// <param name="DoTestField">Boolean.</param>
    /// <returns>Return variable City of type Text[30].</returns>
    procedure GetCity(DoTestField: Boolean) City: Text[30]
    begin
        if not HasPostCode then
            Error(ErrorRecIsNotSetUp);

        if DoTestField then
            PostCode.TestField(County);

        exit(PostCode.City);
    end;
    /// <summary>
    /// GetCounty.
    /// </summary>
    /// <param name="DoTestField">Boolean.</param>
    /// <returns>Return variable Country of type Text[30].</returns>
    procedure GetCounty(DoTestField: Boolean) No: Text[30]
    begin
        if not HasPostCode then
            Error(ErrorRecIsNotSetUp);

        if DoTestField then
            PostCode.TestField(County);

        exit(PostCode.County);
    end;
    /// <summary>
    /// GetCountryRegionCode.
    /// </summary>
    /// <param name="DoTestField">Boolean.</param>
    /// <returns>Return variable CountryCode of type Code[10].</returns>
    procedure GetCountryRegionCode(DoTestField: Boolean) CountryRegionCode: Code[10]
    begin
        if not HasPostCode then
            Error(ErrorRecIsNotSetUp);

        if DoTestField then
            PostCode.TestField("Country/Region Code");

        exit(PostCode."Country/Region Code");
    end;
    /// <summary>
    /// GetSetOfRec.
    /// </summary>
    /// <param name="PostCode">VAR Record "Post Code".</param>
    /// <returns>Return variable RecordExist of type Boolean.</returns>
    procedure GetSetOfRec(var PostCode: Record "Post Code") RecordExist: Boolean
    begin
        PostCode.Reset();
        ApplyFiltersForPostCodeNo(PostCode);
        ApplyFiltersForCity(PostCode);
        ClearFilters();
        exit(not PostCode.IsEmpty);
    end;

    local procedure ApplyFiltersForPostCodeNo(var PostCode: Record "Post Code")
    begin
        if GlobalNo = '' then
            exit;

        PostCode.SetCurrentKey("Code", "City");
        PostCode.SetRange("Code", GlobalNo);
    end;

    local procedure ApplyFiltersForCity(var PostCode: Record "Post Code")
    begin
        if GlobalCity = '' then
            exit;

        PostCode.SetCurrentKey("City", "Code");
        PostCode.SetRange(City, GlobalCity);
    end;
    /// <summary>
    /// SetRangePostCodeNo.
    /// </summary>
    /// <param name="NewNo">Code[20].</param>
    procedure SetRangePostCodeNo(NewNo: Code[20])
    begin
        sCommon.TestEmpty(NewNo, 'NewNo');
        GlobalNo := NewNo;
    end;
    /// <summary>
    /// SetRangeCity.
    /// </summary>
    /// <param name="NewCity">Text[30].</param>
    procedure SetRangeCity(NewCity: Text[30])
    begin
        sCommon.TestEmpty(NewCity, 'NewCity');
        GlobalCity := NewCity;
    end;

    local procedure ClearFilters()
    begin
        Clear(GlobalNo);
        Clear(GlobalCity);
    end;
    /// <summary>
    /// CreateOrModifyList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "Post Code".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[20]].</returns>
    procedure CreateOrModifyList(var RecBuffer: Record "Post Code"; RunTrigger: Boolean) NoList: List of [Code[20]]
    begin

    end;
    /// <summary>
    /// CreateOrModifySingle.
    /// </summary>
    /// <param name="RecBuffer">Record "Post Code".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable No of type Code[20].</returns>
    procedure CreateOrModifySingle(RecBuffer: Record "Post Code"; RunTrigger: Boolean) No: Code[20]
    begin

    end;
    /// <summary>
    /// DeleteByPK.
    /// </summary>
    /// <param name="PostCodeNo">Code[20].</param>
    /// <param name="City">Text[30].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteByPK(PostCodeNo: Code[20]; City: Text[30]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        PostCode: Record "Post Code";
        IsHandled: Boolean;
    begin
        sCommon.TestEmpty(PostCodeNo, 'PostCodeNo');
        sCommon.TestEmpty(City, 'City');

        OnBeforeDeleteRec(PostCode, RunTrigger, IsHandled);
        if IsHandled then
            exit;
        OnAfterDeleteRec(PostCode, RunTrigger);
    end;
    /// <summary>
    /// OnBeforeDeleteRec.
    /// </summary>
    /// <param name="PostCode">VAR Record "Post Code".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnBeforeDeleteRec(var PostCode: Record "Post Code"; var RunTrigger: Boolean; IsHandled: Boolean)
    begin

    end;
    /// <summary>
    /// OnAfterDeleteRec.
    /// </summary>
    /// <param name="PostCode">VAR Record "Post Code".</param>
    /// <param name="RunTrigger">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterDeleteRec(var PostCode: Record "Post Code"; var RunTrigger: Boolean)
    begin

    end;
}