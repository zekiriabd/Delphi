unit IUserRepo;

interface
uses UserR;

type
 UserRepo = interface
    ['{EB79B33B-F009-4E67-B6F1-23D8396407DA}']
   procedure SetUser(user: TUserR);
   function GetUsers():string;
   function GetUserById(id : string):string;
   function DeleteUser(id : string): Boolean;
   function ClearUserTable(): Boolean;
 end;



implementation
end.
