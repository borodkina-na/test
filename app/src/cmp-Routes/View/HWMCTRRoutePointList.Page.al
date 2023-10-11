/// <summary>
/// Component:  Routes
/// </summary>
page 50007 "HWM CTR Route Point List"
{
    AdditionalSearchTerms = 'HWM CTR Route Point List';
    ApplicationArea = All;

    Caption = 'HWM CTR Route Point List';
    CardPageId = "HWM CTR Route Point Card";
    Editable = true;
    PageType = List;
    QueryCategory = 'HWM CTR Route Point';

    SourceTable = "HWM CTR Route Point";
    SourceTableView = sorting(Code);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Processing Status"; Rec."Processing Status")
                {
                    ToolTip = 'Specifies the value of the Processing Status field';
                }
                field("Address"; Rec."Address")
                {
                    ToolTip = 'Specifies the value of the Address field';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field';
                }
                field("City"; Rec."City")
                {
                    ToolTip = 'Specifies the value of the City field';
                }
                field("County"; Rec."County")
                {
                    ToolTip = 'Specifies the value of the County field';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field';
                }
                field("Coordinates"; Rec."Coordinates")
                {
                    ToolTip = 'Specifies the value of the Coordinates field';
                }
                field("Map Service Link"; Rec."Map Service Link")
                {
                    ToolTip = 'Specifies the value of the Map Service Link field';
                }
                field("Declaration Type"; Rec."Declaration Type")
                {
                    ToolTip = 'Specifies the value of the Declaration Type field';
                }
                field("Allow Loading"; Rec."Allow Loading")
                {
                    ToolTip = 'Specifies the value of the Allow Loading field';
                }
                field("Allow Unloading"; Rec."Allow Unloading")
                {
                    ToolTip = 'Specifies the value of the Allow Unloading field';
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