

unit UserViewModel;

interface
uses FMX.Graphics,System.SysUtils;
type
  TUserViewModel = class
  private
    FuserId: integer;
    FfirstName: string;
    FlastName: string;
    Fimage: TBitmap;
  published
    property userId: integer read FuserId write FuserId;
    property firstName: string read FfirstName write FfirstName;
    property lastName: string read FlastName write FlastName;
    property image: TBitmap read Fimage write Fimage;
    Constructor Create();
  public
    procedure Update();
  end;

  implementation

{ TUserViewModel }

constructor TUserViewModel.Create();
begin
   Self.userId := 1;
   Self.firstName := 'zekiri';
   Self.lastName := 'abdelali';
   Self.image:= TBitmap.Create();
   Self.image.LoadFromFile(ExpandfileName(GetCurrentDir) +'\zekiri.png');
end;

procedure TUserViewModel.Update;
begin

end;

end.