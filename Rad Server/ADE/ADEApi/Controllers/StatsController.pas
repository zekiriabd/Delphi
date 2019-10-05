unit StatsController;

interface

uses

  System.SysUtils,System.Classes,System.JSON,System.Generics.Collections,EMS.Services,
  EMS.ResourceAPI,EMS.ResourceTypes,rest.json;

type
 [ResourceName('stats')]
  {$METHODINFO ON}
  TStatsController = class
  published

    [ResourceSuffix('/getstatsbyyear/{year}')]
    [EndPointRequestSummary('User Management', '', 'Get user by id from user table mysql database ', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'Id', '', true, TAPIDoc.TPrimitiveType.spInteger,
    TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spInteger, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure GetStatsByYear(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  {$METHODINFO OFF}

  end;
implementation
uses Client,UserDataAccess;

procedure TStatsController.GetStatsByYear(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  id:string;
  user:TClient;
begin
  id  := ARequest.Params.Values['id'];
  user := TUserDataAccess.GetUserById(StrToInt(id));
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(user), True);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TStatsController));
end;

initialization
  Register;
end.


