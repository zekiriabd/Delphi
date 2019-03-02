unit UBaby;

interface
uses
System.SysUtils,System.Generics.Collections,FMX.Graphics,FMX.Objects,
System.iOUtils,System.UITypes,FMX.Dialogs;

type
{$METHODINFO ON}
  TBaby = class
  private

    _Id: integer;
    _FirstName: string;
    _LastName: string;
    _ProfileImage :string;

    procedure SetFirstName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetLastName(const Value: string);
    procedure SetProfileImage(const Value: string);

    //function ImagePathToCircleBitmap(imageName : string):TBitmap;
    function GetProfileBitmap():TBitmap;

    { Private declarations }
  public
    { Public declarations }
    ProfileBitmap :TBitmap;
    Age:Integer;
    BabyName : string;

   //Constructor Create; overload;
    Constructor Create(id : integer; firstName:string; lastName: string; profileImage:string;isPresent:Boolean);
    Property Id: integer read _Id write SetId;
    Property FirstName : string read _FirstName write SetFirstName;
    Property LastName : string read _LastName write SetLastName;
    Property ProfileImage : string read _ProfileImage write SetProfileImage;

  end;
{$METHODINFO OFF}
implementation

function ImagePathToCircleBitmap(imageName : string):TBitmap;
var
path : string;
circleItem: TCircle;
const
  IMGDIR = 'Images';
begin
Try
  Result:= TBitmap.Create;
  circleItem := TCircle.Create(nil);
  path := TPath.GetDocumentsPath + '/' + IMGDIR +'/' + imageName;
  circleItem.Fill.Bitmap.Bitmap.LoadFromFile(path);
  circleItem.Fill.Bitmap.WrapMode:= TWrapMode.TileStretch;
  circleItem.Fill.Kind := TBrushKind.Bitmap;
  circleItem.Stroke.Thickness:= 0;
Finally
   Result :=  circleItem.MakeScreenshot;
   circleItem.Free;
End;

end;

function TBaby.GetProfileBitmap:TBitmap;
begin
    Result :=  ImagePathToCircleBitmap(Self._ProfileImage);
end;


Constructor TBaby.Create(id : integer; firstName:string; lastName: string;profileImage:string;isPresent:Boolean);
begin
    self._Id           := id;
    self._FirstName    := firstName;
    self._LastName     := lastName;
    Self.BabyName      :=  self._FirstName + ' ' +   self._LastName;
    Self._ProfileImage := profileImage;
    Self.Age           :=  10; //CalcAge();

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


end.

