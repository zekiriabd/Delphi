unit MainPage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  RTL.Controls, LyoutHeader;

type
  TFMainPage = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    FlyoutMenu: TRectangle;
    FMenuScrollBox: TVertScrollBox;
    Rectangle1: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    Lang1: TLang;
    RTLFixer1: TRTLFixer;
    MainHeader: TRectangle;
    FlyoutHeader: TFlyoutHeader;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMainPage: TFMainPage;


implementation
{$R *.fmx}

procedure TFMainPage.FormCreate(Sender: TObject);
begin
    FlyoutHeader.Loead();
end;

end.
