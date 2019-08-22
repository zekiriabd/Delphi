unit DatabaseAccess;

interface
uses
Data.DB, Data.Win.ADODB,
System.SysUtils,System.Generics.Collections;

type
{$METHODINFO ON}


 TProcParam = class
  private
    FName: string;
    FDataType: TDataType;
    FValue: string;
    FSize : Integer;
    procedure SetDataType(const Value: TDataType);
    procedure SetName(const Value: string);
    procedure SetValue(const Value: string);
    procedure SetSize(const Value: Integer);

 public
    Constructor Create; overload;
    Constructor Create(name : string; dataType:TDataType; value: string; size : Integer); overload;

    Property Name: string read FName write SetName;
    Property DataType: TDataType read FDataType write SetDataType;
    Property Value: string read FValue write SetValue;
    Property Size: Integer read FSize write SetSize;

  end;

  TDatabaseAccess = class
    class function ExecProc(name : string;_parameters:TList<TProcParam>) : TADOStoredProc;static;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  {$METHODINFO OFF}
implementation

{ TDatabaseAccess.ExecProc is static function}
class function TDatabaseAccess.ExecProc(name : string;_parameters:TList<TProcParam>): TADOStoredProc;
var SqlProc : TADOStoredProc;
    i:integer;
begin
    SqlProc := TADOStoredProc.Create(nil);
    try
    begin
      SqlProc.ConnectionString :=
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;' +
      'Initial Catalog=USER_Managment;'+
      'Data Source=DESKTOP-MAGJ7HQ\SQLEXPRESS';

      SqlProc.ProcedureName := name;
      if(_parameters <> nil) then
      begin
        for i:= 0 to _parameters.Count-1 do
              SqlProc.Parameters.CreateParameter(
              _parameters[i].Name,
              _parameters[i].DataType,pdInput,
              _parameters[i].Size,_parameters[i].Value
              );
          SqlProc.Prepared:= true;
          SqlProc.ExecProc;
      end;
      SqlProc.name:='OK';
    end;
    Except On e: Exception do
        SqlProc.Close;
    end;
    Result := SqlProc;
end;



{ TParam constructor and accessor }
constructor TProcParam.Create();
begin
end;

constructor TProcParam.Create(name : string; dataType:TDataType; value: string; size : Integer);
begin
    self.Name     := name;
    self.DataType := dataType;
    self.Value    := value;
    self.Size     := size;
end;

procedure TProcParam.SetDataType(const Value: TDataType);
begin
  FDataType := Value;
end;

procedure TProcParam.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TProcParam.SetValue(const Value: string);
begin
  FValue := Value;
end;

procedure TProcParam.SetSize(const Value: Integer);
begin
  FSize := Value;
end;

end.

