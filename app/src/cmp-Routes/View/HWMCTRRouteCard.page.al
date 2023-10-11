/// <summary>
/// Component:  Routes
/// </summary>
page 50018 "HWM CTR Route Card"
{
    AdditionalSearchTerms = 'HWM CTR Route';
    ApplicationArea = All;
    Caption = 'HWM CTR Route';
    PageType = Card;
    QueryCategory = 'HWM CTR Route';

    RefreshOnActivate = true;
    SourceTable = "HWM CTR Route";
    SourceTableView = sorting("No.");
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
                    field("No."; Rec."No.")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the No. field';
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
                    field("Reference No."; Rec."Reference No.")
                    {
                        ToolTip = 'Specifies the value of the "Reference No." field';
                    }
                    field("Description"; Rec.Description)
                    {
                        ToolTip = 'Specifies the value of the Description field';
                    }
                }
                group(GeneralRight)
                {
                    ShowCaption = false;
                    field(Status; Rec.Status)
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Status field';
                    }
                    field(ProcessingStatus; Rec."Processing Status")
                    {
                        ToolTip = 'Specifies the value of the "Processing Status" field';
                        Visible = false;
                    }
                }
            }

            part(RouteTrips; "HWM CTR Route Trip ListPart")
            {
                Caption = 'Route Trips';
                SubPageLink = "Route No." = field("No.");
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
                RunPageLink = "Table No." = const(50002), "Primary Key Field 1 Value" = field("No."), "Changed Record SystemId" = field(SystemId);
                RunPageMode = View;
            }
        }
        area(Promoted)
        {
        }
    }

    var
        mRoute: Codeunit "HWM CTR Route Management";


    trigger OnOpenPage()
    begin
    end;

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;
}