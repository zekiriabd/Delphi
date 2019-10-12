unit User;

interface
uses
Aurelius.Mapping.Attributes,System.Generics.Collections;

type
  [Entity, Automapping]
  [Table('user')]
  TUser = class
  private
    [Column('Id')]
    Fid: integer;
    [Column('First_Name')]
    FlastName: string;
    [Column('Last_Name')]
    FfirstName: string;
  public
    Property id: integer read Fid write Fid;
    Property firstName : string read FlastName write FlastName;
    Property lastName : string read FfirstName write FfirstName;
    Constructor Create; overload;
    Constructor Create(_id : integer; _firstName:string; _lastName: string); overload;
  end;

  TArrayUser = Array of TUser;
  TUserList = class
  private
    FValues: TArrayUser;
  public
    Property Values: TArrayUser read FValues write FValues;
  end;




implementation

Constructor TUser.Create(); begin end;

Constructor TUser.Create(_id : integer; _firstName:string; _lastName: string);
begin
    self.id     := _id;
    self.firstName := _firstName;
    self.lastName   := _lastName;
end;

end.
