unit UserDataAccess;

interface
uses
  Data.DB,

  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys.Intf,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FireDAC.Phys,

  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.DatS,
  FireDAC.UI.Intf,

  System.Generics.Collections,
  System.SysUtils,
  Client;

type
TUserDataAccess = class
    class function GetUsers(): TList<TClient>;static;
    class procedure Insert(user:TClient);static;
    class function GetUserById(id:Integer):TClient;static;
end;

implementation

function GetCoonection():TFDConnection;
begin
    Result := TFDConnection.Create(nil);
    Result.Params.DriverID := 'MySQL';
    Result.Params.Add('Server=127.0.0.1');
    Result.Params.Database := 'usersmanagement';
    Result.Params.UserName := 'root';
    Result.Params.Password := '';
    Result.LoginPrompt := False;
end;

class function TUserDataAccess.GetUsers(): TList<TClient>;
var
  userQuery : TFDQuery;
  conn : TFDConnection;
  users : TList<TClient>;
  I: Integer;
begin
  conn:= GetCoonection();
  userQuery := TFDQuery.Create(nil);
  try
    conn.Connected := True;
    userQuery.Connection:= conn;
    userQuery.SQL.Text := 'SELECT * FROM user';
    userQuery.Active:= true;
    users:= TList<TClient>.Create();

    for I := 1 to userQuery.RecordCount do
    begin
        users.Add(TClient.Create(
        userQuery.FieldByName('Id').Value,
        userQuery.FieldByName('FirstName').AsString,
        userQuery.FieldByName('LastName').AsString
      ));
      userQuery.Next;
    end;
    Result:=  users;
  finally
    conn.Connected := False;
    userQuery.Free;
    conn.Free;
  end;

end;

class procedure TUserDataAccess.Insert(user:TClient);
var
  userQuery : TFDQuery;
  conn : TFDConnection;
begin
  conn:= GetCoonection();
  userQuery := TFDQuery.Create(nil);
  try
    conn.Connected := True;
    userQuery.Connection:= conn;
    userQuery.SQL.Text := format('INSERT INTO user (Id, FirstName, LastName) values(%d, "%s", "%s")',[user.Id,user.FirstName,user.LastName]);
    userQuery.ExecSQL;
  finally
    conn.Connected := False;
    userQuery.Free;
    conn.Free;
  end;

end;

class function TUserDataAccess.GetUserById(id:Integer):TClient;
var
  userQuery : TFDQuery;
  conn : TFDConnection;
  user : TClient;
begin
  conn:= GetCoonection();
  userQuery := TFDQuery.Create(nil);
  try
    conn.Connected := True;
    userQuery.Connection:= conn;
    userQuery.SQL.Text := format('SELECT * FROM user WHERE id = %d',[id]);
    userQuery.Active:= true;
    user:= TClient.Create();
    if(userQuery.RecordCount>0)then
    begin
      user.Id:= userQuery.FieldByName('Id').Value;
      user.FirstName:= userQuery.FieldByName('FirstName').AsString;
      user.LastName:= userQuery.FieldByName('LastName').AsString;
    end;
    Result:=  user;
  finally
    conn.Connected := False;
    userQuery.Free;
    conn.Free;
  end;

end;



end.


