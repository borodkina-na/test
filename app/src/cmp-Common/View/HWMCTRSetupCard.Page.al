/// <summary>
/// Component:  Common
/// </summary>
page 50002 "HWM CTR Setup Card"
{
    AdditionalSearchTerms = 'HWM CTR Setup';
    ApplicationArea = All;

    Caption = 'Catering Setup';
    Editable = true;
    PageType = Card;
    QueryCategory = 'HWM CTR Setup';

    SourceTable = "HWM CTR Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Group(LeftSide)
                {
                    ShowCaption = false;
                    field("Route Nos."; Rec."Route Nos.")
                    {
                        ToolTip = 'Specifies the value of the "Route Nos." field';
                    }
                    field("Catering Order Nos."; Rec."Catering Order Nos.")
                    {
                        ToolTip = 'Specifies the value of the "Catering Order Nos." field';
                    }
                    field("Loading Nos."; Rec."Loading Nos.")
                    {
                        ToolTip = 'Specifies the value of the "Loading Nos." field';
                    }
                }
                Group(RightSide)
                {
                    ShowCaption = false;
                    field("Catering Location Code"; Rec."Catering Location Code")
                    {
                        ToolTip = 'Specifies the value of the "Catering Location Code" field';
                    }
                }
            }
        }
    }
}