page 50101 StudentList2
{
    ApplicationArea = All;
    Caption = 'StudentList2';
    PageType = List;
    SourceTable = Student;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Roll No."; Rec."Roll No.")
                {
                }
                field(Marks; Rec.Marks)
                {
                }
                field(Name; Rec.Name)
                {
                }
            }
        }
    }
}
