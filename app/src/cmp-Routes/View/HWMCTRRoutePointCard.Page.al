/// <summary>
/// Component: Routes
/// </summary>
page 50008 "HWM CTR Route Point Card"
{
    AdditionalSearchTerms = 'HWM CTR Route Point';
    ApplicationArea = All;
    Caption = 'HWM CTR Route Point';
    PageType = Card;
    QueryCategory = 'HWM CTR Route Point';

    RefreshOnActivate = true;
    SourceTable = "HWM CTR Route Point";
    SourceTableView = sorting("Code");
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
                    field("No."; Rec."Code")
                    {
                        ToolTip = 'Specifies the value of the Code field';
                    }
                    field(Description; Rec.Description)
                    {
                        ToolTip = 'Specifies the value of the Description field';
                    }
                }
                group(GeneralRight)
                {
                    ShowCaption = false;
                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field';
                    }
                    field("Processing Status"; Rec."Processing Status")
                    {
                        ToolTip = 'Specifies the value of the Processing Status field';
                        Importance = Additional;
                        Visible = false;
                    }
                }
            }
            group("Address and Location")
            {
                Caption = 'Address & Location';
                group(ContactLeft)
                {
                    ShowCaption = false;
                    field(Address; Rec.Address)
                    {
                        ToolTip = 'Specifies the value of the Address field';
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Post Code field';
                    }
                    field(City; Rec.City)
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the City field';
                    }
                    field(County; Rec.County)
                    {
                        ToolTip = 'Specifies the value of the County field';
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        Importance = Promoted;
                        ToolTip = 'Specifies the value of the Country/Region field';
                    }
                }
                group(ContactRight)
                {
                    ShowCaption = false;
                    field(Coordinates; Rec.Coordinates)
                    {
                        ToolTip = 'Specifies the value of the Coordinates field';
                    }
                    field("Map Service Link"; Rec."Map Service Link")
                    {
                        ToolTip = 'Specifies the value of the Map Service Link field';
                    }
                }
            }
            group("Loading Settings")
            {
                Caption = 'Loading Settings';
                field("Allow Loading"; Rec."Allow Loading")
                {
                    ToolTip = 'Specifies the value of the Allow Loading field';
                }
                field("Allow Unloading"; Rec."Allow Unloading")
                {
                    ToolTip = 'Specifies the value of the Allow Unloading field';
                }
            }
            group("Tax Settings")
            {
                Caption = 'Tax Settings';
                field("Declaration Type"; Rec."Declaration Type")
                {
                    ToolTip = 'Specifies the value of the Declaration Type field';
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
                RunPageLink = "Table No." = const(50004), "Primary Key Field 1 Value" = field(Code), "Changed Record SystemId" = field(SystemId);
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

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;
}