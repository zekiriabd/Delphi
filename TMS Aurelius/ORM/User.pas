unit User;

interface
uses
Aurelius.Mapping.Attributes;

type

  [Entity, Automapping]
  TUser = class
  private

    FId: integer;
    FLastName: string;
    FFirstName: string;
  public
    Property Id: integer read FId write FId;
    Property FirstName : string read FFirstName write FFirstName;
    Property LastName : string read FLastName write FLastName;

  end;

implementation

end.

