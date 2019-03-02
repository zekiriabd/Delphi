unit BabyList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, Data.Bind.Components,
  Data.Bind.ObjectScope,
  System.Generics.Collections, Data.Bind.Grid, FMX.Grid.Style, Fmx.Bind.Grid,
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
procedure  TFBabyList.BindSourceAdapterReload();
var listBaby : TList<TBaby>;
var baby : TBaby;
begin
  listBaby := TList<TBaby>.Create();
  baby := TBaby.Create(1,'zekiri','abdelali','baby1.jpg',true);
  listBaby.Add(baby);

  AdapterBindSource1.Active:=   False;
  AdapterBindSource1.Adapter:=  TListBindSourceAdapter<TBaby>.Create(self,listBaby,True);
  AdapterBindSource1.Active := True;
end;
end.
