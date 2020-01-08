unit RedisDictionary;

interface

uses
System.SysUtils,System.Generics.Collections, //System
REST.JSON,Redis.Commons,Redis.Client,Redis.NetLib.INDY,Redis.Values,//Redis
UserR; //Entities

type
  TRedisDictionary = class(TDictionary<TObject, TObject>)
  private
    redisDB: IRedisClient;
    redisKey: string;
  public
    Constructor Create(_redisKey:string);
    procedure Add(key: string; value: TObject);
    function FindAll(): string;
    function FindById(key : string): string;
    function Remove(key : string): Boolean;
    function clearAll(): Boolean;
    function Serialize(obj: TObject): string;
    function Deserialize(serialized: string): TObject;
    Destructor  Destroy; override;
  end;
implementation
{ TUserR }

constructor TRedisDictionary.Create(_redisKey: string);
begin
   self.redisKey := _redisKey;
   self.redisDB  := TRedisClient.Create;
   self.redisDB.Connect();
end;

procedure TRedisDictionary.Add(key: string; value: TObject);
begin
   self.redisDB.HSET(self.redisKey, key , Serialize(value));
end;

function TRedisDictionary.FindAll(): string;
begin
   var value:= '';
   self.redisDB.HGET(self.redisKey, value);
   Result:= value;
end;

function TRedisDictionary.FindById(key : string): string;
var user : TRedisString;
begin
  user   := self.redisDB.HGET(self.redisKey , key);
  result := user.Value;
end;

function TRedisDictionary.Remove(key : string): Boolean;
var keys: TArray<string>;
begin
  SetLength(keys, 1); keys[0]:= key;
  result := Boolean(self.redisDB.HDel(self.redisKey , keys));
end;

function TRedisDictionary.clearAll(): Boolean;
begin
  result := Boolean(self.redisDB.DEL(self.redisKey));
end;

function TRedisDictionary.Serialize(obj: TObject): string;
begin
   result := TJson.ObjectToJsonString(obj)
end;

function TRedisDictionary.Deserialize(serialized: string): TObject;
begin
   result:= TJson.JsonToObject<TObject>(serialized);
end;

destructor TRedisDictionary.Destroy;
begin
  self.redisDB.Disconnect();
  FreeAndNil(self.redisDB);
  inherited;
end;

end.
