unit BabyList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, Data.Bind.Components,
  Data.Bind.ObjectScope,
  System.Generics.Collections, Data.Bind.Grid, FMX.Grid.Style, FMX.Bind.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Objects;

type
  TFBabyList = class(TFrame)
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    ListView1: TListView;
  private
    { Déclarations privées }

  public
    procedure BindSourceAdapterReload();
    { Déclarations publiques }
  end;

implementation

uses uBaby;

{$R *.fmx}

procedure TFBabyList.BindSourceAdapterReload();
var
  listBaby: TList<TBaby>;
begin

  listBaby := TList<TBaby>.Create();
  listBaby.Add(TBaby.Create(1, 'zekiri', 'abdelali', 'baby1.jpg', true));
  listBaby.Add(TBaby.Create(1, 'Rouf', 'Rahich', 'baby2.jpg', true));
  listBaby.Add(TBaby.Create(1, 'Ali', 'Alowi', 'baby3.jpg', true));
  listBaby.Add(TBaby.Create(1, 'Meh', 'Mihoub', 'baby4.jpg', true));

  AdapterBindSource1.Active := False;
  AdapterBindSource1.Adapter := TListBindSourceAdapter<TBaby>.Create(self,
    listBaby, true);
  AdapterBindSource1.Active := true;

end;

end.
