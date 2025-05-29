reportextension 50101 AgedAccountPayable extends "Aged Accounts Payable"
{
    dataset
    {
        // Add changes to dataitems and columns here
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'src\Report Layout\AgedAccountPayable.rdlc';

        }
    }
}
