unit UBaby;

interface
uses
System.SysUtils,System.Generics.Collections,FMX.Graphics,FMX.Objects,System.iOUtils

, FMX.Dialogs
;

type
{$METHODINFO ON}
  TBaby = class
  private

    _Id: integer;
    _FirstName: string;
    _LastName: string;
    _ProfileImage :string;
    _IsPresent:Boolean;
    procedure SetFirstName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetLastName(const Value: string);
    procedure SetProfileImage(const Value: string);
    procedure SetIsPresent(const Value: Boolean);
    function GetProfileBitmap():TBitmap;
    { Private declarations }
  public
    { Public declarations }
    ProfileBitmap :TBitmap;
   //Constructor Create; overload;
    Constructor Create(id : integer; firstName:string; lastName: string; profileImage:string;isPresent:Boolean);
    Property Id: integer read _Id write SetId;
    Property FirstName : string read _FirstName write SetFirstName;
    Property LastName : string read _LastName write SetLastName;
    Property ProfileImage : string read _ProfileImage write SetProfileImage;
    Property IsPresent : Boolean read _IsPresent write SetIsPresent;
  end;
{$METHODINFO OFF}
implementation
{ TUser }

function TBaby.GetProfileBitmap:TBitmap;
var
path : string;
circleItem: TCircle;
begin
Try
   Result:= TBitmap.Create;
   circleItem := TCircle.Create(nil);
  {$IFDEF MSWINDOWS}
    path := ExpandFileName(GetCurrentDir) + '\images\bebe1.jpg';
  {$ELSE}
    path := TPath.GetDocumentsPath + '/bebe1.jpg';
  {$ENDIF}
  circleItem.Fill.Bitmap.Bitmap.LoadFromFile(path);
  circleItem.Fill.Bitmap.WrapMode:= TWrapMode.TileStretch;
  circleItem.Fill.Kind := TBrushKind.Bitmap;
  circleItem.Stroke.Kind:= TBrushKind.Bitmap;
Finally
   Result :=  circleItem.MakeScreenshot;
   circleItem.Free;
End;

end;

Constructor TBaby.Create(id : integer; firstName:string; lastName: string;profileImage:string;isPresent:Boolean);
begin
    self._Id           := id;
    self._FirstName    := firstName;
    self._LastName     := lastName;
    Self._ProfileImage := profileImage;
    Self._IsPresent    := isPresent;
    Self.ProfileBitmap := GetProfileBitmap();
end;

procedure TBaby.SetFirstName(const Value: string);
begin
  _FirstName := Value;
end;

procedure TBaby.SetId(const Value: integer);
begin
  _Id := Value;
end;

procedure TBaby.SetLastName(const Value: string);
begin
  _LastName := Value;
end;

procedure TBaby.SetProfileImage(const Value: string);
begin
  _ProfileImage := Value;
end;

procedure TBaby.SetIsPresent(const Value: Boolean);
begin
  _IsPresent := Value;
end;
end.

