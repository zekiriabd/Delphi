program Project31WinHTTPEchoServer;
{$I Synopse.inc}
{$APPTYPE CONSOLE}
uses
  ChatHub in 'Hubs\ChatHub.pas';

var
  Server: TChatHub;
  s: string;
begin
  Server := TChatHub.Create;
  try
    Writeln('server is started');
    Readln(s);
  finally
      Server.Free;
  end;
end.
