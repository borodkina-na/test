/// <summary>
/// Component:  Common
/// </summary> 
table 50001 "HWM CTR Setup"
{
    Caption = 'HWM CTR Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(10; "Route Nos."; Code[20])
        {
            Caption = 'Route Series No.';
            TableRelation = "No. Series"."Code";
            ValidateTableRelation = true;
        }
        field(11; "Catering Order Nos."; Code[20])
        {
            Caption = 'Catering Order Series No.';
            TableRelation = "No. Series"."Code";
            ValidateTableRelation = true;
        }
        field(12; "Loading Nos."; Code[20])
        {
            Caption = 'Loading Document Series No.';
            TableRelation = "No. Series"."Code";
            ValidateTableRelation = true;
        }
        field(30; "Catering Location Code"; Code[10])
        {
            Caption = 'Catering Location Code';
            TableRelation = Location."Code";
            ValidateTableRelation = true;
        }
    }

    keys
    {
        key(hwmPK; "Primary Key")
        {
            Clustered = true;
        }
    }
}