unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ExtCtrls, FMX.Controls.Presentation, FMX.Objects, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, FMX.Layouts;

type
  TForm5 = class(TForm)
    CheckBox1: TCheckBox;
    Image1: TImage;
    Image2: TImage;
    BindingsList1: TBindingsList;
    LinkControlToPropertyVisible: TLinkControlToProperty;
    CheckBox2: TCheckBox;
    Image3: TImage;
    Image4: TImage;
    Layout1: TLayout;
    Circle1: TCircle;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    procedure CheckBox2Click(Sender: TObject);
    procedure Layout1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.CheckBox2Click(Sender: TObject);
begin
   image4.Visible := CheckBox2.IsChecked;
end;

procedure TForm5.Layout1Click(Sender: TObject);
begin
    Label2.Visible := not Label2.Visible;
end;

end.
