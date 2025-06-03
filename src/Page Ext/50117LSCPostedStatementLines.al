pageextension 50117 "LSC Posted Statement Lines" extends "LSC Posted Statement Lines"
{
    layout
    {
        modify("Trans. Amount")
        {
            trigger OnDrillDown()
            begin
                Rec.LookupTransAmount(false);
            end;
        }
        modify("Trans. Amount in LCY")
        {
            trigger OnDrillDown()
            begin
                Rec.LookupTransAmount(true);
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}