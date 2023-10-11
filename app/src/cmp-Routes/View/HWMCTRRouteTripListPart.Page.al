/// <summary>
/// Component:     Route
/// </summary>

page 50004 "HWM CTR Route Trip ListPart"
{
    PageType = ListPart;
    Caption = 'HWM CTR Route Trip ListPart';
    Editable = true;
    SourceTable = "HWM CTR Route Trip";
    Autosplitkey = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Trip Sequence No."; Rec."Trip Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Trip Sequence No. field';
                    Visible = false;
                    ShowMandatory = true;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the "Reference No." field';
                }
                field("Point of Departure Code"; Rec."Point of Departure Code")
                {
                    ToolTip = 'Specifies the value of the "Point of Departure Code" field';
                }
                field("Point of Arrival Code"; Rec."Point of Arrival Code")
                {
                    ToolTip = 'Specifies the value of the "Point of Arrival Code" field';
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
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }
}