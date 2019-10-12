unit UserController;

// EMS Resource Module

interface

uses
    System.SysUtils,
    System.Classes,
    System.JSON,
    System.Generics.Collections,

  // EMS ORM Unit --------
    EMS.Services,
    EMS.ResourceAPI,
    EMS.ResourceTypes,
    Aurelius.Engine.ObjectManager,

  // Local Unit --------
    User,
    UserDataAccess,
    UserDataAccessTMS,

  // REST Unit ---------
     REST.Json,
     REST.Client,
     REST.Response.Adapter,
     REST.Types;

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


    [ResourceSuffix('/user/DelUserById/{id}')]
    procedure DelUserByID(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [ResourceSuffix('/user/UpdateUser')]
    procedure UpdateUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);



    private
       Manager : TObjectManager;
    public
  end;
  {$METHODINFO OFF}

implementation

procedure TUserControllerResource.PostUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jsUser : TJSONObject;
  user : TUser;
  RestClient   : TRESTClient;
  RestResponse : TRESTResponse;
  RestRequest  : TRESTRequest;
begin

   RestClient   := TRESTClient.Create(nil);
   RestResponse := TRESTResponse.Create(nil);
   RestRequest  := TRESTRequest.Create(nil);
 TRY
   RestClient.BaseURL   := 'http://localhost:58919/api/';
   RestRequest.Method   := TRESTRequestMethod.rmPOST;
   RestRequest.Client   := RestClient;
   RestRequest.Resource := 'User/PostUser';
   RestRequest.Response := RestResponse;

   jsUser := ARequest.Body.GetObject;

   RestRequest.AddBody(jsUser);

   RestRequest.Execute;
 finally
    RestResponse.Free;
    RestRequest.Free;
    RestClient.Free;
 end;
end;



procedure TUserControllerResource.GetUsers(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  RestClient   : TRESTClient;
  RestResponse : TRESTResponse;
  RestRequest  : TRESTRequest;
  users        : TUserList;
  //users        : TList<TUser>;
  jsUsers      : string;
begin
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
 TRY
    RestClient.BaseURL   := 'http://localhost:58919/api/';
    RestRequest.Client   := RestClient;
    RestRequest.Resource := 'User/GetUsers';
    RestRequest.Response := RestResponse;
    RestRequest.Execute;
    jsUsers := RestResponse.JSONValue.ToString;
    //users := TList<TUser>.Create();
    //users := TJson.JsonToObject<TList<TUser>>(jsUsers);
    jsUsers:= '{"Values":'+ jsUsers +'}';
    users := TUserList.Create();
    users := TJson.JsonToObject<TUserList>(jsUsers);
    AResponse.Body.SetValue( TJSON.ObjectToJsonObject(users) , True);
finally
    RestResponse.Free;
    RestRequest.Free;
    RestClient.Free;
 end;
end;

{procedure TUserControllerResource.GetUsers(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  users : TList<TUser>;
begin
 try
  Manager := TUserDataAccessTMS.GetTmsManager();
  users := Manager.Find<TUser>().List();
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(users), True);
 finally
   Manager.Free;
 end;

end;  }
{
procedure TUserControllerResource.PostUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jsUser : TJSONObject;
  user : TUser;
begin
 try
   jsUser := ARequest.Body.GetObject;
   user := TUser.Create();
   user.FirstName :=jsUser.GetValue('firstName').Value;
   user.LastName := jsUser.GetValue('lastName').Value;

   Manager := TUserDataAccessTMS.GetTmsManager();

   Manager.Save(user);

 finally
   Manager.Free;
 end;
end;
  }
procedure TUserControllerResource.GetUserById(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  id:string;
  user:TUser;
begin
 try
   Manager := TUserDataAccessTMS.GetTmsManager();
   id  := ARequest.Params.Values['id'];
   user := Manager.Find<TUser>(StrToInt(id));
   AResponse.Body.SetValue( TJSON.ObjectToJsonObject(user), True);
 finally
   Manager.Free;
 end;

end;



procedure TUserControllerResource.DelUserByID(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  id:string;
  user:TUser;
begin
 try
   Manager := TUserDataAccessTMS.GetTmsManager();
   id  := ARequest.Params.Values['id'];
   user := Manager.Find<TUser>(StrToInt(id));
   Manager.Remove(user);
 finally
   Manager.Free;
 end;

end;

procedure TUserControllerResource.UpdateUser(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jsUser : TJSONObject;
  user : TUser;
begin
 try
   Manager := TUserDataAccessTMS.GetTmsManager();
   jsUser := ARequest.Body.GetObject;
   user := TUser.Create(StrToInt(jsUser.GetValue('id').Value),jsUser.GetValue('firstName').Value,jsUser.GetValue('lastName').Value);
   Manager.Update(user);
 finally
   Manager.Free;
 end;
end;


procedure Register;
begin
  RegisterResource(TypeInfo(TUserControllerResource));
end;


initialization
  Register;
end.


