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
    procedure Add(key: TObject; value: TObject);
    function Serialize(obj: TObject): string;
    function Deserialize(serialized: string): TObject;
  end;
implementation
{ TUserR }

constructor TRedisDictionary.Create(_redisKey: string);
begin
   self.redisKey := _redisKey;
   self.redisDB  := TRedisClient.Create;
end;

procedure TRedisDictionary.Add(key: TObject; value: TObject);
begin
   self.redisDB.HSET(self.redisKey, Serialize(key), Serialize(value));
end;

function TRedisDictionary.Serialize(obj: TObject): string;
begin
   result := TJson.ObjectToJsonString(obj)
end;

function TRedisDictionary.Deserialize(serialized: string): TObject;
begin
   result:= TJson.JsonToObject<TObject>(serialized);
end;

end.
