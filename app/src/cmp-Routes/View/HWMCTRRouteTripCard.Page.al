/// <summary>
/// Component:      Routes
/// </summary>
page 50006 "HWM CTR Route Trip Card"
{
    AdditionalSearchTerms = 'HWM CTR Route Trip';
    ApplicationArea = All;
    Caption = 'HWM CTR Route Trip';
    PageType = Card;
    QueryCategory = 'HWM CTR Route Trip';

    RefreshOnActivate = true;
    SourceTable = "HWM CTR Route Trip";
    SourceTableView = sorting("Route No.", "Trip Sequence No.");
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                group(GeneralLeft)
                {
                    ShowCaption = false;
                    field("Route No."; Rec."Route No.")
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Route No. field';
                    }
                    field("Route Name"; Rec."Route Name")
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Route Name field';
                    }
                    field("SystemId"; Rec.SystemId)
                    {
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the value of the SystemId field';
                        trigger OnAssistEdit()
                        begin
                            Message('%1', Rec.SystemId);
                        end;
                    }
                    field("Trip Sequence No."; Rec."Trip Sequence No.")
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Trip Sequence No. field';
                        ShowMandatory = true;
                    }
                    field(Description; Rec.Description)
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Description field';
                    }
                }
                group(GeneralRight)
                {
                    ShowCaption = false;
                    field("Status"; Rec."Status")
                    {
                        ToolTip = 'Specifies the value of the Status field';
                    }
                    field("Processing Status"; Rec."Processing Status")
                    {
                        ToolTip = 'Specifies the value of the Processing Status field';
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
            action("Change Log")
            {
                Caption = 'Change Log';
                ToolTip = 'View Change Log List page.';
                Image = ChangeLog;
                RunObject = Page "Change Log Entries";
                RunPageView = sorting("Table No.", "Primary Key Field 1 Value");
                RunPageLink = "Table No." = const(50003), "Primary Key Field 1 Value" = field("Route No."), "Changed Record SystemId" = field(SystemId);
                RunPageMode = View;
            }
        }
        area(Promoted)
        {
        }
    }

    var

    trigger OnOpenPage()
    begin

    end;

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

}