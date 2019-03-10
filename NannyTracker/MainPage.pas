unit MainPage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  RTL.Controls, LyoutHeader, FMX.TabControl, BabyList, BabyEdit, FMX.ListBox,
  FMX.Ani, FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns;

type
  TFMainPage = class(TForm)
    MultiView1: TMultiView;
    MainLayout: TLayout;
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
    BtnBabiesList: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Label3: TLabel;
    StyleBook1: TStyleBook;
    recBakground: TRectangle;
    mActionSheet: TRectangle;
    animActionSheet: TFloatAnimation;
    Label4: TLabel;
    ListBox1: TListBox;
    btnTakePhoto: TListBoxItem;
    btnTakeFromLibrary: TListBoxItem;
    btnActionSheetClose: TListBoxItem;
    ActionList1: TActionList;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    FBabyEdit1: TFBabyEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtnBabiesListClick(Sender: TObject);
    procedure BtnNewBabyClick(Sender: TObject);
    procedure FBabyEdit1btnActionSheetClick(Sender: TObject);
    procedure animActionSheetFinish(Sender: TObject);
    procedure btnActionSheetCloseClick(Sender: TObject);
    procedure btnTakePhotoClick(Sender: TObject);
    procedure btnTakeFromLibraryClick(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);


  private
    { Private declarations }
        procedure ActionSheetClose();

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

procedure TFMainPage.animActionSheetFinish(Sender: TObject);
begin
   animActionSheet.Enabled:= false;
end;



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

procedure TFMainPage.btnActionSheetCloseClick(Sender: TObject);
begin
   ActionSheetClose();
end;

procedure TFMainPage.ActionSheetClose();
begin
    recBakground.Visible:=false;
    recBakground.Height := FMainPage.Height;
end;

procedure TFMainPage.FBabyEdit1btnActionSheetClick(Sender: TObject);
begin
recBakground.Width := MainLayout.Width;
recBakground.Height := MainLayout.Height;
recBakground.Position.Y:=0;
recBakground.Visible:=true;
animActionSheet.StartValue := FMainPage.Height;
animActionSheet.StopValue  := MainLayout.Height - mActionSheet.Height;
animActionSheet.Enabled:=true;
end;

procedure TFMainPage.FormCreate(Sender: TObject);
begin
    FlyoutHeader.Loead();
    FBabyList1.BindSourceAdapterReload();
end;

procedure TFMainPage.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
    //FBabyEdit1.btnActionSheet.Fill.Bitmap.Bitmap.Assign(Image);
    //ActionSheetClose();
end;

procedure TFMainPage.TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
begin
   // FBabyEdit1.btnActionSheet.Fill.Bitmap.Bitmap.Assign(Image);
    //ActionSheetClose();
end;

procedure TFMainPage.btnTakeFromLibraryClick(Sender: TObject);
begin
  // TakePhotoFromLibraryAction1.Execute;
end;

procedure TFMainPage.btnTakePhotoClick(Sender: TObject);
begin
  // TakePhotoFromCameraAction1.Execute;
end;

end.





