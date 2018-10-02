unit DatabaseAccess;

interface

uses
  System.SysUtils,
  System.Classes,
  System.iOUtils,
  System.Generics.Collections,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,

  Data.DB,

  UBaby

  ;

type
  TDataModule1 = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    { Private declarations }
    function  SqlitConnection(): TFDConnection;
  public
    { Public declarations }
    function   GetUserList(): TList<TBaby>;
    procedure  DeleteUser(userId:Integer);
    procedure  AddUser(user:TBaby);
  end;

var
  DataModule1: TDataModule1;



implementation
{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
procedure TDataModule1.AddUser(user:TBaby);
var
 FDQuery1 : TFDQuery;
begin
TRY
    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection:= SqlitConnection();
    FDQuery1.SQL.Text:='INSERT INTO USER (FirstName, LastName) VALUES (:FirstName,:LastName)';
    FDQuery1.ParamByName('FirstName').AsString:=user.FirstName;
    FDQuery1.ParamByName('LastName').AsString :=user.LastName;
    FDQuery1.ExecSQL;
FINALLY
     FDQuery1.Connection.Close;
     FDQuery1.Connection.Free;
     FDQuery1.Close;
     FDQuery1.Free;
END;
end;

procedure  TDataModule1.DeleteUser(userId:Integer);
var
 FDQuery1 : TFDQuery;
begin
TRY
    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection:= SqlitConnection();
    FDQuery1.SQL.Text:=Format('DELETE FROM USER WHERE Id=%d',[userId]);
    FDQuery1.ExecSQL;
FINALLY
     FDQuery1.Connection.Close;
     FDQuery1.Connection.Free;
     FDQuery1.Close;
     FDQuery1.Free;
END;
end;

function TDataModule1.SqlitConnection(): TFDConnection;
var
  dbPath:string;
const
  DBFILE = 'NanyTracker.db';
begin
    {$IFDEF MSWINDOWS}
        dbPath := TPath.Combine(ExpandFileName(GetCurrentDir), DBFILE);
    {$ELSE}
        dbPath := TPath.GetDocumentsPath + PathDelim + DBFILE;
    {$ENDIF}
    Result := TFDConnection.Create(self);
    Result.Params.Add('Database='+  dbPath);
    Result.DriverName:='SQLite';
    Result.LoginPrompt := False;
    Result.Open();
end;

function TDataModule1.GetUserList(): TList<TBaby>;
var
  mUser : TBaby;
  FDQuery1 : TFDQuery;
begin

TRY
    Result:= TList<TBaby>.Create();

    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection:= SqlitConnection();
    FDQuery1.SQL.Text:='SELECT * FROM Baby';
    FDQuery1.Open;

     while not FDQuery1.EOF do
      begin
          Result.Add(
          TBaby.Create(
                FDQuery1.FieldByName('Id').AsInteger,
                FDQuery1.FieldByName('FirstName').AsString,
                FDQuery1.FieldByName('LastName').AsString,
                FDQuery1.FieldByName('ProfileImage').AsString,
                FDQuery1.FieldByName('IsPresent').AsBoolean
                )
          );
          FDQuery1.Next;
      end;

FINALLY
     FDQuery1.Connection.Close;
     FDQuery1.Connection.Free;
     FDQuery1.Close;
     FDQuery1.Free;
END;

end;




end.
