/// <summary>
/// Component:  Loadings
/// </summary>
table 50010 "HWM CTR Loading Header"
{
    Caption = 'HWM CTR Loading';
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", Description;
    DrillDownPageId = "HWM CTR Loading Document List";
    LookupPageId = "HWM CTR Loading Document Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Loading Document No.';
            trigger OnValidate()
            begin
                mLoading.ValidateFldLoadingOnNo(Rec, xRec);
            end;
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
        field(7; "Reference No."; Code[50])
        {
            Caption = 'Reference No.';
        }
        field(10; "Order No."; Code[10])
        {
            Caption = 'Order No.';
            TableRelation = "HWM CTR Catering Order Trip"."Catering Order No.";
        }
        field(11; "Order Trip No."; Integer)
        {
            Caption = 'Order Trip No.';
            TableRelation = "HWM CTR Catering Order Trip"."Order Trip No.";
        }
        field(100; "Route No."; Code[10])
        {
            Caption = 'Route No.';
            FieldClass = FlowField;
            CalcFormula = lookup("HWM CTR Catering Order Trip"."Route No." where("Catering Order No." = field("Order No."), "Order Trip No." = field("Order Trip No.")));
            Editable = false;
        }
        field(101; "Order Trip Ref. No."; Code[50])
        {
            Caption = 'Order Trip Reference No.';
            FieldClass = FlowField;
            CalcFormula = lookup("HWM CTR Catering Order Trip"."Reference No." where("Catering Order No." = field("Order No."), "Order Trip No." = field("Order Trip No.")));
            Editable = false;
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
        fieldgroup(DropDown; "No.", "Reference No.", Description, Status)
        {
        }
    }
    var
        mLoading: Codeunit "HWM CTR Loading Management";

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsertLoading(Rec, IsHandled);
        if not IsHandled then
            mLoading.ValidateTblLoadingOnInsert(Rec, xRec);
        OnAfterOnInsertLoading(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModifyLoading(Rec, IsHandled);
        if not IsHandled then
            mLoading.ValidateTblLoadingOnModify(Rec);
        OnAfterOnModifyLoading(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDeleteLoading(Rec, IsHandled);
        if not IsHandled then
            mLoading.ValidateTblLoadingOnDelete(Rec);
        OnAfterOnDeleteLoading(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRenameLoading(Rec, IsHandled);
        if not IsHandled then
            mLoading.ValidateTblLoadingOnRename(Rec);
        OnAfterOnRenameLoading(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsertLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsertLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModifyLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModifyLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRenameLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRenameLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDeleteLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDeleteLoading(var Loading: Record "HWM CTR Loading Header"; var IsHandled: Boolean)
    begin
    end;
}