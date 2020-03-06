unit Flyway;

interface
uses System.SysUtils,System.Classes,
Vcl.Dialogs,Unit1;
type
  TFlyway = class
  private
       procedure ListFileDir(Path: string);
       procedure TextToTStrings(const filePath : String; fileName : String);
  public
       Constructor  Create; overload;
  end;

implementation
constructor TFlyway.Create;
begin
   ListFileDir(GetCurrentDir + '\db\migration\');

   // initialisation
   {
    CREATE TABLE `usersmanagement`.`dflyway_schema` (
  `File` VARCHAR(50) NOT NULL,
  `date` DATE NULL,
  PRIMARY KEY (`File`));
  }
end;

procedure TFlyway.TextToTStrings(const filePath : String; fileName : String);
var
  Str: TStringList;
begin
  Str:= TStringList.Create;
  try
    Str.LoadFromFile(filePath + fileName);
    ShowMessage(Str.Text);
    DataModule1.FDQuery1.SQL.Text:=
    'INSERT INTO `usersmanagement`.`dflyway_schema` (`File`) VALUES ('''+ fileName +''');';
    DataModule1.FDQuery1.ExecSQL;

    DataModule1.FDQuery1.SQL.Text:= Str.Text;
    DataModule1.FDQuery1.ExecSQL;

  finally
    Str.Free;
  end;
end;



procedure TFlyway.ListFileDir(Path: string);
var
  SR: TSearchRec;
begin
  DataModule1.FDConnection1.Connected:= true;
  DataModule1.FDTable1.Active:=true;

  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        if not (DataModule1.FDTable1.FindKey([SR.Name])) then
        begin
           ShowMessage(SR.Name + 'not exist');
           TextToTStrings(Path,SR.Name);
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;



end.



