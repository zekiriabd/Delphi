unit MainPage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  RTL.Controls, LyoutHeader, FMX.TabControl, BabyList, BabyEdit;

type
  TFMainPage = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    FlyoutMenu: TRectangle;
    FMenuScrollBox: TVertScrollBox;
    BtnNewBaby: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    Lang1: TLang;
    RTLFixer1: TRTLFixer;
    MainHeader: TRectangle;
    FlyoutHeader: TFlyoutHeader;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    FBabyList1: TFBabyList;
    FBabyEdit1: TFBabyEdit;
    BtnBabiesList: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Label3: TLabel;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure BtnBabiesListClick(Sender: TObject);
    procedure BtnNewBabyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMainPage: TFMainPage;


implementation
{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure TFMainPage.BtnBabiesListClick(Sender: TObject);
begin
  TabControl1.ActiveTab:=TabControl1.Tabs[0];
  Multiview1.HideMaster;
end;

procedure TFMainPage.BtnNewBabyClick(Sender: TObject);
begin
  TabControl1.ActiveTab:=TabControl1.Tabs[1];
  Multiview1.HideMaster;
end;

procedure TFMainPage.FormCreate(Sender: TObject);
begin
    FlyoutHeader.Loead();
    FBabyList1.BindSourceAdapterReload();
end;

end.
