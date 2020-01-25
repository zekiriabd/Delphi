program WebSocket_1;
{$I Synopse.inc}
{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  SynCommons,
  mORMot,
  ChatHub in 'Hubs\ChatHub.pas';

var
  aModel: TSQLModel;
  server : TChatHub;
  action :string;
begin
  aModel := TSQLModel.Create([],'service');
  server := TChatHub.Create();
  try
    Writeln('server is started');
    Readln(action);
  finally
    server.Free;
    aModel.Free;
  end;
end.
