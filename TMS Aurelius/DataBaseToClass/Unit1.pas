unit Unit1;

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
  TCOURSE = class;
  TTAGE = class;
  TTEACHER = class;
  TVIDEO = class;
  TCOURSETableDictionary = class;
  TTAGETableDictionary = class;
  TTEACHERTableDictionary = class;
  TVIDEOTableDictionary = class;
  
  [Entity]
  [Table('COURSE')]
  [Id('FIDcourse', TIdGenerator.IdentityOrSequence)]
  TCOURSE = class
  private
    [Column('IDcourse', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FIDcourse: Integer;

    [Column('Name', [TColumnProp.Required], 200)]
    FName: string;
  public
    property IDcourse: Integer read FIDcourse write FIDcourse;
    property Name: string read FName write FName;
  end;
  
  [Entity]
  [Table('TAGE')]
  [Id('FKey', TIdGenerator.None)]
  [Id('FIDvideo', TIdGenerator.None)]
  TTAGE = class
  private
    [Column('Key', [TColumnProp.Required], 10)]
    FKey: string;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('IDvideo', [TColumnProp.Required], 'IDvideo')]
    FIDvideo: Proxy<TVIDEO>;
    function GetIDvideo: TVIDEO;
    procedure SetIDvideo(const Value: TVIDEO);
  public
    property Key: string read FKey write FKey;
    property IDvideo: TVIDEO read GetIDvideo write SetIDvideo;
  end;
  
  [Entity]
  [Table('TEACHER')]
  [Id('FIDteacher', TIdGenerator.IdentityOrSequence)]
  TTEACHER = class
  private
    [Column('IDteacher', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FIDteacher: Integer;
    
    [Column('FirstName', [TColumnProp.Required], 150)]
    FFirstName: string;
    
    [Column('LastName', [TColumnProp.Required], 150)]
    FLastName: string;
    
    [Column('Description', [TColumnProp.Lazy])]
    [DBTypeWideMemo]
    FDescription: TBlob;
    
    [Column('ChannelName', [TColumnProp.Required], 150)]
    FChannelName: string;
    
    [Column('Image', [], 200)]
    FImage: Nullable<string>;
  public
    property IDteacher: Integer read FIDteacher write FIDteacher;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property Description: TBlob read FDescription write FDescription;
    property ChannelName: string read FChannelName write FChannelName;
    property Image: Nullable<string> read FImage write FImage;
  end;
  
  [Entity]
  [Table('VIDEO')]
  [Id('FIDvideo', TIdGenerator.IdentityOrSequence)]
  TVIDEO = class
  private
    [Column('IDvideo', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FIDvideo: Integer;
    
    [Column('Name', [], 200)]
    FName: Nullable<string>;
    
    [Column('Url', [], 300)]
    FUrl: Nullable<string>;
    
    [Column('Date', [])]
    FDate: Nullable<TDateTime>;
    
    [Column('Image', [], 200)]
    FImage: Nullable<string>;
    
    [Column('LikedCount', [])]
    FLikedCount: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('IDCourse', [], 'IDcourse')]
    FIDCourse: Proxy<TCOURSE>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('IDteacher', [], 'IDteacher')]
    FIDteacher: Proxy<TTEACHER>;
    function GetIDCourse: TCOURSE;
    procedure SetIDCourse(const Value: TCOURSE);
    function GetIDteacher: TTEACHER;
    procedure SetIDteacher(const Value: TTEACHER);
  public
    property IDvideo: Integer read FIDvideo write FIDvideo;
    property Name: Nullable<string> read FName write FName;
    property Url: Nullable<string> read FUrl write FUrl;
    property Date: Nullable<TDateTime> read FDate write FDate;
    property Image: Nullable<string> read FImage write FImage;
    property LikedCount: Nullable<Integer> read FLikedCount write FLikedCount;
    property IDCourse: TCOURSE read GetIDCourse write SetIDCourse;
    property IDteacher: TTEACHER read GetIDteacher write SetIDteacher;
  end;
  
  TDicDictionary = class
  private
    FCOURSE: TCOURSETableDictionary;
    FTAGE: TTAGETableDictionary;
    FTEACHER: TTEACHERTableDictionary;
    FVIDEO: TVIDEOTableDictionary;
    function GetCOURSE: TCOURSETableDictionary;
    function GetTAGE: TTAGETableDictionary;
    function GetTEACHER: TTEACHERTableDictionary;
    function GetVIDEO: TVIDEOTableDictionary;
  public
    destructor Destroy; override;
    property COURSE: TCOURSETableDictionary read GetCOURSE;
    property TAGE: TTAGETableDictionary read GetTAGE;
    property TEACHER: TTEACHERTableDictionary read GetTEACHER;
    property VIDEO: TVIDEOTableDictionary read GetVIDEO;
  end;
  
  TCOURSETableDictionary = class
  private
    FIDcourse: TDictionaryAttribute;
    FName: TDictionaryAttribute;
  public
    constructor Create;
    property IDcourse: TDictionaryAttribute read FIDcourse;
    property Name: TDictionaryAttribute read FName;
  end;
  
  TTAGETableDictionary = class
  private
    FKey: TDictionaryAttribute;
    FIDvideo: TDictionaryAssociation;
  public
    constructor Create;
    property Key: TDictionaryAttribute read FKey;
    property IDvideo: TDictionaryAssociation read FIDvideo;
  end;
  
  TTEACHERTableDictionary = class
  private
    FIDteacher: TDictionaryAttribute;
    FFirstName: TDictionaryAttribute;
    FLastName: TDictionaryAttribute;
    FDescription: TDictionaryAttribute;
    FChannelName: TDictionaryAttribute;
    FImage: TDictionaryAttribute;
  public
    constructor Create;
    property IDteacher: TDictionaryAttribute read FIDteacher;
    property FirstName: TDictionaryAttribute read FFirstName;
    property LastName: TDictionaryAttribute read FLastName;
    property Description: TDictionaryAttribute read FDescription;
    property ChannelName: TDictionaryAttribute read FChannelName;
    property Image: TDictionaryAttribute read FImage;
  end;
  
  TVIDEOTableDictionary = class
  private
    FIDvideo: TDictionaryAttribute;
    FName: TDictionaryAttribute;
    FUrl: TDictionaryAttribute;
    FDate: TDictionaryAttribute;
    FImage: TDictionaryAttribute;
    FLikedCount: TDictionaryAttribute;
    FIDCourse: TDictionaryAssociation;
    FIDteacher: TDictionaryAssociation;
  public
    constructor Create;
    property IDvideo: TDictionaryAttribute read FIDvideo;
    property Name: TDictionaryAttribute read FName;
    property Url: TDictionaryAttribute read FUrl;
    property Date: TDictionaryAttribute read FDate;
    property Image: TDictionaryAttribute read FImage;
    property LikedCount: TDictionaryAttribute read FLikedCount;
    property IDCourse: TDictionaryAssociation read FIDCourse;
    property IDteacher: TDictionaryAssociation read FIDteacher;
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

{ TTAGE }

function TTAGE.GetIDvideo: TVIDEO;
begin
  result := FIDvideo.Value;
end;

procedure TTAGE.SetIDvideo(const Value: TVIDEO);
begin
  FIDvideo.Value := Value;
end;

{ TVIDEO }

function TVIDEO.GetIDCourse: TCOURSE;
begin
  result := FIDCourse.Value;
end;

procedure TVIDEO.SetIDCourse(const Value: TCOURSE);
begin
  FIDCourse.Value := Value;
end;

function TVIDEO.GetIDteacher: TTEACHER;
begin
  result := FIDteacher.Value;
end;

procedure TVIDEO.SetIDteacher(const Value: TTEACHER);
begin
  FIDteacher.Value := Value;
end;

{ TDicDictionary }

destructor TDicDictionary.Destroy;
begin
  if FVIDEO <> nil then FVIDEO.Free;
  if FTEACHER <> nil then FTEACHER.Free;
  if FTAGE <> nil then FTAGE.Free;
  if FCOURSE <> nil then FCOURSE.Free;
  inherited;
end;

function TDicDictionary.GetCOURSE: TCOURSETableDictionary;
begin
  if FCOURSE = nil then FCOURSE := TCOURSETableDictionary.Create;
  result := FCOURSE;
end;

function TDicDictionary.GetTAGE: TTAGETableDictionary;
begin
  if FTAGE = nil then FTAGE := TTAGETableDictionary.Create;
  result := FTAGE;
end;

function TDicDictionary.GetTEACHER: TTEACHERTableDictionary;
begin
  if FTEACHER = nil then FTEACHER := TTEACHERTableDictionary.Create;
  result := FTEACHER;
end;

function TDicDictionary.GetVIDEO: TVIDEOTableDictionary;
begin
  if FVIDEO = nil then FVIDEO := TVIDEOTableDictionary.Create;
  result := FVIDEO;
end;

{ TCOURSETableDictionary }

constructor TCOURSETableDictionary.Create;
begin
  inherited;
  FIDcourse := TDictionaryAttribute.Create('IDcourse');
  FName := TDictionaryAttribute.Create('Name');
end;

{ TTAGETableDictionary }

constructor TTAGETableDictionary.Create;
begin
  inherited;
  FKey := TDictionaryAttribute.Create('Key');
  FIDvideo := TDictionaryAssociation.Create('IDvideo');
end;

{ TTEACHERTableDictionary }

constructor TTEACHERTableDictionary.Create;
begin
  inherited;
  FIDteacher := TDictionaryAttribute.Create('IDteacher');
  FFirstName := TDictionaryAttribute.Create('FirstName');
  FLastName := TDictionaryAttribute.Create('LastName');
  FDescription := TDictionaryAttribute.Create('Description');
  FChannelName := TDictionaryAttribute.Create('ChannelName');
  FImage := TDictionaryAttribute.Create('Image');
end;

{ TVIDEOTableDictionary }

constructor TVIDEOTableDictionary.Create;
begin
  inherited;
  FIDvideo := TDictionaryAttribute.Create('IDvideo');
  FName := TDictionaryAttribute.Create('Name');
  FUrl := TDictionaryAttribute.Create('Url');
  FDate := TDictionaryAttribute.Create('Date');
  FImage := TDictionaryAttribute.Create('Image');
  FLikedCount := TDictionaryAttribute.Create('LikedCount');
  FIDCourse := TDictionaryAssociation.Create('IDCourse');
  FIDteacher := TDictionaryAssociation.Create('IDteacher');
end;

initialization
  RegisterEntity(TCOURSE);
  RegisterEntity(TTAGE);
  RegisterEntity(TTEACHER);
  RegisterEntity(TVIDEO);

finalization
  if __Dic <> nil then __Dic.Free

end.
