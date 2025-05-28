tableextension 50101 LSCMemberContactTableExt extends "LSC Member Contact"
{
    fields
    {
        field(50101; Remark; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Remark';

        }





    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}