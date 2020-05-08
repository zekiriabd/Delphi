unit UserModel;

interface

type
  TUserModel = class
  private
    FuserId: integer;
    FfirstName: string;
    FlastName: string;
    FemailAddress: string;
    Fimage: string;
  published
    property userId: integer read FuserId write FuserId;
    property firstName: string read FfirstName write FfirstName;
    property lastName: string read FlastName write FlastName;
    property emailAddress: string read FemailAddress write FemailAddress;
    property image: string read Fimage write Fimage;
  end;

implementation

end.
