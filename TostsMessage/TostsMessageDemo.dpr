program TostsMessageDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  TostsMessage in 'TostsMessage.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
