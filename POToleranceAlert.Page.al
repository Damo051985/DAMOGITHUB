Page 50119 "PO Tolerance Alert"
{
    // #001 20210817 CDN1.00 LEOC - Confirmation Page for Tolerance Cost control

    Editable = false;
    LinksAllowed = false;
    PageType = Worksheet;
    PopulateAllFields = false;
    SourceTable = "Purchase Line";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            field(Msg1;Msg1)
            {
                ApplicationArea = Basic;
                Style = Unfavorable;
                StyleExpr = true;
            }
            field(Msg2;Msg2)
            {
                ApplicationArea = Basic;
                Style = Unfavorable;
                StyleExpr = true;
            }
            repeater(General)
            {
                field("Line No.";"Line No.")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = POApproval;
                }
                field("Attached to Line No.";"Attached to Line No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Excel Row';
                    DrillDown = false;
                    Lookup = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = ImportPO;
                }
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("LLMS Code";"LLMS Code")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Direct Unit Cost";"Direct Unit Cost")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Market View Cost";"Market View Cost")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Tolerance Cost";"Tolerance Cost")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Tolerance Cost - Min";"Tolerance Cost - Min")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Location Code";"Location Code")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = POApproval;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if FindFirst then;

        Clear(Msg1);
        Msg1 := POLineCheck;

        Clear(Msg2);
        if AlertType = Alerttype::Approval then begin
            Msg2 := POApprovalOK;
            POApproval := true;
        end else if AlertType = Alerttype::Import then begin
            Msg2 := POImportOK;
            ImportPO := true;
        end;
    end;

    var
        Msg1: Text;
        Msg2: Text;
        AlertType: Option " ",Approval,Import;
        POLineCheck: label 'Please check the Tolerance Cost for the following lines!';
        POApprovalOK: label 'Click OK to continue sending the Approval Request.';
        POImportOK: label 'Click OK to continue importing the PO lines.';
        ImportPO: Boolean;
        POApproval: Boolean;


    procedure InsertTempPOLine(SourcePOLine: Record "Purchase Line";SetAlertType: Option " ",Approval,Import)
    begin
        //InsertTempPOLine
        AlertType := SetAlertType;

        Clear(Rec);
        Rec := SourcePOLine;
        Insert;
    end;
}

