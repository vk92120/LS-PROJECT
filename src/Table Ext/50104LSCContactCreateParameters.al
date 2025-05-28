tableextension 50104 LSCContactCreateParameters extends "LSC Contact Create Parameters"
{
    fields
    {
        field(50104; "Remark"; Text[30])
        {
            Caption = 'Remark1';
            DataClassification = CustomerContent;
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