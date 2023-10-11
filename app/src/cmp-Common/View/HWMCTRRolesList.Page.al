/// <summary>
/// Component:  Common
/// </summary>
page 50001 "HWM CTR Roles List"
{
    AdditionalSearchTerms = 'HWM CTR Roles';
    ApplicationArea = All;

    Caption = 'HWM CTR Roles';
    Editable = true;
    PageType = List;
    QueryCategory = 'HWM CTR Roles';

    SourceTable = "HWM CTR Role";
    SourceTableView = sorting("Code");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field';
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