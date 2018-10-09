program FloatingAction;

uses
  System.StartUpCopy,
  FMX.Forms,
  FloatingActionButton in 'FloatingActionButton.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
