unit BabyList;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  System.iOUtils,
  System.Generics.Collections,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  System.Bindings.Outputs,
  Fmx.Bind.Editors,
  Data.Bind.EngExt,
  Fmx.Bind.DBEngExt,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  IdHTTP,
  FMX.Objects, System.Rtti;

type
  TForm1 = class(TForm)
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure BindSourceAdapterReload();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses DatabaseAccess,UBaby;
{$R *.fmx}

procedure  TForm1.BindSourceAdapterReload();
var _list : TList<TBaby>;
begin
_list := DataModule1.GetUserList();
AdapterBindSource1.Active:=   False;
AdapterBindSource1.Adapter:=  TListBindSourceAdapter<TBaby>.Create(self,_list,True);
AdapterBindSource1.Active:=   True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   BindSourceAdapterReload();
end;

end.
