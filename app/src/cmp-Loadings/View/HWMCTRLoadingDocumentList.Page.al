/// <summary>
/// Component:  Loadings
/// </summary>
page 50021 "HWM CTR Loading Document List"
{
    AdditionalSearchTerms = 'Catering Load Documents';
    ApplicationArea = All;

    Caption = 'Catering Load Documents';
    CardPageId = "HWM CTR Loading Document Card";
    Editable = false;
    PageType = List;
    QueryCategory = 'Catering Load Documents';

    SourceTable = "HWM CTR Loading Header";
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
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the "Description" field';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the "Reference No." field';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the "Catering Order No." field';
                }
                field("Order Trip No."; Rec."Order Trip No.")
                {
                    Caption = 'Order Trip No.';
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