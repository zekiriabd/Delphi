unit UserRepoImp;
interface
uses UserR, RedisDictionary,System.SysUtils,IUserRepo;

type
  TUserRepoImp = class(TInterfacedObject,UserRepo)
  private
     users : TRedisDictionary;
  public
   Constructor Create();
   procedure SetUser(user: TUserR);
   function GetUsers():string;
   function GetUserById(id : string):string;
   function DeleteUser(id : string): Boolean;
   function ClearUserTable(): Boolean;

  end;

implementation
{ TUserRepoImp }
procedure TUserRepoImp.SetUser(user: TUserR);
begin
   self.users.Add(inttostr(user.Id), user);
end;

function TUserRepoImp.GetUsers(): string;
begin
   Result := self.users.FindAll();
end;

function TUserRepoImp.DeleteUser(id : string): Boolean;
begin
   Result := self.users.Remove(id);
end;

function TUserRepoImp.ClearUserTable(): Boolean;
begin
   Result := self.users.DeleteAll();
end;
constructor TUserRepoImp.Create;
begin
   self.users := TRedisDictionary.Create('user');
end;

function TUserRepoImp.GetUserById(id: string): string;
begin
   Result := self.users.FindById(id);
end;


end.
