/// <summary>
/// Component: Attachment
/// </summary>
codeunit 50000 "HWM CTR Attach. Event Subsc."
{
    Subtype = Normal;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', true, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    begin
        DocumentAttachment.SetRange("HWM CTR RecordId", RecRef.RecordId);
        FlowFieldsEditable := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', true, true)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin
        DocumentAttachment.Validate("HWM CTR RecordId", RecRef.RecordId);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', true, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin
        RecRef.Get(DocumentAttachment."HWM CTR RecordId");
    end;
}