unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
//local
UserRepoImp,UserR,
//Redis
REST.JSON,Redis.Commons,Redis.Client,Redis.NetLib.INDY,Redis.Values;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     userRepoImp : TUserRepoImp;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
implementation
{$R *.dfm}


procedure TForm3.Button1Click(Sender: TObject);
var userR :TUserR;
begin
   userR := TUserR.Create;
try
   userR.Id:=strtoint(Edit1.Text);
   userR.Name:=edit2.Text;
   self.userRepoImp.setUser(userR);
finally
     FreeAndNil(userR);
end;

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  memo1.text := self.userRepoImp.getUserById(edit3.Text);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
 memo1.text := self.userRepoImp.deleteUser(Edit3.Text).ToString();
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
   self.userRepoImp.getUsers();
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  userRepoImp.ClearUserTable();
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
   self.userRepoImp := TUserRepoImp.Create();
end;

end.
