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
  end;

implementation
{ TUserRepoImp }

constructor TUserRepoImp.Create;
begin
   self.users := TRedisDictionary.Create('user');
end;

procedure TUserRepoImp.setUser(user: TUserR);
begin
   self.users.Add(TObject(user.Id), user);
end;

end.
