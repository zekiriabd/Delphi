unit User;

interface
uses
System.SysUtils,System.Generics.Collections,Data.DB, Data.Win.ADODB,
DatabaseAccess;

type
{$METHODINFO ON}
  TUser = class
  private

    Id: integer;
    LastName: string;
    FirstName: string;

    procedure SetFirstName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetLastName(const Value: string);

    { Private declarations }
  public
    { Public declarations }
    //Constructor Create; overload;
    Constructor Create(id : integer; firstName:string; lastName: string);
    Property mId: integer read Id write SetId;
    Property mFirstName : string read FirstName write SetFirstName;
    Property mLastName : string read LastName write SetLastName;

  end;
{$METHODINFO OFF}

  TUsers = class
  Public
      function GetUserList(): TList<TUser>;
      function GetUserListFromDb(): TList<TUser>;
      function AddNewUser (newUser : TUser): string ;
  end;

implementation

{ TUser }


Constructor TUser.Create(id : integer; firstName:string; lastName: string);
begin
    self.Id     := id;
    self.FirstName := firstName;
    self.LastName   := lastName;
end;

procedure TUser.SetFirstName(const Value: string);
begin
  FirstName := Value;
end;

procedure TUser.SetId(const Value: integer);
begin
  Id := Value;
end;

procedure TUser.SetLastName(const Value: string);
begin
  LastName := Value;
end;

{TUsers}

// GetUserList Web Method
function TUsers.GetUserList(): TList<TUser>;
begin
      Result:= TList<TUser>.Create;
      Result.Add(TUser.Create(1,'Zekiri','Abdelali'));
      Result.Add(TUser.Create(1,'Zekir25555i','Abdelali1211'));

end;

// GetUserList From Database Web Method
function TUsers.GetUserListFromDb(): TList<TUser>;
var
   userSqlProc : TADOStoredProc;
begin
      Result:= TList<TUser>.Create();
      userSqlProc := TDatabaseAccess.ExecProc('SP_UESR_SelectAll',nil);
      userSqlProc.Open;
      while not userSqlProc.EOF do
      begin
          Result.Add(
          TUser.Create(
                userSqlProc.FieldByName('USER_ID').AsInteger,
                userSqlProc.FieldByName('FIRST_NAME').AsString,
                userSqlProc.FieldByName('LAST_NAME').AsString
                )
          );

          userSqlProc.Next;
      end;
      userSqlProc.Close;


end;

 // Add New User
function TUsers.AddNewUser (newUser : TUser): string ;
var Params : TList<TProcParam>;
    Param : TProcParam;
    userSqlProc : TADOStoredProc;
begin
        Params:= TList<TProcParam>.Create();

        Param:=TProcParam.Create('FIRSTNAME', TDataType.ftString , newUser.mFirstName , 100);
        Params.Add(Param);

        Param:=TProcParam.Create('LASTNAME', TDataType.ftString , newUser.mLastName , 100);
        Params.Add(Param);

        userSqlProc := TDatabaseAccess.ExecProc('SP_USER_Save',Params);
        Result := userSqlProc.Name;
end;



end.

