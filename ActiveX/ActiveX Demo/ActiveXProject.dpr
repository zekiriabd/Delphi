library ActiveXProject;

uses
  ComServ,
  Project2_TLB in 'Project2_TLB.pas',
  MainPageIU in 'MainPageIU.pas' {MainPage: TActiveForm} {MainPage: CoClass};

{$E ocx}

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
