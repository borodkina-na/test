/// <summary>
/// Component:      Common
/// </summary>
enum 50000 "HWM CTR Status"
{
    Caption = 'HWM CTR Status';
    Extensible = true;

    value(0; "Draft")
    {
        Caption = 'Draft';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; Inactive)
    {
        Caption = 'Inactive';
    }
}