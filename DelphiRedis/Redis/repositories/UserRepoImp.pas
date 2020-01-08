unit UserRepoImp;
interface
uses UserR, RedisDictionary,System.SysUtils;

type
  TUserRepoImp = class
  private
   users : TRedisDictionary;
  public
   Constructor Create();
   procedure setUser(user: TUserR);
   function getUsers():string;
   function getUserById(id : string):string;
   function deleteUser(id : string): Boolean;
   function clearAll(): Boolean;
  end;

implementation
{ TUserRepoImp }

constructor TUserRepoImp.Create;
begin
   self.users := TRedisDictionary.Create('user');
end;

procedure TUserRepoImp.setUser(user: TUserR);
begin
   self.users.Add(inttostr(user.Id), user);
end;

function TUserRepoImp.getUsers(): string;
begin
   Result := self.users.FindAll();
end;

function TUserRepoImp.getUserById(id : string): string;
begin
   Result := self.users.FindById(id);
end;

function TUserRepoImp.deleteUser(id : string): Boolean;
begin
   Result := self.users.Remove(id);
end;

function TUserRepoImp.clearAll(): Boolean;
begin
   Result := self.users.clearAll();
end;


end.
