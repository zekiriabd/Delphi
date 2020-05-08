unit UBaby;

interface

uses
  System.SysUtils, System.Generics.Collections, FMX.Graphics, FMX.Objects,
  System.iOUtils, System.UITypes, FMX.Dialogs;

type
{$METHODINFO ON}
  TBaby = class
  private

    _Id: integer;
    _FirstName: string;
    _LastName: string;
    _ProfileImage: string;

    procedure SetFirstName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetLastName(const Value: string);
    procedure SetProfileImage(const Value: string);

    // function ImagePathToCircleBitmap(imageName : string):TBitmap;
    function GetProfileBitmap(): TBitmap;
    function GetBgItemBitmap(): TBitmap;

    { Private declarations }
  public
    { Public declarations }
    ProfileBitmap: TBitmap;
    Age: integer;
    BabyName: string;
    BgItem: TBitmap;

    // Constructor Create; overload;
    Constructor Create(id: integer; firstName: string; lastName: string;
      profileImage: string; isPresent: Boolean);
    Property id: integer read _Id write SetId;
    Property firstName: string read _FirstName write SetFirstName;
    Property lastName: string read _LastName write SetLastName;
    Property profileImage: string read _ProfileImage write SetProfileImage;

  end;
{$METHODINFO OFF}

implementation

function ImagePathToCircleBitmap(imageName: string): TBitmap;
var
  path: string;
  circleItem: TCircle;
const
  IMGDIR = 'Images';
begin
  Try
    Result := TBitmap.Create;
    circleItem := TCircle.Create(nil);
    path := TPath.GetDocumentsPath + '/' + IMGDIR + '/' + imageName;
    circleItem.Fill.Bitmap.Bitmap.LoadFromFile(path);
    circleItem.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
    circleItem.Fill.Kind := TBrushKind.Bitmap;
    circleItem.Stroke.Thickness := 0;
  Finally
    Result := circleItem.MakeScreenshot;
    circleItem.Free;
  End;

end;

function ImagePathToRectangleBitmap(imageName: string): TBitmap;
var
  path: string;
  RectangleItem: TRectangle;
const
  IMGDIR = 'Images';
begin
  Try
    Result := TBitmap.Create;
    RectangleItem := TRectangle.Create(nil);
    path := TPath.GetDocumentsPath + '/' + IMGDIR + '/' + imageName;
    RectangleItem.Fill.Bitmap.Bitmap.LoadFromFile(path);
    RectangleItem.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
    RectangleItem.Fill.Kind := TBrushKind.Bitmap;
    RectangleItem.Stroke.Thickness := 0;
  Finally
    Result := RectangleItem.MakeScreenshot;
    RectangleItem.Free;
  End;

end;

function TBaby.GetProfileBitmap: TBitmap;
begin
  Result := ImagePathToCircleBitmap(Self._ProfileImage);
end;

function TBaby.GetBgItemBitmap: TBitmap;
begin
  Result := ImagePathToRectangleBitmap('itemBg.png');
end;

Constructor TBaby.Create(id: integer; firstName: string; lastName: string;
  profileImage: string; isPresent: Boolean);
begin
  Self._Id := id;
  Self._FirstName := firstName;
  Self._LastName := lastName;
  Self.BabyName := Self._FirstName + ' ' + Self._LastName;
  Self._ProfileImage := profileImage;
  Self.Age := 10; // CalcAge();
  Self.BgItem := GetBgItemBitmap();

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
