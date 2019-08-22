library WebApplicationCOM_ASP;

{$R *.dres}

uses
  ComServ,
  WebApplicationCOM_ASP_TLB in 'WebApplicationCOM_ASP_TLB.pas',
  Controller in 'Controllers\Controller.pas' {Controller: CoClass},
  DatabaseAccess in 'Database\DatabaseAccess.pas',
  User in 'Model\User.pas' {User: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.TLB}

{$R *.RES}

begin
end.
