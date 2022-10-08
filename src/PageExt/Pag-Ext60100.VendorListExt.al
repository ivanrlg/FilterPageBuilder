pageextension 60100 "Vendor List Ext" extends "Vendor List"
{
    actions
    {
        addafter("Ledger E&ntries")
        {
            action("VendorLedgerEntries")
            {
                ApplicationArea = Suite;
                Caption = 'Ledger E&ntries Filter';
                Image = VendorLedger;
                ShortCutKey = 'Ctrl+F9';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
                trigger OnAction()
                var
                    FilterPageBuilder: FilterPageBuilder;
                    VendLedgerEntry: Record "Vendor Ledger Entry";
                    VendorLedgerEntries: Page "Vendor Ledger Entries";
                begin
                    //Adds a filter control for a table to a filter page. 
                    //The table is specified by a record data type variable that is passed to the method.
                    FilterPageBuilder.AddRecord('Vend. Ledger Entry Table', VendLedgerEntry);

                    //Adds a table field to the filter control for a table on filter page.
                    FilterPageBuilder.Addfield('Vend. Ledger Entry Table', VendLedgerEntry."Vendor No.");
                    FilterPageBuilder.Addfield('Vend. Ledger Entry Table', VendLedgerEntry."Document Type");
                    FilterPageBuilder.Addfield('Vend. Ledger Entry Table', VendLedgerEntry."Posting Date");
                    FilterPageBuilder.Addfield('Vend. Ledger Entry Table', VendLedgerEntry."Document Date");
                    FilterPageBuilder.Addfield('Vend. Ledger Entry Table', VendLedgerEntry."Amount");
                    FilterPageBuilder.Addfield('Vend. Ledger Entry Table', VendLedgerEntry."Remaining Amount");

                    //Sets the FilterPageBuilder UI caption.
                    FilterPageBuilder.PageCaption := 'Vendors Ledger Entries Filter Page';

                    //Builds and runs the filter page that includes the filter controls that are stored in FilterPageBuilder object instance.
                    if FilterPageBuilder.RunModal() then begin

                        //Sets the current sort order, key, and filters on a table.
                        VendLedgerEntry.SetView(FilterPageBuilder.GetView('Vend. Ledger Entry Table'));

                        //Applies the table view on the current record as the table view for the page, report, or XmlPort.
                        VendorLedgerEntries.SetTableView(VendLedgerEntry);
                        VendorLedgerEntries.Run();

                    end;
                end;
            }
        }
        addfirst(Category_Process)
        {
            actionref(VendorLedgerEntries_Promoted; VendorLedgerEntries)
            {
            }
        }
    }
}
