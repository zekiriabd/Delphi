unit uUserServiceImp;

interface

uses
  // Delphi System
  System.Generics.Collections,

  //XData Server
  XData.Server.Module,
  XData.Service.Common,

  //ORM
  Aurelius.Criteria.Base,
  Aurelius.Criteria.Linq,
  Aurelius.Criteria.Projections,

  //Local Class
  uUserService,
  uUser;

type
  [ServiceImplementation]
  TUserService = class(TInterfacedObject, IUserService)

  public

    function GetUsers(): TList<Tuser>;
    function GetUserByName(firstName : string): Tuser;
    function SetUser(user : Tuser): Boolean;

    function EchoString(Value: string): string;
  end;

implementation


function TUserService.GetUsers(): TList<Tuser>;
begin
   Result := TXDataOperationContext.Current.GetManager.Find<Tuser>().List();
end;

function TUserService.SetUser(user: Tuser): Boolean;
begin
     TXDataOperationContext.Current.GetManager.Save(user);
end;

function TUserService.GetUserByName(firstName : string): Tuser;
begin
  Result := TXDataOperationContext.Current.GetManager.Find<Tuser>()
  .Where(Linq['FirstName'] = firstName).List.First;
end;


function TUserService.EchoString(Value: string): string;
begin
  Result := Value;
end;

initialization
  RegisterServiceType(TUserService);

end.
