/// <summary>
/// Component:  Routes
/// </summary>
codeunit 50006 "HWM CTR Route Management"
{
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        sSetup: Codeunit "HWM CTR Setup Service";
        sCommon: Codeunit "HWM CTR Common Service";
        sRouteTrip: Codeunit "HWM CTR Route Trip Service";
        sPostCode: Codeunit "HWM CTR Post Code Service";
        GlobalRoute: Record "HWM CTR Route";
        GlobalRouteTrip: Record "HWM CTR Route Trip";
        GlobalRoutePoint: Record "HWM CTR Route Point";

    /// <summary>
    /// ValidateTblRouteOnInsert.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    /// <param name="xRoute">Record "HWM CTR Route".</param>    
    procedure ValidateTblRouteOnInsert(var Route: Record "HWM CTR Route"; xRoute: Record "HWM CTR Route")
    begin
        if Route."No." = '' then
            NoSeriesMgt.InitSeries(sSetup.GetRouteNos(true), xRoute."No. Series", 0D, Route."No.", Route."No. Series");
    end;
    /// <summary>
    /// ValidateTblRouteOnModify.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    procedure ValidateTblRouteOnModify(var Route: Record "HWM CTR Route")
    begin

    end;
    /// <summary>
    /// ValidateTblRouteOnDelete.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    procedure ValidateTblRouteOnDelete(var Route: Record "HWM CTR Route")
    begin

    end;
    /// <summary>
    /// ValidateTblRouteOnRename.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    procedure ValidateTblRouteOnRename(var Route: Record "HWM CTR Route")
    begin

    end;
    /// <summary>
    /// ValidateFldRouteOnNo.
    /// </summary>
    /// <param name="Route">VAR Record "HWM CTR Route".</param>
    /// <param name="xRoute">Record "HWM CTR Route".</param>
    procedure ValidateFldRouteOnNo(var Route: Record "HWM CTR Route"; xRoute: Record "HWM CTR Route")
    begin
        if Route."No." <> xRoute."No." then begin
            NoSeriesMgt.TestManual(sSetup.GetRouteNos(false));
            Route."No. Series" := '';
        end;
    end;
    /// <summary>
    /// CreateOrModifyRouteList.
    /// </summary>
    /// <param name="RouteBuffer">VAR Record "HWM SPC Person".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable PersonList of type List of [Code[10]].</returns>
    procedure CreateOrModifyRouteList(var RouteBuffer: Record "HWM CTR Route"; RunTrigger: Boolean) RouteNoList: List of [Code[10]]
    var
        RouteNo: Code[10];
    begin
        TestCreateOrModifyBufferForRoute(RouteBuffer, false);
        RouteBuffer.Reset();
        GlobalRoute.LockTable();

        if RouteBuffer.FindSet(false) then
            repeat
                RouteNo := CreateOrModifyRoute(RouteBuffer, RunTrigger);
                RouteNoList.Add(RouteNo);
            until RouteBuffer.Next() = 0;
    end;
    /// <summary>
    /// CreateOrModifySingleRoute.
    /// </summary>
    /// <param name="RouteBuffer">VAR Record "HWM SPC Person".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure CreateOrModifySingleRoute(var RouteBuffer: Record "HWM CTR Route"; RunTrigger: Boolean): Code[10]
    begin
        TestCreateOrModifyBufferForRoute(RouteBuffer, true);
        GlobalRoute.LockTable();

        if RouteBuffer.FindFirst() then
            exit(CreateOrModifyRoute(RouteBuffer, RunTrigger));
    end;

    local procedure CreateOrModifyRoute(RouteBuffer: Record "HWM CTR Route"; RunTrigger: Boolean) RecordNo: Code[10]
    var
        Route: Record "HWM CTR Route";
        Create: Boolean;
    begin
        if not Route.Get(RouteBuffer."No.") then
            Create := true;

        If Create then begin
            Route.Init();
            Route.TransferFields(RouteBuffer, true);
            Route.Insert(RunTrigger);
            RecordNo := Route."No.";
        end else begin
            Route.TransferFields(RouteBuffer, false);
            Route.Modify(RunTrigger);
            RecordNo := Route."No.";
        end;
    end;
    /// <summary>
    /// TestCreateOrModifyBufferForRoute.
    /// </summary>
    /// <param name="RouteBuffer">VAR Record "HWM SPC Person".</param>
    /// <param name="OneRecordOnly">Boolean.</param>
    procedure TestCreateOrModifyBufferForRoute(var RouteBuffer: Record "HWM CTR Route"; OneRecordOnly: Boolean)
    begin
        sCommon.TestTemporaryRecord(RouteBuffer, 'RouteBuffer');

        if OneRecordOnly then
            sCommon.TestOneRecordOnly(RouteBuffer, 'RouteBuffer');

        if RouteBuffer.FindSet(false) then
            repeat
                RouteBuffer.TestField("No.");
            until RouteBuffer.Next() = 0;
    end;
    /// <summary>
    /// DeleteSingleRoute.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteSingleRoute(RouteNo: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        DeleteQst: Label 'Are you sure to delete Route: %1 ?';
    begin
        if (not SuppressDialog) then
            if (not Confirm(StrSubstNo(DeleteQst, RouteNo), true)) then
                exit;
        TestDeleteRoute(RouteNo);
        GlobalRoute.Get(RouteNo);
        GlobalRoute.Delete(RunTrigger);
    end;
    /// <summary>
    /// TestDeleteRoute.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    procedure TestDeleteRoute(RouteNo: Code[10])
    var
        ErrorCannotDeleteROute: Label 'Route cannot be deleted, toute trips exist.';
    begin
        //TODO: upgrade Route service - add route trips functionality
        //if sRoute.ExistRouteTrip(RouteNo) then
        //    Error(ErrorCannotDeleteROute);
    end;
    /// <summary>
    /// ValidateTblRouteTripOnInsert.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    /// <param name="xRouteTrip">Record "HWM CTR Route Trip".</param>    
    procedure ValidateTblRouteTripOnInsert(var RouteTrip: Record "HWM CTR Route Trip"; xRouteTrip: Record "HWM CTR Route Trip")
    begin
        SetRouteTripNoOnEmptyTripNo(RouteTrip);
    end;

    local procedure SetRouteTripNoOnEmptyTripNo(var RouteTrip: Record "HWM CTR Route Trip")
    var
        NewRouteTripNo: Integer;
    begin
        if RouteTrip."Trip Sequence No." <> 0 then
            exit;

        NewRouteTripNo := sRouteTrip.GetLastTripSequenceNo(RouteTrip."Route No.") + 10000;
        RouteTrip."Trip Sequence No." := NewRouteTripNo;
    end;
    /// <summary>
    /// ValidateTblRouteTripOnModify.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    procedure ValidateTblRouteTripOnModify(var RouteTrip: Record "HWM CTR Route Trip")
    begin

    end;
    /// <summary>
    /// ValidateTblRouteTripOnDelete.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    procedure ValidateTblRouteTripOnDelete(var RouteTrip: Record "HWM CTR Route Trip")
    begin

    end;
    /// <summary>
    /// ValidateTblRouteTripOnRename.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    procedure ValidateTblRouteTripOnRename(var RouteTrip: Record "HWM CTR Route Trip")
    begin

    end;
    /// <summary>
    /// ValidateFldRouteTripOnNo.
    /// </summary>
    /// <param name="RouteTrip">VAR Record "HWM CTR Route Trip".</param>
    /// <param name="xRouteTrip">Record "HWM CTR Route Trip".</param>
    procedure ValidateFldRouteTripOnNo(var RouteTrip: Record "HWM CTR Route Trip"; xRouteTrip: Record "HWM CTR Route Trip")
    begin

    end;

    /// <summary>
    /// CreateOrModifyRouteTripList.
    /// </summary>
    /// <param name="RouteTripBuffer">VAR Record "HWM SPC Person".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable RouteTripNoList of type List of Integer].</returns>
    procedure CreateOrModifyRouteTripList(var RouteTripBuffer: Record "HWM CTR Route Trip"; RunTrigger: Boolean) RouteTripNoList: List of [Integer]
    var
        RouteTripNo: Integer;
    begin
        TestCreateOrModifyBufferForRouteTrip(RouteTripBuffer, false);
        RouteTripBuffer.Reset();
        GlobalRouteTrip.LockTable();

        if RouteTripBuffer.FindSet(false) then
            repeat
                RouteTripNo := CreateOrModifyRouteTrip(RouteTripBuffer, RunTrigger);
                RouteTripNoList.Add(RouteTripNo);
            until RouteTripBuffer.Next() = 0;
    end;
    /// <summary>
    /// CreateOrModifySingleRouteTrip.
    /// </summary>
    /// <param name="RouteTripBuffer">VAR Record ""HWM CTR Route Trip".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure CreateOrModifySingleRouteTrip(var RouteTripBuffer: Record "HWM CTR Route Trip"; RunTrigger: Boolean): Integer
    begin
        TestCreateOrModifyBufferForRouteTrip(RouteTripBuffer, true);
        GlobalRouteTrip.LockTable();

        if RouteTripBuffer.FindFirst() then
            exit(CreateOrModifyRouteTrip(RouteTripBuffer, RunTrigger));
    end;

    local procedure CreateOrModifyRouteTrip(RouteTripBuffer: Record "HWM CTR Route Trip"; RunTrigger: Boolean) RecNo: Integer
    var
        RouteTrip: Record "HWM CTR Route Trip";
        Create: Boolean;
    begin
        if not RouteTrip.Get(RouteTripBuffer."Route No.", RouteTripBuffer."Trip Sequence No.") then
            Create := true;

        If Create then begin
            RouteTrip.Init();
            RouteTrip.TransferFields(RouteTripBuffer, true);
            RouteTrip.Insert(RunTrigger);
            RecNo := RouteTrip."Trip Sequence No.";
        end else begin
            RouteTrip.TransferFields(RouteTripBuffer, false);
            RouteTrip.Modify(RunTrigger);
            RecNo := RouteTrip."Trip Sequence No.";
        end;
    end;
    /// <summary>
    /// TestCreateOrModifyBufferForRouteTrip.
    /// </summary>
    /// <param name="RouteTripBuffer">VAR Record "HWM CTR Route Trip".</param>
    /// <param name="OneRecordOnly">Boolean.</param>
    procedure TestCreateOrModifyBufferForRouteTrip(var RouteTripBuffer: Record "HWM CTR Route Trip"; OneRecordOnly: Boolean)
    begin
        sCommon.TestTemporaryRecord(RouteTripBuffer, 'RouteTripBuffer');

        if OneRecordOnly then
            sCommon.TestOneRecordOnly(RouteTripBuffer, 'RouteTripBuffer');

        if RouteTripBuffer.FindSet(false) then
            repeat
                RouteTripBuffer.TestField("Route No.");
                RouteTripBuffer.TestField("Trip Sequence No.");
            until RouteTripBuffer.Next() = 0;
    end;
    /// <summary>
    /// DeleteSingleRouteTrip.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    /// <param name="RouteTripNo">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteSingleRouteTrip(RouteNo: Code[10]; RouteTripNo: Integer; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        DeleteQst: Label 'Are you sure to delete Route Trip: %1 ?';
    begin
        if (not SuppressDialog) then
            if (not Confirm(StrSubstNo(DeleteQst, RouteNo), true)) then
                exit;
        TestDeleteRouteTrip(RouteNo, RouteTripNo);
        GlobalRouteTrip.Get(RouteNo, RouteTripNo);
        GlobalRouteTrip.Delete(RunTrigger);
    end;
    /// <summary>
    /// TestDeleteRouteTrip.
    /// </summary>
    /// <param name="RouteNo">Code[10].</param>
    /// <param name="RouteTripNo">Integer.</param>
    procedure TestDeleteRouteTrip(RouteNo: Code[10]; RouteTripNo: Integer)
    var
        ErrorCannotDeleteRouteTrip: Label 'Route Trip cannot be deleted';
    begin
        //TODO: upgrade Route service - add route trips functionality
        //if sRoute.ExistRouteTrip(RouteNo) then
        //    Error(ErrorCannotDeleteROute);
    end;
    /// <summary>
    /// ValidateTblRoutePointOnInsert.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    /// <param name="xRoutePoint">Record "HWM CTR Route Point".</param>    
    procedure ValidateTblRoutePointOnInsert(var RoutePoint: Record "HWM CTR Route Point"; xRoutePoint: Record "HWM CTR Route Point")
    begin

    end;
    /// <summary>
    /// ValidateTblRoutePointOnModify.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    procedure ValidateTblRoutePointOnModify(var RoutePoint: Record "HWM CTR Route Point")
    begin

    end;
    /// <summary>
    /// ValidateTblRoutePointOnDelete.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    procedure ValidateTblRoutePointOnDelete(var RoutePoint: Record "HWM CTR Route Point")
    begin
    end;
    /// <summary>
    /// ValidateTblRoutePointOnRename.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    procedure ValidateTblRoutePointOnRename(var RoutePoint: Record "HWM CTR Route Point")
    begin

    end;
    /// <summary>
    /// ValidateFldRoutePointOnPostCode.
    /// </summary>
    /// <param name="RoutePoint">var Record "HWM CTR Route Point".</param>
    procedure ValidateFldRoutePointOnPostCode(var RoutePoint: Record "HWM CTR Route Point")
    var
        xRoutePoint: Record "HWM CTR Route Point";
    begin
        if xRoutePoint.Get(RoutePoint."Code") then
            if (RoutePoint."Post Code" = xRoutePoint."Post Code") and (RoutePoint.City = xRoutePoint.City) then
                exit;

        ValidateTblRoutePointAddressFieldsOnPostCodeNoAndCity(RoutePoint, RoutePoint."Post Code", RoutePoint.City);
    end;
    /// <summary>
    /// ValidateTblRoutePointAddressFieldsOnPostCodeNoAndCity.
    /// </summary>
    /// <param name="RoutePoint">VAR Record "HWM CTR Route Point".</param>
    /// <param name="PostCode">Code[20].</param>
    /// <param name="City">Text[30].</param>     
    procedure ValidateTblRoutePointAddressFieldsOnPostCodeNoAndCity(var RoutePoint: Record "HWM CTR Route Point"; PostCode: Code[20]; City: Text[100])
    begin
        if PostCode = '' then begin
            Clear(RoutePoint."Post Code");
            Clear(RoutePoint.City);
            Clear(RoutePoint.County);
            Clear(RoutePoint."Country/Region Code");
            exit;
        end;
        if City = '' then
            exit;
        if not sPostCode.SetByPK(PostCode, City) then
            exit;
        RoutePoint."Post Code" := sPostCode.GetCode();
        RoutePoint.City := sPostCode.GetCity(false);
        RoutePoint.County := sPostCode.GetCounty(false);
        RoutePoint."Country/Region Code" := sPostCode.GetCountryRegionCode(false);
    end;
    /// <summary>
    /// CreateOrModifyRoutePointList.
    /// </summary>
    /// <param name="RoutePointBuffer">VAR Record "HWM CTR Route Point".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable RoutePointCodeList of type List of [Code[10]].</returns>
    procedure CreateOrModifyRoutePointList(var RoutePointBuffer: Record "HWM CTR Route Point"; RunTrigger: Boolean) RoutePointCodeList: List of [Code[10]]
    var
        RoutePointCode: Code[10];
    begin
        TestCreateOrModifyBufferForRoutePoint(RoutePointBuffer, false);
        RoutePointBuffer.Reset();
        GlobalRouteTrip.LockTable();

        if RoutePointBuffer.FindSet(false) then
            repeat
                RoutePointCode := CreateOrModifyRoutePoint(RoutePointBuffer, RunTrigger);
                RoutePointCodeList.Add(RoutePointCode);
            until RoutePointBuffer.Next() = 0;
    end;
    /// <summary>
    /// CreateOrModifySingleRoutePoint.
    /// </summary>
    /// <param name="RoutePointBuffer">VAR Record "HWM CTR Route Point".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure CreateOrModifySingleRoutePoint(var RoutePointBuffer: Record "HWM CTR Route Point"; RunTrigger: Boolean): Code[10]
    begin
        TestCreateOrModifyBufferForRoutePoint(RoutePointBuffer, true);
        GlobalRouteTrip.LockTable();

        if RoutePointBuffer.FindFirst() then
            exit(CreateOrModifyRoutePoint(RoutePointBuffer, RunTrigger));
    end;

    local procedure CreateOrModifyRoutePoint(RoutePointBuffer: Record "HWM CTR Route Point"; RunTrigger: Boolean) RecordCode: Code[10]
    var
        RoutePoint: Record "HWM CTR Route Point";
        Create: Boolean;
    begin
        if not RoutePoint.Get(RoutePointBuffer.Code) then
            Create := true;

        If Create then begin
            RoutePoint.Init();
            RoutePoint.TransferFields(RoutePointBuffer, true);
            RoutePoint.Insert(RunTrigger);
            RecordCode := RoutePoint.Code;
        end else begin
            RoutePoint.TransferFields(RoutePointBuffer, false);
            RoutePoint.Modify(RunTrigger);
            RecordCode := RoutePoint.Code;
        end;
    end;
    /// <summary>
    /// TestCreateOrModifyBufferForRoutePoint.
    /// </summary>
    /// <param name="RoutePointBuffer">VAR Record "HWM CTR Route Point".</param>
    /// <param name="OneRecordOnly">Boolean.</param>
    procedure TestCreateOrModifyBufferForRoutePoint(var "RoutePointBuffer": Record "HWM CTR Route Point"; OneRecordOnly: Boolean)
    begin
        sCommon.TestTemporaryRecord("RoutePointBuffer", 'RoutePointBuffer');

        if OneRecordOnly then
            sCommon.TestOneRecordOnly("RoutePointBuffer", 'RoutePointBuffer');

        if "RoutePointBuffer".FindSet(false) then
            repeat
                "RoutePointBuffer".TestField(Code);
            until "RoutePointBuffer".Next() = 0;
    end;
    /// <summary>
    /// DeleteSingleRoutePoint.
    /// </summary>
    /// <param name="PointCode">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteSingleRoutePoint(PointCode: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        DeleteQst: Label 'Are you sure to delete Route Point: %1 ?';
    begin
        if (not SuppressDialog) then
            if (not Confirm(StrSubstNo(DeleteQst, PointCode), true)) then
                exit;
        TestDeleteRoutePoint(PointCode);
        GlobalRoutePoint.Get(PointCode);
        GlobalRoutePoint.Delete(RunTrigger);
    end;
    /// <summary>
    /// TestDeleteRoutePoint.
    /// </summary>
    /// <param name="PointCode">Code[10].</param>
    procedure TestDeleteRoutePoint(PointCode: Code[10])
    var
        ErrorCannotDeleteRoutePoint: Label 'Route Point cannot be deleted';
    begin

    end;
}