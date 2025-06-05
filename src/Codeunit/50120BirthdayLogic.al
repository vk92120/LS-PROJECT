codeunit 50120 "Birthday Logic"
{
    trigger OnRun()
    var
        inputText: Text;
        day, month, year : Integer;
    begin
        inputText := '[Birthday]: 1 [Month]: 11 [Year]: 2024';
        ParseBirthdayText(inputText, day, month, year);
        Message('Day: %1, Month: %2, Year: %3', day, month, year);
    end;

    procedure ParseBirthdayText(inputbdaytext: Text; var bday: Integer; var bmonth: Integer; var byear: Integer)
    var
        posBday: Integer;
        posMonth: Integer;
        posYear: Integer;
        tempText: Text;
    begin
        // Find positions of the labels
        posBday := StrPos(inputbdaytext, '[Birthday]:');
        posMonth := StrPos(inputbdaytext, '[Month]:');
        posYear := StrPos(inputbdaytext, '[Year]:');

        // Extract Birthday
        if (posBday > 0) and (posMonth > 0) then begin
            tempText := CopyStr(inputbdaytext, posBday + StrLen('[Birthday]:'), posMonth - (posBday + StrLen('[Birthday]:')));
            Evaluate(bday, DelChr(tempText, '>', ' ')); // Remove spaces
        end;

        // Extract Month
        if (posMonth > 0) and (posYear > 0) then begin
            tempText := CopyStr(inputbdaytext, posMonth + StrLen('[Month]:'), posYear - (posMonth + StrLen('[Month]:')));
            Evaluate(bmonth, DelChr(tempText, '>', ' ')); // Remove spaces
        end;

        // Extract Year
        if (posYear > 0) then begin
            tempText := CopyStr(inputbdaytext, posYear + StrLen('[Year]:'), StrLen(inputbdaytext));
            Evaluate(byear, DelChr(tempText, '>', ' ')); // Remove spaces
        end;
    end;

}