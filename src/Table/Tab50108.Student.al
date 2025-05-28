table 50108 Student
{
    Caption = 'Student';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Roll No."; Code[10])
        {
            Caption = 'Roll No.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Marks; Integer)
        {
            Caption = 'Marks';
        }
        field(4; Subject; Text[30])
        {
            Caption = 'Subject';
        }
    }
    keys
    {
        key(PK; "Roll No.")
        {
            Clustered = true;
        }
    }
}
