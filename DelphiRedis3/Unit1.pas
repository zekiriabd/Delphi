unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
uses UserRepoImp,UserR;
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var userRepoImp : TUserRepoImp;
var userR : TUserR;
begin
   userRepoImp := TUserRepoImp.Create();
   userR := TUserR.Create;
   userR.Id:=1;
   userR.Name:='zekiri abdelali';
   userRepoImp.setUser(userR);
end;

end.
