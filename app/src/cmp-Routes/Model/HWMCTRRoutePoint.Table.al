/// <summary>
/// Component:  Routes
/// </summary> 
table 50004 "HWM CTR Route Point"
{
    Caption = 'HWM CTR Route Point';
    DataClassification = CustomerContent;
    LookupPageId = "HWM CTR Route Point List";
    DrillDownPageId = "HWM CTR Route Point List";
    DataCaptionFields = "Code", "Description";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Status; enum "HWM CTR Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(5; "Processing Status"; Enum "HWM CTR Process Status")
        {
            Caption = 'Processing Status';
            Editable = false;
        }
        field(10; "Address"; Text[100])
        {
            Caption = 'Address';
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = "Post Code"."Code";
            ValidateTableRelation = true;
            trigger OnLookup()
            var
                PostCode: Record "Post Code";
            begin
                if not sPostCode.LookupRec(PostCode) then
                    exit;
                Rec.City := PostCode.City;
                Rec.Validate("Post Code", PostCode."Code");
            end;

            trigger OnValidate()
            begin
                mRoute.ValidateFldRoutePointOnPostCode(Rec);
            end;
        }
        field(12; "City"; Text[100])
        {
            Caption = 'City';
        }
        field(13; County; Text[30])
        {
            Caption = 'County';
        }
        field(14; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region"."Code";
        }
        field(15; Coordinates; Text[50])
        {
            Caption = 'Coordinates';
        }
        field(16; "Map Service Link"; Text[50])
        {
            Caption = 'Map Service Link';
            ExtendedDatatype = URL;
        }
        field(20; "Declaration Type"; enum "HWM CTR Declaration Type")
        {
            Caption = 'Declaration Type';
        }
        field(30; "Allow Loading"; Boolean)
        {
            Caption = 'Allow Loading';
        }
        field(31; "Allow Unloading"; Boolean)
        {
            Caption = 'Allow Unloading';
        }
    }
    keys
    {
        key(hwmPK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, Status)
        {
        }
    }
    var
        mRoute: Codeunit "HWM CTR Route Management";
        sPostCode: Codeunit "HWM CTR Post Code Service";

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsertRoutePoint(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRoutePointOnInsert(Rec, xRec);
        OnAfterOnInsertRoutePoint(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModifyRoutePoint(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRoutePointOnModify(Rec);
        OnAfterOnModifyRoutePoint(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDeleteRoutePoint(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRoutePointOnDelete(Rec);
        OnAfterOnDeleteRoutePoint(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRenameRoutePoint(Rec, IsHandled);
        if not IsHandled then
            mRoute.ValidateTblRoutePointOnRename(Rec);
        OnAfterOnRenameRoutePoint(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsertRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsertRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModifyRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModifyRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRenameRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRenameRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDeleteRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDeleteRoutePoint(var RoutePoint: Record "HWM CTR Route Point"; var IsHandled: Boolean)
    begin
    end;
}