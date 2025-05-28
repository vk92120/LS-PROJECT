pageextension 50106 LSCTransactionRegister extends "LSC Transaction Register"
{
    layout
    {
        addafter("Receipt No.")
        {
            field("Member Card No."; Rec."Member Card No.")
            {
                ApplicationArea = All;
                Visible = true;
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