unit UserDB;

interface

uses
Aurelius.Mapping.Attributes;

type

  [Entity, Automapping]
  TUserDB = class
  private
    FId: integer;
    FLastName: string;
    FFirstName: string;
  public
    Property FirstName : string read FFirstName write FFirstName;
    Property LastName : string read FLastName write FLastName;
  end;

implementation


end.

