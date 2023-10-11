/// <summary>
/// Component:      Common
/// </summary>
page 50000 "HWM CTR Role Center"
{
    Caption = 'HWM CTR Rolecenter';
    PageType = RoleCenter;
    UsageCategory = None;

    layout
    {
        area(RoleCenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                ApplicationArea = All;
            }
            part(Control16; "Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = All;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = All;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Create Loading")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Create Loading';
                Image = NewShipment;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ToolTip = 'Create New Loading';
            }
        }
        //TODO: add report sections & lists
        area(Sections)
        {
            group("Caterings")
            {
                Caption = 'Catering';
                action("Catering Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Catering Orders';
                    RunObject = Page "HWM CTR Catering Order List";
                    RunPageMode = View;
                }
                action("Catering Trips")
                {
                    ApplicationArea = All;
                    Caption = 'Order Trips';
                    RunObject = Page "HWM CTR Catering Order Trip L";
                    RunPageMode = View;
                }
                action("Catering Documents")
                {
                    ApplicationArea = All;
                    Caption = 'Order Documents';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
            }
            group("Documents")
            {
                Caption = 'Loadings';
                action("Loadings")
                {
                    ApplicationArea = All;
                    Caption = 'Loadings';
                    RunObject = Page "HWM CTR Loading Document List";
                    RunPageMode = View;
                }
                action("Unloading Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Unloading Orders';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
                action("Phys. Inventory")
                {
                    ApplicationArea = All;
                    Caption = 'Phys. Inventory';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
            }
            group("Catalogs")
            {
                action("Resources")
                {
                    ApplicationArea = All;
                    Caption = 'Resources';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
                action("Trolley Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Trolley Templates';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
                action("Trolleys")
                {
                    ApplicationArea = All;
                    Caption = 'Trolleys';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
                action("Drawers")
                {
                    ApplicationArea = All;
                    Caption = 'Drawers';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
            }
            group("POS Sales")
            {
                Caption = 'POS Sales';
                action("Z Reports")
                {
                    ApplicationArea = All;
                    Caption = 'Z-Reports';
                    RunObject = Page "HWM CTR Catering Order List";
                    RunPageMode = View;
                }
                action("POS Documents")
                {
                    ApplicationArea = All;
                    Caption = 'POS Documents';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
            }
            group("Routes")
            {
                Caption = 'Routes';
                action("RouteList")
                {
                    ApplicationArea = All;
                    Caption = 'Routes';
                    RunObject = Page "HWM CTR Route List";
                    RunPageMode = View;
                }
                action("RoutePoints")
                {
                    ApplicationArea = All;
                    Caption = 'Route Points';
                    RunObject = Page "HWM CTR Route Point List";
                    RunPageMode = Edit;
                }
            }
            group("Setup")
            {
                Caption = 'Setup';
                ToolTip = 'Setup Catering App';
                action(SetupSection)
                {
                    ApplicationArea = All;
                    Caption = 'Setup';
                    RunObject = Page "HWM CTR Setup Card";
                    RunPageMode = Edit;
                }
            }
        }
    }
}
