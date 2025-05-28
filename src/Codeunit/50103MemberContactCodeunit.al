codeunit 50103 CreateMemberFromPOS
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Member Contact Popup", OnBeforeContactCreateParametersInsert, '', false, false)]
    local procedure "LSC POS Member Contact Popup_OnBeforeContactCreateParametersInsert"(var MemberContact_p: Record "LSC Member Contact"; var ContactCreateParametersTemp: Record "LSC Contact Create Parameters")
    begin
        ContactCreateParametersTemp.Remark := MemberContact_p.Remark;

    end;


}
