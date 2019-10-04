unit UserController;

// EMS Resource Module

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,

  EMS.Services,
  EMS.ResourceAPI,
  EMS.ResourceTypes,

  rest.json;

type
  [ResourceName('api')]
  {$METHODINFO ON}
  TUserControllerResource = class
  published

    [ResourceSuffix('/user/GetUsers')]
    procedure GetUsers(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [ResourceSuffix('/user/PostUser')]
    procedure PostUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [ResourceSuffix('/user/GetUserById/{id}')]
    procedure GetUserById(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

  end;
  {$METHODINFO OFF}

implementation
uses User,UserDataAccess;

procedure TUserControllerResource.GetUsers(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  users : TList<TUser>;
begin
  users:= TUserDataAccess.GetUsers();
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(users), True);
end;


procedure TUserControllerResource.GetUserById(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  id:string;
  user:TUser;
begin
  id  := ARequest.Params.Values['id'];
  user := TUserDataAccess.GetUserById(StrToInt(id));
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(user), True);
end;

procedure TUserControllerResource.PostUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jsUser : TJSONObject;
  user : TUser;
begin
  jsUser := ARequest.Body.GetObject;
  user := TUser.Create(
          StrToInt(jsUser.GetValue('id').Value),
          jsUser.GetValue('firstName').Value,
          jsUser.GetValue('lastName').Value
          );
  TUserDataAccess.Insert(user);
end;


procedure Register;
begin
  RegisterResource(TypeInfo(TUserControllerResource));
end;

initialization
  Register;
end.


