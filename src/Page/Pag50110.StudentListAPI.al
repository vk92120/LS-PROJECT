page 50110 StudentListAPI
{
    APIGroup = 'Custom';
    APIPublisher = 'Vivek';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'studentListAPI';
    DelayedInsert = true;
    EntityName = 'Students';
    EntitySetName = 'StudentDetail';
    PageType = API;
    SourceTable = Student;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(rollNo; Rec."Roll No.")
                {
                    Caption = 'Roll No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(marks; Rec.Marks)
                {
                    Caption = 'Marks';
                }
                field(Subject; Rec.Subject)
                {
                    Caption = 'Subject';
                }
            }
        }
    }
}
