unit Unit9;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  ConnectionModule,
  Aurelius.Drivers.Interfaces,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Engine.ObjectManager,
  UserDB,
  FMX.Controls.Presentation, FMX.StdCtrls
  ;

type
  TForm9 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
      FConnection : IDBConnection;
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.fmx}

procedure TForm9.Button1Click(Sender: TObject);
var
  Manager : TObjectManager;
  user : TUserDB;
begin
   Manager := TObjectManager.Create(FConnection);
   try
      user := TUserDB.Create;
      user.FirstName:= 'coucou';
      user.LastName := 'ffff';
      Manager.Save(user);
   finally
     Manager.Free;
   end;

end;

procedure TForm9.FormCreate(Sender: TObject);
begin
   FConnection := TMSSQLConnection.CreateConnection;
   TDatabaseManager.Update(FConnection);
end;

end.
