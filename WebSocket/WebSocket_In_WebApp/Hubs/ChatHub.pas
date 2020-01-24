unit ChatHub;

interface
uses
  SysUtils,
  SynZip,
  SynCrtSock,
  SynCommons;
type
  TChatHub = class
  private
      fServer: THttpApiWebSocketServer;
      function GetHttpRequest(Ctxt: THttpServerRequest): cardinal;
  public
   constructor Create;
   destructor Destroy; override;
end;

implementation
constructor TChatHub.Create;
begin
  fServer := THttpApiWebSocketServer.Create(false, 8, 10000);
  fServer.AddUrl('','8080', False, 'localhost');
  fServer.OnRequest := GetHttpRequest;
end;

function TChatHub.GetHttpRequest(Ctxt: THttpServerRequest): cardinal;
begin
  Ctxt.OutContent := 'Static/index.html';
  Ctxt.OutContentType := HTTP_RESP_STATICFILE;
  Result := 200;
end;

destructor TChatHub.Destroy;
begin
  fServer.Free;
  inherited;
end;

end.
