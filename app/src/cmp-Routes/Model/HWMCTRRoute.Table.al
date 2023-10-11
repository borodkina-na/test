/// <summary>
/// Component:  Routes
/// </summary>
table 50002 "HWM CTR Route"
{
    Caption = 'HWM CTR Route';
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", Description;
    DrillDownPageId = "HWM CTR Route List";
    LookupPageId = "HWM CTR Route List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'Route No.';
            trigger OnValidate()
            begin
                mRoute.ValidateFldRouteOnNo(Rec, xRec);
            end;
        }
        field(2; "Reference No."; Code[150])
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
        Field(10; "Departure time"; Time)
        {
            Caption = 'Departure time';
        }
        Field(11; "Arrival time"; Time)
        {
            Caption = 'Arrival time';
        }
        Field(12; "Duration"; Time)
        {
            Caption = 'Route duration';
        }
        Field(13; "Coefficient 1"; Decimal)
        {
            Caption = 'Coefficient 1';
        }
        Field(14; "Coefficient 2"; Decimal)
        {
            Caption = 'Coefficient 2';
        }
        Field(15; "Coefficient 3"; Decimal)
        {
            Caption = 'Coefficient 3';
        }
        Field(16; "Coefficient 4"; Decimal)
        {
            Caption = 'Coefficient 4';
        }
        Field(17; "SPH"; Decimal)
        {
            Caption = 'SPH';
        }
        Field(18; "Target"; Decimal)
        {
            Caption = 'Target';
        }
        Field(19; "Region Code"; Code[10])
        {
            Caption = 'Region Code';
        }
        field(21; "Destination Code"; Code[10])
        {
            Caption = 'Destination Code';
            TableRelation = "Country/Region"."Code";
            ValidateTableRelation = true;
        }

    }
    keys
    {
        key(hwmPK; "No.")
        {
            Clustered = true;
        }
        key(hwmKey1; Status, "Processing Status")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Status)
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
        OnBeforeOnInsertRoute(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteOnInsert(Rec, xRec);
        OnAfterOnInsertRoute(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModifyRoute(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteOnModify(Rec);
        OnAfterOnModifyRoute(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDeleteRoute(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteOnDelete(Rec);
        OnAfterOnDeleteRoute(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRenameRoute(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRouteOnRename(Rec);
        OnAfterOnRenameRoute(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsertRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsertRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModifyRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModifyRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRenameRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRenameRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDeleteRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDeleteRoute(var Route: Record "HWM CTR Route"; var IsHandled: Boolean)
    begin
    end;
}