/// <summary>
/// Component:  Routes
/// </summary>
table 50003 "HWM CTR Route Trip"
{
    Caption = 'HWM CTR Route Trip';
    DataClassification = CustomerContent;
    LookupPageId = "HWM CTR Route Trip List";
    DrillDownPageId = "HWM CTR Route Trip List";

    fields
    {
        field(1; "Route No."; Code[10])
        {
            Caption = 'Route No.';
            TableRelation = "HWM CTR Route"."No.";
            ValidateTableRelation = true;
        }
        field(2; "Trip Sequence No."; Integer)
        {
            Caption = 'Trip Sequence No.';
        }
        field(3; "Reference No."; Code[20])
        {
            Caption = 'Route Trip Ref. No.';
        }
        field(4; Description; text[100])
        {
            Caption = 'Description';
        }
        field(5; Status; enum "HWM CTR Status")
        {
            Caption = 'Status';
        }
        field(6; "Processing Status"; Enum "HWM CTR Process Status")
        {
            Caption = 'Processing Status';
            Editable = false;
        }
        field(10; "Point of Departure Code"; Code[20])
        {
            Caption = 'Point of Departure Code';
            TableRelation = "HWM CTR Route Point".Code;
            ValidateTableRelation = true;
        }
        field(11; "Point of Arrival Code"; Code[20])
        {
            Caption = 'Point of Arrival Code';
            TableRelation = "HWM CTR Route Point".Code;
            ValidateTableRelation = true;
        }
        field(20; "Departure Time"; Time)
        {
            Caption = 'Departure Time';
        }
        field(21; "Arrival Time"; Time)
        {
            Caption = 'Arrival Time';
        }
        field(22; "Date Shift"; Boolean)
        {
            Caption = 'Date Shift';
        }
        field(100; "Departure Country Code"; Code[10])
        {
            Caption = 'Departure Country Code';
            FieldClass = FlowField;
            CalcFormula = lookup("HWM CTR Route Point"."Country/Region Code" where(Code = field("Point of Departure Code")));
            Editable = false;
        }
        field(101; "Arrival Country Code"; Code[10])
        {
            Caption = 'Arrival Country Code';
            FieldClass = FlowField;
            CalcFormula = lookup("HWM CTR Route Point"."Country/Region Code" where(Code = field("Point of Arrival Code")));
            Editable = false;
        }
        field(102; "Route Name"; Text[100])
        {
            Caption = 'Route Name';
            FieldClass = FlowField;
            CalcFormula = lookup("HWM CTR Route".Description where("No." = field("Route No.")));
            Editable = false;
        }
    }
    keys
    {
        key(hwmPK; "Route No.", "Trip Sequence No.")
        {
            Clustered = true;
        }
        key(hwmKey1; "Point of Departure Code", "Point of Arrival Code")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Route No.", "Trip Sequence No.", "Reference No.", Description, Status)
        {
        }
    }
    var
        mRoute: Codeunit "HWM CTR Route Management";

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsertRouteTrip(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteTripOnInsert(Rec, xRec);
        OnAfterOnInsertRouteTrip(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModifyRouteTrip(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteTripOnModify(Rec);
        OnAfterOnModifyRouteTrip(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDeleteRouteTrip(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteTripOnDelete(Rec);
        OnAfterOnDeleteRouteTrip(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRenameRouteTrip(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteTripOnRename(Rec);
        OnAfterOnRenameRouteTrip(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsertRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsertRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModifyRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModifyRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRenameRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRenameRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDeleteRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDeleteRouteTrip(var RouteTrip: Record "HWM CTR Route Trip"; var IsHandled: Boolean)
    begin
    end;
}