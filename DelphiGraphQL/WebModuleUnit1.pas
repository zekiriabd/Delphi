unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, GraphQL.Schema,
  GraphQL.Comp.Schema, GraphQL.WebBroker,System.Rtti, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,GraphQL.Types,
  REST.JSON, System.Generics.Collections;

type
    TUser = class
      private
        UserId: Integer;
        FirstName: string;
        LastName: string;
        Age: Integer;
      public
        constructor Create(_userId: Integer; _firstName: string; _lastName:string; _age:Integer);
   end;

   TUsers = TList<TUser>;

   TQuery = class
     function Users(id:Integer):TArray<TUser>;
    end;

   TMutation = class
      public
        function AddUser(Input: IGraphQLMap): Integer;
        function UpdateUser(Input: IGraphQLMap): Boolean;
        function deleteUser(id:Integer): Boolean;
      end;



  TWebModule1 = class(TWebModule)
    GraphQLWebBrokerDispatcher1: TGraphQLWebBrokerDispatcher;
    GraphQLSchema1: TGraphQLSchema;
    procedure GraphQLSchema1InitSchema(Sender: TObject;
      Schema: TSchemaDocument);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;


var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TUser.Create(_userId: Integer; _firstName: string; _lastName:string; _age:Integer);
begin
      inherited Create;
      UserId := _userId;
      FirstName := _firstName;
      LastName := _lastName;
      Age:=_age;
end;



function TQuery.Users(id:Integer): TArray<TUser>;
begin
    var Conn:= TFDConnection.Create(nil);
    conn.Params.AddStrings(['Server=LAPTOP-61VJQ0J4','Database=test','DriverID=MSSQL','OSAuthent=Yes']);
    var userQuery := TFDQuery.Create(nil);
    var users  := TList<TUser>.Create;
  try
    conn.Open;
    userQuery.Connection:= conn;
    if id> 0  then
      userQuery.SQL.Text := 'SELECT (SELECT [UserId],[FirstName],[LastName],[Age] FROM [User] WHERE UserId = '+ id.ToString +' FOR JSON AUTO) AS Users'
    else
      userQuery.SQL.Text := 'SELECT (SELECT [UserId],[FirstName],[LastName],[Age] FROM [User] FOR JSON AUTO) AS Users';
    userQuery.Open;
    var json := '{"listHelper":' + userQuery.FieldByName('Users').AsString +'}';
    users :=TJson.JsonToObject<TList<TUser>>(json);
  finally
    userQuery.Close;
    conn.Close;
    userQuery.free;
    conn.Free;
  end;
  Result:= users.ToArray;
end;

 function TMutation.deleteUser(id:Integer): Boolean;
begin
var Conn:= TFDConnection.Create(nil);
    conn.Params.AddStrings(['Server=LAPTOP-61VJQ0J4','Database=test','DriverID=MSSQL','OSAuthent=Yes']);
    var UserProc := TFDStoredProc.Create(nil);
  try
    conn.Open;
    UserProc.Connection:= conn;
    UserProc.StoredProcName:='DeleteUserById';
    UserProc.Prepare;
    UserProc.Params.ParamByName('@UserId').Value := id;
    UserProc.ExecProc;
  finally
    UserProc.Close;
    conn.Close;
    UserProc.free;
    conn.Free;
  end;
    Result:= true;
end;

function TMutation.UpdateUser(Input: IGraphQLMap): Boolean;
begin
var Conn:= TFDConnection.Create(nil);
    conn.Params.AddStrings(['Server=LAPTOP-61VJQ0J4','Database=test','DriverID=MSSQL','OSAuthent=Yes']);
    var UserProc := TFDStoredProc.Create(nil);
  try
    conn.Open;
    UserProc.Connection:= conn;
    UserProc.StoredProcName:='UpdateUserById';
    UserProc.Prepare;
    UserProc.Params.ParamByName('@UserId').Value := Input['userid'].AsInteger;
    UserProc.Params.ParamByName('@FirstName').Value := Input['firstname'].AsString;
    UserProc.Params.ParamByName('@LastName').Value := Input['lastname'].AsString;
    UserProc.Params.ParamByName('@Age').Value := Input['age'].AsInteger;
    UserProc.ExecProc;
  finally
    UserProc.Close;
    conn.Close;
    UserProc.free;
    conn.Free;
  end;
  Result:= true;
end;

function TMutation.AddUser(Input: IGraphQLMap): Integer;

begin
var Conn:= TFDConnection.Create(nil);
    conn.Params.AddStrings(['Server=LAPTOP-61VJQ0J4','Database=test','DriverID=MSSQL','OSAuthent=Yes']);
    var UserProc := TFDStoredProc.Create(nil);
  try
    conn.Open;
    UserProc.Connection:= conn;
    UserProc.StoredProcName:='AddUser';
    UserProc.Prepare;
    UserProc.Params.ParamByName('@FirstName').Value := Input['firstname'].AsString;
    UserProc.Params.ParamByName('@LastName').Value := Input['lastname'].AsString;
    UserProc.Params.ParamByName('@Age').Value := Input['age'].AsInteger;
    UserProc.ExecProc;
  finally
    UserProc.Close;
    conn.Close;
    UserProc.free;
    conn.Free;
  end;
  Result:= 1;
end;

procedure TWebModule1.GraphQLSchema1InitSchema(Sender: TObject; Schema: TSchemaDocument);
begin
   Schema.Bind('Query', TQuery);
   Schema.Bind('Mutation', TMutation);

end;

end.
