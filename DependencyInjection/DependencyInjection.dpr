program DependencyInjection;
{$APPTYPE CONSOLE}
{$R *.res}
uses
  System.SysUtils,
  UserService in 'UserService.pas',
  UserDao in 'UserDao.pas';

  var x:Integer;


begin
   var oUserService := TUserService.Create(TUserDao.Create);
   var name := oUserService.getFullName();

   Writeln('##############################');
   Writeln(name);
   Writeln('##############################');

Readln(x);
end.
