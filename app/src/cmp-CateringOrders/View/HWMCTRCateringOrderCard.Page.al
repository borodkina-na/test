/// <summary>
/// Component:  CateringOrders
/// </summary>
page 50010 "HWM CTR Catering Order Card"
{
    AdditionalSearchTerms = 'HWM CTR Catering Order';
    ApplicationArea = All;
    Caption = 'HWM CTR Catering Order';
    PageType = Document;
    QueryCategory = 'HWM CTR Catering Order';

    RefreshOnActivate = true;
    SourceTable = "HWM CTR Catering Order";
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
                }
                group(GeneralRight)
                {
                    ShowCaption = false;
                    field("Starting Date"; Rec."Starting Date")
                    {
                        ToolTip = 'Specifies the value of the "Starting Date" field';
                    }
                    field("Ending Date"; Rec."Ending Date")
                    {
                        ToolTip = 'Specifies the value of the "Ending Date" field';
                    }
                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field';
                        Importance = Promoted;
                    }
                    field(ProcessingStatus; Rec."Processing Status")
                    {
                        ToolTip = 'Specifies the value of the "Processing Status" field';
                        Importance = Additional;
                    }
                    field(TripQty; Rec."Trips Qty.")
                    {
                        ToolTip = 'Specifies the value of the "Trips Qty." field';
                    }
                }
            }
            part(OrderTrips; "HWM CTR Catering Order Trip LP")
            {
                Caption = 'Order Trips';
                SubPageLink = "Catering Order No." = field("No.");
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
                RunPageLink = "Table No." = const(50008), "Primary Key Field 1 Value" = field("No."), "Changed Record SystemId" = field(SystemId);
                RunPageMode = View;
            }
        }
        area(Promoted)
        {
        }
    }

    var
        mCateringOrder: Codeunit "HWM CTR Catering Order Mngt.";


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