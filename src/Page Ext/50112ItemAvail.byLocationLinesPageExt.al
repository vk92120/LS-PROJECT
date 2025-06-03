pageextension 50112 ItemAvailbyLocationLines extends "Item Avail. by Location Lines"
{
    layout
    {
        addbefore("QtyAvailable")
        {
            field(QtySoldNotPosted; QtySoldNotPosted)
            {
                Caption = 'Qty. Sold not Posted';
                DecimalPlaces = 0 : 5;
                DrillDown = true;

                trigger OnDrillDown()
                begin
                    ShowTransactions();
                end;
            }

        }
        modify(QtyAvailable)
        {
            Visible = true;
        }

    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    begin
        SetLocation;
    end;

    var
        QtySoldNotPosted: Decimal;
        SalesLine: Record "Sales Line";
        PurchLine: Record "Purchase Line";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComponent: Record "Prod. Order Component";
        AvailabilityMgt: Codeunit "Available Management";
        BOUtils: Codeunit "LSC BO Utils";
        Store: Record "LSC Store";
        TransSalesEntry: Record "LSC Trans. Sales Entry";

    internal procedure SetLocation()
    begin
        if Item."No." <> '' then begin
            Item.SetRange("Location Filter", Rec.Code);
            Store.SetCurrentKey("Location Code");
            Store.SetRange("Location Code", Rec.Code);
            if Store.Find('-') then
                Item.SetRange("LSC Store Filter", Store."No.")
            else
                Item.SetRange("LSC Store Filter", '');
            QtySoldNotPosted := BOUtils.ReturnQtySoldNotPosted(Item."No.",
              Item.GetFilter("LSC Store Filter"),
              Item.GetFilter("Location Filter"),
              Item.GetFilter("Variant Filter"),
              Item.GetFilter("Date Filter"));
            Item.CalcFields(
              Inventory,
              "Qty. on Purch. Order",
              "Qty. on Sales Order",
              "Net Change",
              "Scheduled Receipt (Qty.)",
              "Qty. on Component Lines");
            ExpectedInventory := AvailabilityMgt.ExpectedQtyOnHand(Item, true, 0, QtyAvailable, 99991231D);
            ExpectedInventory -= QtySoldNotPosted;
            QtyAvailable -= QtySoldNotPosted;
        end;
    end;

    local procedure ShowSalesLines()
    begin
        SetLocation;
        SalesLine.Reset;
        SalesLine.SetCurrentKey("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date");
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);

        SalesLine.SetRange("No.", Item."No.");
        SalesLine.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        SalesLine.SetFilter("Drop Shipment", Item.GetFilter("Drop Shipment Filter"));
        SalesLine.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        SalesLine.SetFilter("Shortcut Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        SalesLine.SetFilter("Shortcut Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        SalesLine.SetFilter("Shipment Date", Item.GetFilter("Date Filter"));
        PAGE.Run(0, SalesLine);
    end;

    local procedure ShowPurchLines()
    begin
        SetLocation;
        PurchLine.Reset;
        PurchLine.SetCurrentKey(
          "Document Type", Type, "No.", "Variant Code", "Drop Shipment",
          "Location Code", "Expected Receipt Date");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        PurchLine.SetRange("No.", Item."No.");
        PurchLine.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        PurchLine.SetFilter("Drop Shipment", Item.GetFilter("Drop Shipment Filter"));
        PurchLine.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        PurchLine.SetFilter("Shortcut Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        PurchLine.SetFilter("Shortcut Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        PurchLine.SetFilter("Expected Receipt Date", Item.GetFilter("Date Filter"));
        PAGE.Run(0, PurchLine);
    end;

    internal procedure ShowSchedReceipt()
    begin
        SetLocation;
        ProdOrderLine.Reset;
        ProdOrderLine.SetCurrentKey("Item No.", "Variant Code", "Location Code", Status, "Ending Date");
        ProdOrderLine.SetRange("Item No.", Item."No.");
        ProdOrderLine.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        ProdOrderLine.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        ProdOrderLine.SetFilter("Shortcut Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        ProdOrderLine.SetFilter("Shortcut Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        ProdOrderLine.SetFilter("Ending Date", Item.GetFilter("Date Filter"));
        PAGE.Run(0, ProdOrderLine);
    end;

    internal procedure ShowSchedNeed()
    begin
        SetLocation;
        ProdOrderComponent.Reset;
        ProdOrderComponent.SetCurrentKey("Item No.", "Variant Code", "Location Code", Status, "Due Date");
        ProdOrderComponent.SetRange("Item No.", Item."No.");
        ProdOrderComponent.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        ProdOrderComponent.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        ProdOrderComponent.SetFilter("Shortcut Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        ProdOrderComponent.SetFilter("Shortcut Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        ProdOrderComponent.SetFilter("Due Date", Item.GetFilter("Date Filter"));
        PAGE.Run(0, ProdOrderComponent);
    end;

    internal procedure ShowItemLedgerEntries()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        SetLocation;
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange("Item No.", Item."No.");
        ItemLedgerEntry.SetFilter("Posting Date", Item.GetFilter("Date Filter"));
        ItemLedgerEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        ItemLedgerEntry.SetFilter("Drop Shipment", Item.GetFilter("Drop Shipment Filter"));
        ItemLedgerEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        ItemLedgerEntry.SetFilter("Global Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        ItemLedgerEntry.SetFilter("Global Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        PAGE.Run(0, ItemLedgerEntry);
    end;

    internal procedure ShowTransactions()
    begin
        SetLocation;
        TransSalesEntry.Reset;
        TransSalesEntry.SetCurrentKey("Item No.", "Variant Code", Date, "Store No.");
        TransSalesEntry.SetFilter("Item No.", Item."No.");
        TransSalesEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        TransSalesEntry.SetFilter(Date, Item.GetFilter("Date Filter"));
        TransSalesEntry.SetFilter("Store No.", Item.GetFilter("LSC Store Filter"));
        PAGE.Run(0, TransSalesEntry);
    end;
}