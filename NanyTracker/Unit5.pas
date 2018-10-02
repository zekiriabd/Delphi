unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Grid.Style,
  Fmx.Bind.Grid, Data.Bind.Grid, FMX.ScrollBox, FMX.Grid, FMX.Edit, FMX.Layouts,
  System.Generics.Collections,
  UBaby, Data.Bind.ObjectScope;

type
  TForm5 = class(TForm)

    procedure Button2Click(Sender: TObject);
    procedure  BindSourceAdapterReload();
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }

  _list: Tlist<TBaby>;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;


implementation
uses DatabaseAccess;
{$R *.fmx}

procedure  TForm5.BindSourceAdapterReload();
begin
  _list := DataModule1.GetUserList();
  AdapterBindSource1.Active:= False;
  AdapterBindSource1.Adapter:=  TListBindSourceAdapter<TBaby>.Create(self,_list,True);
  AdapterBindSource1.Active:= True;
end;

procedure TForm5.Button1Click(Sender: TObject);
var
   user : TBaby;
   image:string;
begin
   //image := 'test.png';
   //user := TBaby.Create(
            //    0,
           //     txFName.Text,
            //    txLName.Text,
           //     image,
             //   true
             //   );
//
   // DataModule1.AddUser(user);
   // BindSourceAdapterReload();
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  userId : Integer;
begin
  // userId := StrToInt(Edit1.Text);
  // DataModule1.DeleteUser(userId);
  // BindSourceAdapterReload();
end;

procedure TForm5.Button3Click(Sender: TObject);
var
  userId : Integer;
  user : TBaby;
begin
  // userId := StrToInt(Edit1.Text);
  // AdapterBindSource1.Locate('Id',userId);

   //for user in _list do if (user.id = userId) then  Break;
   //fmx.Dialogs.ShowMessage(user.FirstName);

end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  // AdapterBindSource1.Insert;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
   // BindSourceAdapterReload();
end;

end.




