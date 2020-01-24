unit uUserService;

interface

uses
  System.Generics.Collections,
  XData.Service.Common,
  uUser
  ;

type
  [ServiceContract]
  IUserService = interface(IInvokable)
    ['{59E8312E-7B4A-4C06-A3D3-A961D1BFAF00}']

    [HttpGet]
    function GetUsers(): TList<Tuser>;

    [HttpGet]
    function GetUserByName(firstName : string): Tuser;

    [HttpPost]
    function SetUser(user : Tuser): Boolean;

    // By default, any service operation responds to (is invoked by) a POST request from the client.
    function EchoString(Value: string): string;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IUserService));

end.
