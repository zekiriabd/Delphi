unit User;

interface
uses
System.SysUtils,System.Generics.Collections;

type
{$METHODINFO ON}
  TUser = class
  private

    Id: integer;
    LastName: string;
    FirstName: string;

    procedure SetFirstName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetLastName(const Value: string);

    { Private declarations }
  public
    { Public declarations }
   //Constructor Create; overload;
    Constructor Create(id : integer; firstName:string; lastName: string);


    Property mId: integer read Id write SetId;
    Property mFirstName : string read FirstName write SetFirstName;
    Property mLastName : string read LastName write SetLastName;

  end;
{$METHODINFO OFF}
implementation

{ TUser }


Constructor TUser.Create(id : integer; firstName:string; lastName: string);
begin
    self.Id     := id;
    self.FirstName := firstName;
    self.LastName   := lastName;
end;

procedure TUser.SetFirstName(const Value: string);
begin
  FirstName := Value;
end;

procedure TUser.SetId(const Value: integer);
begin
  Id := Value;
end;

procedure TUser.SetLastName(const Value: string);
begin
  LastName := Value;
end;

end.

