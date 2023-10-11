/// <summary>
/// Component:  Common
/// </summary> 
table 50000 "HWM CTR Role"
{
    Caption = 'HWM CTR Role';
    DataClassification = CustomerContent;

    DrillDownPageId = "HWM CTR Roles List";
    LookupPageId = "HWM CTR Roles List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Status; enum "HWM CTR Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
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
}