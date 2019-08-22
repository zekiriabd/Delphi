unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Vcl.ComCtrls, Data.Bind.ObjectScope,System.Generics.Collections,
  Vcl.Bind.Grid, Data.Bind.Grid, Vcl.Grids, Data.Bind.Controls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Bind.Navigator, Vcl.StdCtrls,User;

type
  TForm9 = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    StringGridPrototypeBindSource1: TStringGrid;
    LinkGridToDataSourcePrototypeBindSource1: TLinkGridToDataSource;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
      var myusers : TUsers;
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation
{$R *.dfm}

procedure TForm9.FormCreate(Sender: TObject);
begin
   myusers := TUsers.Create();
end;

procedure TForm9.Button1Click(Sender: TObject);
var myuser  : TUser;
begin
     try
      myuser := TUser.Create(0,edit1.Text,edit2.Text);
      myusers.AddNewUser(myuser);
      PrototypeBindSource1.Refresh;
     finally
       FreeAndNil(myuser);
     end;
end;

procedure TForm9.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
      ABindSourceAdapter := TListBindSourceAdapter<TUser>.Create(Self,myusers.GetUserListFromDb(),true);
      ABindSourceAdapter.Active:= true;
end;

end.
