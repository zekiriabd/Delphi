program MVVMProject;



uses
  System.StartUpCopy,
  FMX.Forms,
  UserView in 'UserView.pas' {Form2},
  UserViewModel in 'UserViewModel.pas',
  UserModel in 'UserModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
