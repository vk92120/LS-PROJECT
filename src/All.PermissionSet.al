permissionset 50111 "All"
{
    Access = Internal;
    Assignable = true;
    Caption = 'All permissions', Locked = true;

    Permissions =
         codeunit CreateMemberFromPOS = X,
         codeunit PosPrintReceipt = X,
         page StudentList = X,
         page StudentList2 = X,
         page StudentListAPI = X,
         table Student = X,
         tabledata Student = RIMD;
}