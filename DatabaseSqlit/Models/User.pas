unit User;

interface
uses
System.SysUtils,System.Generics.Collections;

type
{$METHODINFO ON}
  TUser = class
  private

    _Id: integer;
    _FirstName: string;
    _LastName: string;

    procedure SetFirstName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetLastName(const Value: string);

    { Private declarations }
  public
    { Public declarations }
   //Constructor Create; overload;
    Constructor Create(id : integer; firstName:string; lastName: string);
    Property Id: integer read _Id write SetId;
    Property FirstName : string read _FirstName write SetFirstName;
    Property LastName : string read _LastName write SetLastName;

  end;
{$METHODINFO OFF}
implementation

{ TUser }


Constructor TUser.Create(id : integer; firstName:string; lastName: string);
begin
    self._Id         := id;
    self._FirstName  := firstName;
    self._LastName   := lastName;
end;

procedure TUser.SetFirstName(const Value: string);
begin
  _FirstName := Value;
end;

procedure TUser.SetId(const Value: integer);
begin
  _Id := Value;
end;

procedure TUser.SetLastName(const Value: string);
begin
  _LastName := Value;
end;

end.

