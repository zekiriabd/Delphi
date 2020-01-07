program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form3},
  RedisDictionary in 'Redis\RedisDictionary.pas',
  UserR in 'Redis\entities\UserR.pas',
  IUserRepo in 'Redis\repositories\IUserRepo.pas',
  UserRepoImp in 'Redis\repositories\UserRepoImp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
