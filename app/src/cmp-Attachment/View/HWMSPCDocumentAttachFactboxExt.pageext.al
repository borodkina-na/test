/// <summary>
/// Component: Attachment
/// </summary>
pageextension 50000 "HWM CTR Doc. Attach. Factbox" extends "Document Attachment Factbox"
{
    /// <summary>
    /// SetNewRecordId.
    /// </summary>
    /// <param name="RecId">RecordId.</param>
    procedure SetNewRecordId(RecId: RecordId)
    begin
        Rec.SetRange("HWM CTR RecordId", RecId);
        CurrPage.Update(false);
    end;
}