unit uUser;

interface

uses
  SysUtils, 
  Generics.Collections, 
  Aurelius.Mapping.Attributes, 
  Aurelius.Types.Blob, 
  Aurelius.Types.DynamicProperties, 
  Aurelius.Types.Nullable, 
  Aurelius.Types.Proxy, 
  Aurelius.Criteria.Dictionary;

type
  Tuser = class;
  TuserTableDictionary = class;
  
  [Entity]
  [Table('user')]
  [Id('Fid', TIdGenerator.IdentityOrSequence)]
  Tuser = class
  private
    [Column('id', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    Fid: Integer;
    
    [Column('FirstName', [TColumnProp.Required], 255)]
    FFirstName: string;
    
    [Column('LastName', [TColumnProp.Required], 255)]
    FLastName: string;
  public
    property id: Integer read Fid write Fid;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
  end;
  
  TDicDictionary = class
  private
    Fuser: TuserTableDictionary;
    function Getuser: TuserTableDictionary;
  public
    destructor Destroy; override;
    property user: TuserTableDictionary read Getuser;
  end;
  
  TuserTableDictionary = class
  private
    Fid: TDictionaryAttribute;
    FFirstName: TDictionaryAttribute;
    FLastName: TDictionaryAttribute;
  public
    constructor Create;
    property id: TDictionaryAttribute read Fid;
    property FirstName: TDictionaryAttribute read FFirstName;
    property LastName: TDictionaryAttribute read FLastName;
  end;
  
function Dic: TDicDictionary;

implementation

var
  __Dic: TDicDictionary;

function Dic: TDicDictionary;
begin
  if __Dic = nil then __Dic := TDicDictionary.Create;
  result := __Dic
end;

{ TDicDictionary }

destructor TDicDictionary.Destroy;
begin
  if Fuser <> nil then Fuser.Free;
  inherited;
end;

function TDicDictionary.Getuser: TuserTableDictionary;
begin
  if Fuser = nil then Fuser := TuserTableDictionary.Create;
  result := Fuser;
end;

{ TuserTableDictionary }

constructor TuserTableDictionary.Create;
begin
  inherited;
  Fid := TDictionaryAttribute.Create('id');
  FFirstName := TDictionaryAttribute.Create('FirstName');
  FLastName := TDictionaryAttribute.Create('LastName');
end;

initialization
  RegisterEntity(Tuser);

finalization
  if __Dic <> nil then __Dic.Free

end.
