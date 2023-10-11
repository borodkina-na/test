/// <summary>
/// Component:  CateringOrders
/// </summary>
table 50008 "HWM CTR Catering Order"
{
    Caption = 'HWM CTR Catering Order';
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", Description;
    LookupPageId = "HWM CTR Catering Order List";
    DrillDownPageId = "HWM CTR Catering Order List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'Catering Order No.';
        }
        field(2; "Reference No."; Code[50])
        {
            Caption = 'Reference No.';
        }
        field(3; Description; text[100])
        {
            Caption = 'Description';
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series"."Code";
            ValidateTableRelation = true;
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
        field(11; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location."Code";
            ValidateTableRelation = true;
            //TODO: fill in by default from setup
        }
        field(12; "Transport Code"; Code[20])
        {
            Caption = 'Transport Code';
            TableRelation = Bin."Code" where("Location Code" = field("Location Code"));
            ValidateTableRelation = true;
        }
        field(20; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(21; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(100; "Route Name"; Text[100])
        {
            Caption = 'Route Name';
            FieldClass = FlowField;
            CalcFormula = lookup("HWM CTR Route".Description where("No." = field("Route No.")));
            Editable = false;
        }
        field(110; "Trips Qty."; Integer)
        {
            Caption = 'Trips Quantity';
            FieldClass = FlowField;
            CalcFormula = count("HWM CTR Catering Order Trip" where("Catering Order No." = field("No.")));
            Editable = false;
        }
    }
    keys
    {
        key(hwmPK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Reference No.", Description, Status)
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
        OnBeforeOnInsert(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCateringOrderOnInsert(Rec, xRec);
        OnAfterOnInsert(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModify(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCateringOrderOnModify(Rec);
        OnAfterOnModify(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDelete(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCateringOrderOnDelete(Rec);
        OnAfterOnDelete(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRename(Rec, IsHandled);
        if not IsHandled then
            mCateringOrder.ValidateTblCateringOrderOnRename(Rec);
        OnAfterOnRename(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDelete(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsert(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModify(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRename(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModify(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRename(var CateringOrder: Record "HWM CTR Catering Order"; var IsHandled: Boolean)
    begin
    end;

}