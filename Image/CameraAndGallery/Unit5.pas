unit Unit5;

interface

uses
 {$IFDEF MSWINDOWS}
    ShellAPI,
 {$ENDIF}

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Menus, FMX.Edit,
  FMX.Effects,system.iOUtils  ;

type
  TForm5 = class(TForm)
    ActionList1: TActionList;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ShowShareSheetAction1: TShowShareSheetAction;
    Button1: TButton;
    Button3: TButton;
    Circle1: TCircle;
    Circle2: TCircle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Label2: TLabel;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure Circle2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.Button2Click(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
     ShellExecute(0, 'OPEN', PChar('microsoft.windows.camera:'), '', '', 1);
     OpenDialog1.InitialDir:= TPath.GetPicturesPath;
     if (OpenDialog1.Execute) then
     Circle1.Fill.Bitmap.Bitmap.LoadFromFile(OpenDialog1.FileName);
  {$ELSE}
     TakePhotoFromCameraAction1.Execute;
  {$ENDIF}
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
     OpenDialog1.InitialDir:= TPath.GetPicturesPath;
     if (OpenDialog1.Execute) then
     Circle1.Fill.Bitmap.Bitmap.LoadFromFile(OpenDialog1.FileName);
  {$ELSE}
     TakePhotoFromLibraryAction1.Execute;
  {$ENDIF}
end;

procedure TForm5.Circle2Click(Sender: TObject);
begin
     Rectangle1.Visible:=True;
     Rectangle2.Visible:=True;
end;

procedure TForm5.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
    ShowShareSheetAction1.Bitmap.Assign(Circle1.Fill.Bitmap.Bitmap);
end;

procedure TForm5.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
    Circle1.Fill.Bitmap.Bitmap.Assign(image);
    Rectangle1.Visible:=False;
    Rectangle2.Visible:=False;
end;

procedure TForm5.TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
begin
    Circle1.Fill.Bitmap.Bitmap.Assign(image);
    Rectangle1.Visible:=False;
    Rectangle2.Visible:=False;
end;

end.
