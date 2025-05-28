pageextension 50107 LSCTransactionCard extends "LSC Transaction Card"
{
    layout
    {
        addafter("Member Card No.")
        {
            field("Sell-to Contact No."; Rec."Sell-to Contact No.")
            {
                ApplicationArea = CustomerContent;
                Editable = true;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}