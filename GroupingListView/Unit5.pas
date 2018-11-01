unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TForm5 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    ListView1: TListView;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.Button1Click(Sender: TObject);
 var
  Group,Item: Integer;
  Buffer: String;
  ListBoxItem : TListBoxItem;
  ListBoxGroupHeader : TListBoxGroupHeader;
begin
  ListBox1.BeginUpdate;
  for Group in [1..3] do
  begin
    ListBoxGroupHeader := TListBoxGroupHeader.Create(ListBox1);
    ListBoxGroupHeader.Text := UpperCase(Format('Header %d', [Group]));
    ListBox1.AddObject(ListBoxGroupHeader);
    for Item in [1..3] do
    begin
      ListBoxItem := TListBoxItem.Create(ListBox1);
      ListBoxItem.Height:=50;
      ListBoxItem.Text := Format('Regular item %d.%d', [Group, Item]);
      // (aNone=0, aMore=1, aDetail=2, aCheckmark=3)
      ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory(1);
      ListBox1.AddObject(ListBoxItem);
    end;
  end;
  ListBox1.EndUpdate;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  header, item: Integer;
begin
  for header in [1..3] do
  begin
    with ListView1.Items.Add do
    begin
      Text :=  header.tostring();
      Purpose := TListItemPurpose.Header;
    end;
     for Item in [1..3] do
     ListView1.Items.Add.Text := Item.ToString();
  end;
end;

end.
