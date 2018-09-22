program MediaPlayer;

uses
  System.StartUpCopy,
  FMX.Forms,
  Player in 'Player.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
