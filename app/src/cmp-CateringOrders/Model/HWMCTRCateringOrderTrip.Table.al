/// <summary>
/// Component:  CateringOrders
/// </summary>
table 50011 "HWM CTR Catering Order Trip"
{
    Caption = 'HWM CTR Catering Order Trip';
    DataClassification = CustomerContent;
    DataCaptionFields = "Catering Order No.", "Point of Departure Code", "Point of Arrival Code";
    LookupPageId = "HWM CTR Catering Order Trip L";
    DrillDownPageId = "HWM CTR Catering Order Trip L";

    fields
    {
        field(1; "Catering Order No."; Code[10])
        {
            Caption = 'Catering Order No.';
            TableRelation = "HWM CTR Catering Order"."No.";
        }
        field(2; "Order Trip No."; Integer)
        {
            Caption = 'Order Trip No.';
        }
        field(3; "Reference No."; Code[50])
        {
            Caption = 'Reference No.';
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
        field(10; "Route No."; Code[10])
        {
            Caption = 'Route No.';
            TableRelation = "HWM CTR Route"."No.";
            ValidateTableRelation = true;
        }
        field(11; "Route Trip Sequence No."; Integer)
        {
            Caption = 'Route Trip Sequence No.';
            TableRelation = "HWM CTR Route Trip"."Trip Sequence No." where("Route No." = field("Route No."));
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location."Code";
            ValidateTableRelation = true;
        }
        field(21; "Transport Code"; Code[20])
        {
            Caption = 'Transport Code';
            TableRelation = Bin."Code" where("Location Code" = field("Location Code"));
            ValidateTableRelation = true;
        }
        field(30; "Point of Departure Code"; Code[10])
        {
            Caption = 'Point of Departure Code';
            TableRelation = "HWM CTR Route Point".Code;
            ValidateTableRelation = true;
        }
        field(31; "Point of Arrival Code"; Code[10])
        {
            Caption = 'Point of Arrival Code';
            TableRelation = "HWM CTR Route Point".Code;
            ValidateTableRelation = true;
        }
        field(32; "Departure DateTime"; DateTime)
        {
            Caption = 'Departure DateTime';
        }
        field(33; "Arrival DateTime"; DateTime)
        {
            Caption = 'Arrival DateTime';
        }
        field(34; "Date Shift"; Boolean)
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
        key(hwmPK; "Catering Order No.", "Order Trip No.")
        {
            Clustered = true;
        }
        key(hwmKey1; Status, "Processing Status")
        {
        }
        key(hwmKey2; "Point of Departure Code", "Point of Arrival Code")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Catering Order No.", "Order Trip No.", "Point of Departure Code", "Point of Arrival Code", Status)
        {
        }
    }
    var
        mCateringOrder: Codeunit "HWM CTR Catering Order Mngt.";

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsertCateringOrderTrip(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCateringOrderTripOnInsert(Rec, xRec);
        OnAfterOnInsertCateringOrderTrip(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModifyCateringOrderTrip(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCategingOrderTripOnModify(Rec);
        OnAfterOnModifyCateringOrderTrip(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDeleteCateringOrderTrip(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCateringOrderTripOnDelete(Rec);
        OnAfterOnDeleteCateringOrderTrip(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRenameCateringOrderTrip(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCateringOrderTripOnRename(Rec);
        OnAfterOnRenameCateringOrderTrip(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsertCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsertCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModifyCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModifyCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRenameCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRenameCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDeleteCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDeleteCateringOrderTrip(var CateringOrderTrip: Record "HWM CTR Catering Order Trip"; var IsHandled: Boolean)
    begin
    end;
}