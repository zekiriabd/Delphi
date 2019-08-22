unit Controller;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
ComObj, ActiveX, AspTlb, WebApplicationCOM_ASP_TLB, StdVcl,

Data.DB, Data.Win.ADODB,  User,
DatabaseAccess;

type
  TController = class(TASPObject, IController)
  protected
    procedure OnEndPage; safecall;
    procedure OnStartPage(const AScriptingContext: IUnknown); safecall;
    procedure HelloWorld; safecall;
    function GetUsers: OleVariant; stdcall;
  end;

implementation

uses ComServ;

procedure TController.OnEndPage;
begin
  inherited OnEndPage;
end;

procedure TController.OnStartPage(const AScriptingContext: IUnknown);
begin
  inherited OnStartPage(AScriptingContext);
end;

procedure TController.HelloWorld;
begin
    Response.Write('Hello World');
end;

function TController.GetUsers: OleVariant;
var user : IUser;
begin
       user := TUser.Create();
       user.Set_FirstName('Zekiri');
       user.Set_LastName('Abdelali');

       Result:=  user;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TController, Class_Controller,
    ciMultiInstance, tmApartment);
end.
