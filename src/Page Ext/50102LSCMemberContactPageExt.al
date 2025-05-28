pageextension 50102 LSCMemberContactPageExt extends "LSC Member Contact"
{
    layout
    {
        addafter("Name")
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
                Caption = 'Remark';
                Visible = true;
               // ShowMandatory = true;

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