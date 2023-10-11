/// <summary>
/// Component:     CateringOrders
/// </summary>
page 50017 "HWM CTR Catering Order Trip LP"
{
    ApplicationArea = All;
    PageType = ListPart;

    Caption = 'HWM CTR Catering Order Trip ListPart';
    Editable = true;
    Autosplitkey = true;

    SourceTable = "HWM CTR Catering Order Trip";
    SourceTableView = sorting("Catering Order No.", "Order Trip No.");
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Catering Order No."; Rec."Catering Order No.")
                {
                    ToolTip = 'Specifies the value of the Catering Order No. field';
                    Visible = false;
                }
                field("Trip Sequence No."; Rec."Order Trip No.")
                {
                    ToolTip = 'Specifies the value of the "Trip Sequence No." field';
                }
                field("Route No."; Rec."Route No.")
                {
                    ToolTip = 'Specifies the value of the Route No. field';
                }
                field("Route Name"; Rec."Route Name")
                {
                    ToolTip = 'Specifies the value of the "Route Name" field';
                }
                field("Route Trip Sequence No."; Rec."Route Trip Sequence No.")
                {
                    ToolTip = 'Specifies the value of the "Route Trip Sequence No." field';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the "Location Code" field';
                    Visible = false;
                }
                field("Transport Code"; Rec."Transport Code")
                {
                    ToolTip = 'Specifies the value of the "Transport Code" field';
                }
                field("Point of Departure Code"; Rec."Point of Departure Code")
                {
                    ToolTip = 'Specifies the value of the "Point of Departure Code" field';
                }
                field("Point of Arrival Code"; Rec."Point of Arrival Code")
                {
                    ToolTip = 'Specifies the value of the "Point of Arrival Code" field';
                }
                field("Departure DateTime"; Rec."Departure DateTime")
                {
                    ToolTip = 'Specifies the value of the "Departure DateTime" field';
                }
                field("Arrival DateTime"; Rec."Arrival DateTime")
                {
                    ToolTip = 'Specifies the value of the "Arrival DateTime" field';
                }
                field("Date Shift"; Rec."Date Shift")
                {
                    ToolTip = 'Specifies the value of the "Date Shift" field';
                }
                field("Departure Country Code"; Rec."Departure Country Code")
                {
                    ToolTip = 'Specifies the value of the "Departure Country Code" field';
                }
                field("Arrival Country Code"; Rec."Arrival Country Code")
                {
                    ToolTip = 'Specifies the value of the "Arrival Country Code" field';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Processing Status"; Rec."Processing Status")
                {
                    ToolTip = 'Specifies the value of the Processing Status field';
                }
            }
        }
    }
}