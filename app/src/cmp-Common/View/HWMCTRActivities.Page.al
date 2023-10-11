/// <summary>
/// Component: Common
/// </summary>
page 50003 "Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";

    layout
    {
        area(content)
        {
            cuegroup(Control54)
            {
                CueGroupLayout = Wide;
                ShowCaption = false;
                field("Sales sum this month"; Rec."My Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Sales Invoice List";
                    ToolTip = 'My Incoming Documents';

                    trigger OnDrillDown()
                    begin
                        //ActivitiesMgt.DrillDownSalesThisMonth();
                    end;
                }
                field("Sales quantity this month"; Rec."Sales This Month")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of sales in the current month.';

                    trigger OnDrillDown()
                    begin
                        //ActivitiesMgt.DrillDownCalcOverdueSalesInvoiceAmount();
                    end;
                }
                field("Payments this month"; Rec."Non-Applied Payments")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Unprocessed Payments';

                    trigger OnDrillDown()
                    begin
                        //ActivitiesMgt.DrillDownCalcOverdueSalesInvoiceAmount();
                    end;
                }
            }
            cuegroup(Welcome)
            {
                Caption = 'Welcome';
                Visible = TileGettingStartedVisible;

                actions
                {
                    action(GettingStartedTile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Return to Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Learn how to get started with Dynamics 365.';

                        trigger OnAction()
                        begin
                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
            cuegroup("Sales")
            {
                Caption = 'Sales';
                field("Ongoing Sales Quotes"; Rec."Ongoing Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    DrillDownPageID = "Sales Quotes";
                    ToolTip = 'Sales Orders ';
                }
            }
            cuegroup(Payments)
            {
                Caption = 'Payments';
                field("Non-Applied Payments"; Rec."Non-Applied Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unprocessed Payments';
                    Image = Cash;
                    ToolTip = 'Specifies imported bank transactions for payments that are not yet reconciled in the Payment Reconciliation Journal window.';

                    trigger OnDrillDown()
                    begin
                        //CODEUNIT.Run(CODEUNIT::"Pmt. Rec. Journals Launcher");
                    end;
                }
                field("Average Collection Days"; Rec."Average Collection Days")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how long customers took to pay invoices in the last three months. This is the average number of days from when invoices are issued to when customers pay the invoices.';
                }
            }
            cuegroup("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                field("My Incoming Documents"; Rec."My Incoming Documents")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies incoming documents that are assigned to you.';
                }
                field("Awaiting Verfication"; Rec."Inc. Doc. Awaiting Verfication")
                {
                    ApplicationArea = Suite;
                    DrillDown = true;
                    ToolTip = 'Specifies incoming documents in OCR processing that require you to log on to the OCR service website to manually verify the OCR values before the documents can be received.';
                    Visible = ShowAwaitingIncomingDoc;

                    trigger OnDrillDown()
                    var
                        OCRServiceSetup: Record "OCR Service Setup";
                    begin
                        if OCRServiceSetup.Get() then
                            if OCRServiceSetup.Enabled then
                                HyperLink(OCRServiceSetup."Sign-in URL");
                    end;
                }
            }
            cuegroup("Data Integration")
            {
                Caption = 'Data Integration';
                Visible = ShowDataIntegrationCues;
                field("CDS Integration Errors"; Rec."CDS Integration Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Integration Errors';
                    DrillDownPageID = "Integration Synch. Error List";
                    ToolTip = 'Specifies the number of errors related to data integration.';
                    Visible = ShowIntegrationErrorsCue;
                }
                field("Coupled Data Synch Errors"; Rec."Coupled Data Synch Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Coupled Data Synchronization Errors';
                    DrillDownPageID = "CRM Skipped Records";
                    ToolTip = 'Specifies the number of errors that occurred in the latest synchronization of coupled data between Business Central and Dynamics 365 Sales.';
                    Visible = ShowD365SIntegrationCues;
                }
            }
            cuegroup("Get started")
            {
                Caption = 'Get started';
                Visible = ReplayGettingStartedVisible;

                actions
                {
                    action(ShowStartInMyCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Try with my own data';
                        Image = TileSettings;
                        ToolTip = 'Set up My Company with the settings you choose. We''ll show you how, it''s easy.';
                        Visible = false;

                        trigger OnAction()
                        begin
                            //if UserTours.IsAvailable() and O365GettingStartedMgt.AreUserToursEnabled() then
                            //UserTours.StartUserTour(O365GettingStartedMgt.GetChangeCompanyTourID());
                        end;
                    }
                    action(ReplayGettingStarted)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Replay Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Show the Getting Started guide again.';

                        trigger OnAction()
                        var
                            O365GettingStarted: Record "O365 Getting Started";
                        begin
                            if O365GettingStarted.Get(UserId, ClientTypeManagement.GetCurrentClientType()) then begin
                                O365GettingStarted."Tour in Progress" := false;
                                O365GettingStarted."Current Page" := 1;
                                O365GettingStarted.Modify();
                                Commit();
                            end;

                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshData)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Data';
                Image = Refresh;
                ToolTip = 'Refreshes the data needed to make complex calculations.';

                trigger OnAction()
                begin
                    Rec."Last Date/Time Modified" := 0DT;
                    Rec.Modify();

                    CODEUNIT.Run(CODEUNIT::"Activities Mgt.");
                    CurrPage.Update(false);
                end;
            }
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    // trigger OnAfterGetCurrRecord()
    // begin
    //     if UserTours.IsAvailable() and O365GettingStartedMgt.AreUserToursEnabled() then
    //         O365GettingStartedMgt.UpdateGettingStartedVisible(TileGettingStartedVisible, ReplayGettingStartedVisible);
    // end;

    trigger OnAfterGetRecord()
    begin
        SetActivityGroupVisibility();
    end;

    // trigger OnInit()
    // begin
    //     if UserTours.IsAvailable() and O365GettingStartedMgt.AreUserToursEnabled() then
    //         O365GettingStartedMgt.UpdateGettingStartedVisible(TileGettingStartedVisible, ReplayGettingStartedVisible);
    // end;

    trigger OnOpenPage()
    var
        IntegrationSynchJobErrors: Record "Integration Synch. Job Errors";
        OCRServiceMgt: Codeunit "OCR Service Mgt.";
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        ConfPersonalizationMgt: Codeunit "Conf./Personalization Mgt.";
        CDSIntegrationMgt: Codeunit "CDS Integration Mgt.";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        NewRecord: Boolean;
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
            NewRecord := true;
        end;

        Rec.SetFilter("Due Next Week Filter", '%1..%2', CalcDate('<1D>', WorkDate()), CalcDate('<1W>', WorkDate()));

        HasCamera := Camera.IsAvailable();

        //PrepareOnLoadDialog();

        ShowAwaitingIncomingDoc := OCRServiceMgt.OcrServiceIsEnable();
        ShowIntercompanyActivities := false;
        ShowDocumentsPendingDocExchService := false;
        ShowProductVideosActivities := ClientTypeManagement.GetCurrentClientType() <> CLIENTTYPE::Phone;
        ShowIntelligentCloud := not EnvironmentInfo.IsSaaS();
        IntegrationSynchJobErrors.SetDataIntegrationUIElementsVisible(ShowDataIntegrationCues);
        //ShowD365SIntegrationCues := CRMIntegrationManagement.IsIntegrationEnabled() or CDSIntegrationMgt.IsIntegrationEnabled();
        ShowIntegrationErrorsCue := ShowDataIntegrationCues and (not ShowD365SIntegrationCues);
        RoleCenterNotificationMgt.ShowNotifications();
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent();

        CalculateCueFieldValues();
    end;

    var
        ActivitiesMgt: Codeunit "Activities Mgt.";
        CuesAndKpis: Codeunit "Cues And KPIs";
        O365GettingStartedMgt: Codeunit "O365 Getting Started Mgt.";
        ClientTypeManagement: Codeunit "Client Type Management";
        EnvironmentInfo: Codeunit "Environment Information";
        Camera: Codeunit Camera;
        HasCamera: Boolean;
        ShowDocumentsPendingDocExchService: Boolean;
        ShowAwaitingIncomingDoc: Boolean;
        ShowIntercompanyActivities: Boolean;
        ShowProductVideosActivities: Boolean;
        ShowIntelligentCloud: Boolean;
        TileGettingStartedVisible: Boolean;
        ReplayGettingStartedVisible: Boolean;
        HideSatisfactionSurvey: Boolean;
        WhatIsNewTourVisible: Boolean;
        ShowD365SIntegrationCues: Boolean;
        ShowDataIntegrationCues: Boolean;
        ShowIntegrationErrorsCue: Boolean;
        HideWizardForDevices: Boolean;
        IsAddInReady: Boolean;
        IsPageReady: Boolean;
        TaskIdCalculateCue: Integer;
        PBTTelemetryCategoryLbl: Label 'PBT', Locked = true;
        PBTTelemetryMsgTxt: Label 'PBT errored with code %1 and text %2. The call stack is as follows %3.', Locked = true;

    /// <summary>
    /// CalculateCueFieldValues.
    /// </summary>
    procedure CalculateCueFieldValues()
    begin
        if (TaskIdCalculateCue <> 0) then
            CurrPage.CancelBackgroundTask(TaskIdCalculateCue);
        CurrPage.EnqueueBackgroundTask(TaskIdCalculateCue, Codeunit::"O365 Activities Dictionary");
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        O365ActivitiesDictionary: Codeunit "O365 Activities Dictionary";
    begin
        if (TaskId = TaskIdCalculateCue) THEN BEGIN
            Rec.LockTable(true);
            Rec.Get();
            O365ActivitiesDictionary.FillActivitiesCue(Results, Rec);
            Rec."Last Date/Time Modified" := CurrentDateTime;
            Rec.Modify(true);
        END
    end;

    local procedure SetActivityGroupVisibility()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
        ICSetup: Record "IC Setup";
    begin
        if DocExchServiceSetup.Get() then
            ShowDocumentsPendingDocExchService := DocExchServiceSetup.Enabled;

        if ICSetup.Get() then
            ShowIntercompanyActivities :=
              (ICSetup."IC Partner Code" <> '') and ((Rec."IC Inbox Transactions" <> 0) or (Rec."IC Outbox Transactions" <> 0));
    end;
}

