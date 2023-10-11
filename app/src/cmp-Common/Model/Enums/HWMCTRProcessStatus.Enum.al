/// <summary>
/// Component: Common
/// </summary>
enum 50002 "HWM CTR Process Status"
{
    Caption = 'HWM CTR Process Status';
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Processing)
    {
        Caption = 'Processing';
    }
    value(2; Completed)
    {
        Caption = 'Completed';
    }
    value(3; Error)
    {
        Caption = 'Error';
    }
}
