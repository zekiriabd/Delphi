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
  FMX.Objects, System.Rtti, FMX.Grid.Style, Fmx.Bind.Grid, Data.Bind.Grid,
  FMX.Grid, FMX.StdCtrls, System.Actions, FMX.ActnList, FMX.Gestures, FMX.Menus;

type
  TForm1 = class(TForm)
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    LinkFillControlToField1: TLinkFillControlToField;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
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

procedure TForm1.Action1Execute(Sender: TObject);
var
  I: Integer;
  item:TAppearanceListViewItem;
begin
  if (ListView1.ItemIndex >= 0) then
  begin
    item := ListView1.Items[ListView1.ItemIndex];
    item.Objects.FindObject('TextButton5').Visible:= true;
  end;
end;

procedure TForm1.Action2Execute(Sender: TObject);
var
  I: Integer;
  item:TAppearanceListViewItem;
begin
  if (ListView1.ItemIndex >= 0) then
  begin
    item := ListView1.Items[ListView1.ItemIndex];
    item.Objects.FindObject('TextButton5').Visible:= false;
  end;
end;


procedure TForm1.ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
     if (ItemObject <> nil) and (ItemObject.Name.Equals('TextButton5')) then
     begin
        ShowMessage('TextButton5 is clicked');
     end;
end;



procedure  TForm1.BindSourceAdapterReload();
var _list : TList<TBaby>;
begin
  _list := DataModule1.GetUserList();
  AdapterBindSource1.Active:=   False;
  AdapterBindSource1.Adapter:=  TListBindSourceAdapter<TBaby>.Create(self,_list,True);
  AdapterBindSource1.Active := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   BindSourceAdapterReload();
end;


end.
