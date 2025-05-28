page 50109 StudentList
{
    ApplicationArea = All;
    Caption = 'StudentList';
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
                    ToolTip = 'Specifies the value of the Roll No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.', Comment = '%';
                }
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.', Comment = '%';
                }
            }
        }
    }
}
