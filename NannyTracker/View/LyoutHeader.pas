unit LyoutHeader;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFlyoutHeader = class(TFrame)
    RHeader: TRectangle;
    LContent: TLayout;
    LEmail: TLabel;
    CImage: TCircle;
    LName: TLabel;
    procedure Loead();
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

  end;

implementation

uses uUser, REST.Json, System.iOUtils;

{$R *.fmx}

procedure TFlyoutHeader.Loead();
var
  User: TUser;
  text: string;
  path: string;
begin
  text := '{"userId":1,"firstName":"Zekiri","lastName":"Abdelali","emailAddress":"zekiriabd@gmail.com" ,"image":"zekiri.jpg"}';
  User := TUser.Create();
  User := TJson.JsonToObject<TUser>(text);
  LEmail.text := User.emailAddress;
  LName.text := User.firstName + ' ' + User.lastName;
  path := TPath.GetDocumentsPath + PathDelim + User.image;
  CImage.Fill.Bitmap.Bitmap.LoadFromFile(path);
end;

end.
