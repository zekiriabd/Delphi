unit UserR;

interface
type
  TUserR = class
  private
    FId: integer;
    FName: string;

  public
    Property Id: integer read FId write FId;
    Property Name : string read FName write FName;
    Constructor Create; overload;
    Constructor Create(id : integer; Name:string); overload;

  end;
implementation

{ TUserR }

constructor TUserR.Create(id: integer; name: string);
begin
    self.Id   := id;
    self.Name := name;
end;

constructor TUserR.Create;
begin

end;

end.
