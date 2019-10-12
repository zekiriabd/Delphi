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
  [ResourceName('user')]
  {$METHODINFO ON}
  TUserControllerResource = class
  published

    [ResourceSuffix('/GetUsers')]
    procedure GetUsers(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [ResourceSuffix('/PostUser')]
    procedure PostUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [ResourceSuffix('/GetUserById/{id}')]
    procedure GetUserById(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

  end;
  {$METHODINFO OFF}

implementation
uses Client,UserDataAccess,ClientService;

procedure TUserControllerResource.GetUsers(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  users : TList<TClient>;
begin
  users:= TUserDataAccess.GetUsers();
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(users), True);
end;


procedure TUserControllerResource.GetUserById(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  id:string;
  user:TClient;
begin
  id  := ARequest.Params.Values['id'];
  user := TUserDataAccess.GetUserById(StrToInt(id));
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(user), True);
end;

procedure TUserControllerResource.PostUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jsUser : TJSONObject;
  user : TClient;
begin
 { jsUser := ARequest.Body.GetObject;
  user := TClient.Create(
          StrToInt(jsUser.GetValue('id').Value),
          jsUser.GetValue('firstName').Value,
          jsUser.GetValue('lastName').Value
          );
  TUserDataAccess.Insert(user); }
  jsUser := ARequest.Body.GetObject;
  TClientService.Create().AddClient(jsUser);
end;


procedure Register;
begin
  RegisterResource(TypeInfo(TUserControllerResource));
end;

initialization
  Register;
end.


