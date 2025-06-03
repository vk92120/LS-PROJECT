tableextension 50117 LSCPostedStatementTableExt extends "LSC Posted Statement Line"
{
    var
        PmtTransactionsTEMP: Record "LSC Trans. Payment Entry" temporary;
        PmtTransactions: Record "LSC Trans. Payment Entry";
        TransactionStatus: Record "LSC Transaction Status";

    procedure LookupTransAmount(IsTransAmountLCY: Boolean)
    begin
        PmtTransactionsTEMP.Reset();
        PmtTransactionsTEMP.DeleteAll();

        PmtTransactions.Reset();
        PmtTransactions.SetRange("Tender Type","Tender Type");
        PmtTransactions.SetFilter("Currency Code", '%1',"Currency Code");
        PmtTransactions.SetFilter("Card No.", '%1',"Tender Type Card No.");

        TransactionStatus.Reset();
        TransactionStatus.SetCurrentKey("Statement No.");
        TransactionStatus.SetRange("Statement No.","Statement No.");
        if "Staff ID" <> '' then
            PmtTransactions.SetRange("Staff ID","Staff ID")
        else
            if "POS Terminal No." <> '' then
                TransactionStatus.SetRange("POS Terminal No.","POS Terminal No.");
        if TransactionStatus.FindSet() then
            repeat
                PmtTransactions.SetRange("Store No.", TransactionStatus."Store No.");
                PmtTransactions.SetRange("POS Terminal No.", TransactionStatus."POS Terminal No.");
                PmtTransactions.SetRange("Transaction No.", TransactionStatus."Transaction No.");
                if PmtTransactions.FindSet() then
                    repeat
                        PmtTransactionsTEMP := PmtTransactions;
                        PmtTransactionsTEMP.Insert();
                    until PmtTransactions.Next() = 0;
            until TransactionStatus.Next() = 0;

        if IsTransAmountLCY then
            Page.RunModal(0, PmtTransactionsTEMP, PmtTransactionsTEMP."Amount Tendered")
        else
            Page.RunModal(0, PmtTransactionsTEMP, PmtTransactionsTEMP."Amount in Currency");
    end;
}