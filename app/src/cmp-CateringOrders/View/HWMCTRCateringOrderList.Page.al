/// <summary>
/// Component:  CateringOrders
/// </summary>
page 50009 "HWM CTR Catering Order List"
{
    AdditionalSearchTerms = 'HWM CTR Catering Order';
    ApplicationArea = All;

    Caption = 'HWM CTR Catering Order';
    CardPageId = "HWM CTR Catering Order Card";
    Editable = false;
    PageType = List;
    QueryCategory = 'HWM CTR Catering Order';

    SourceTable = "HWM CTR Catering Order";
    SourceTableView = sorting("No.");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the "Reference No." field';
                }
                field("Route No."; Rec."Route No.")
                {
                    ToolTip = 'Specifies the value of the "Route No." field';
                }
                field("Route Name"; Rec."Route Name")
                {
                    ToolTip = 'Specifies the value of the "Route Name" field';
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
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the "Starting Date" field';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the "Ending Date" field';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the "Description" field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(ProcessingStatus; Rec."Processing Status")
                {
                    ToolTip = 'Specifies the value of the "Processing Status" field';
                    Visible = false;
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