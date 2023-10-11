/// <summary>
/// Component:  Routes
/// </summary>
page 50005 "HWM CTR Route Trip List"
{
    AdditionalSearchTerms = 'HWM CTR Route Trip List';
    ApplicationArea = All;

    Caption = 'HWM CTR Route Trip List';
    CardPageId = "HWM CTR Route Trip Card";
    Editable = true;
    PageType = List;
    QueryCategory = 'HWM CTR Route Trip';
    Autosplitkey = true;

    SourceTable = "HWM CTR Route Trip";
    SourceTableView = sorting("Route No.", "Trip Sequence No.");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Route No."; Rec."Route No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Route No. field';
                }
                field("Route Name"; Rec."Route Name")
                {
                    ToolTip = 'Specifies the value of the Route Name field';
                }
                field("Trip Sequence No."; Rec."Trip Sequence No.")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Trip Sequence No. field';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Departure Code"; Rec."Point of Departure Code")
                {
                    ToolTip = 'Specifies the value of the Point of Departure Code field';
                }
                field("Arrival Code"; Rec."Point of Arrival Code")
                {
                    ToolTip = 'Specifies the value of the Point of Arrival Code field';
                }
                field("Departure Time"; Rec."Departure Time")
                {
                    ToolTip = 'Specifies the value of the Departure Time field';
                }
                field("Arrival Time"; Rec."Arrival Time")
                {
                    ToolTip = 'Specifies the value of the Arrival Time field';
                }
                field("Date Shift"; Rec."Date Shift")
                {
                    ToolTip = 'Specifies the value of the Date Shift field';
                }
                field("Departure Country Code"; Rec."Departure Country Code")
                {
                    ToolTip = 'Specifies the value of the "Departure Country Code" field';
                }
                field("Arrival Country Code"; Rec."Arrival Country Code")
                {
                    ToolTip = 'Specifies the value of the "Arrival Country Code" field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
        area(Navigation)
        {

        }
    }
}