/// <summary>
/// Component:  Routes
/// </summary>
page 50019 "HWM CTR Route List"
{
    AdditionalSearchTerms = 'HWM CTR Route';
    ApplicationArea = All;

    Caption = 'HWM CTR Route';
    CardPageId = "HWM CTR Route Card";
    Editable = false;
    PageType = List;
    QueryCategory = 'HWM CTR Route';

    SourceTable = "HWM CTR Route";
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
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the "Description" field';
                }
                field("Departure time"; Rec."Departure time")
                {
                    ToolTip = 'Specifies the value of the "Departure time" field';
                }
                field("Arrival time"; Rec."Arrival time")
                {
                    ToolTip = 'Specifies the value of the "Arrival time" field';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the "Route Duration" field';
                }
                field("Coef1"; Rec."Coefficient 1")
                {
                    ToolTip = 'Specifies the value of the "Coefficient 1" field';
                }
                field("Coef2"; Rec."Coefficient 2")
                {
                    ToolTip = 'Specifies the value of the "Coefficient 2" field';
                }
                field("Coef3"; Rec."Coefficient 3")
                {
                    ToolTip = 'Specifies the value of the "Coefficient 3" field';
                }
                field("Coef4"; Rec."Coefficient 4")
                {
                    ToolTip = 'Specifies the value of the "Coefficient 4" field';
                }
                field("SPH"; Rec.SPH)
                {
                    ToolTip = 'Specifies the value of the "SPH" field';
                }
                field("Target"; Rec.Target)
                {
                    ToolTip = 'Specifies the value of the "Target" field';
                }
                field("Region Code"; Rec."Region Code")
                {
                    ToolTip = 'Specifies the value of the "Region Code" field';
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    ToolTip = 'Specifies the value of the "Destination Code" field';
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