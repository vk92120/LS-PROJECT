codeunit 50105 PosPrintReceipt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Print Utility", OnBeforePrintSubHeader, '', false, false)]
    local procedure "LSC POS Print Utility_OnBeforePrintSubHeader"(var Sender: Codeunit "LSC POS Print Utility"; var TransactionHeader: Record "LSC Transaction Header"; Tray: Integer; var POSPrintBuffer: Record "LSC POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var IsHandled: Boolean)
    var
        MemberContact: Record "LSC Member Contact";
        MembershipCard: Record "LSC Membership Card";
        PhoneNumber: Text;
        Node: array[1] of Text[50];
        DesignString: Text;
        Value: array[10] of Text[100];
        CardNo: Code[20];
    begin
        Clear(MemberContact);
        Clear(MembershipCard);
        if TransactionHeader."Member Card No." <> '' then begin
            if MembershipCard.Get(TransactionHeader."Member Card No.") then
                if MemberContact.Get(MembershipCard."Account No.", MembershipCard."Contact No.") then
                    PhoneNumber := MemberContact."Mobile Phone No.";
        end;
        IsHandled := true;
        Node[1] := 'Phone.';
        DesignString := '#(L)##(C)##(R)##(R)';
        Value[1] := PhoneNumber;
        Tray := 1;
        Sender.AddPrintLine(1, 1, Node, Value, DesignString, false, false, false, false, Tray);
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Print Utility", OnAfterPrintLoyalty, '', false, false)]
    // local procedure "LSC POS Print Utility_OnAfterPrintLoyalty"(var Sender: Codeunit "LSC POS Print Utility"; var Transaction: Record "LSC Transaction Header"; var PrintBuffer: Record "LSC POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var DSTR1: Text[100]; MemberClubTemp: Record "LSC Member Club" temporary)
    // begin
    // end;


}
