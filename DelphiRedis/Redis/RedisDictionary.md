# DELPHI 

#### RedisDictionary

demo

```html
unit UserRepoImp;
interface
uses UserR, RedisDictionary,System.SysUtils;

type
  TUserRepoImp = class
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

constructor TUserRepoImp.Create;
begin
   self.users := TRedisDictionary.Create('user');
end;

procedure TUserRepoImp.SetUser(user: TUserR);
begin
   self.users.Add(inttostr(user.Id), user);
end;

function TUserRepoImp.GetUsers(): string;
begin
   Result := self.users.FindAll();
end;

function TUserRepoImp.GetUserById(id : string): string;
begin
   Result := self.users.FindById(id);
end;

function TUserRepoImp.DeleteUser(id : string): Boolean;
begin
   Result := self.users.Remove(id);
end;

function TUserRepoImp.ClearUserTable(): Boolean;
begin
   Result := self.users.DeleteAll();
end;


end.
```

<p align="center">
   <img src="https://i.imgur.com/0MgIiQf.png" alt="badges" style="margin:auto">
</p>


<p>
 https://www.youtube.com/watch?v=g-vq1Q5R2x8&list=PLfVdvKscEioOukQCwezjjsVevZqPlqVPn&index=31
</p>
