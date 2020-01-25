unit ChatHub;

interface
uses
  SynCrtSock,
  SynCommons,
  mORMot,
  SysUtils;

type
  TChatHub = class

  private
    fServer: THttpApiWebSocketServer;
//    function GetHttpRequest(Ctxt: THttpServerRequest): cardinal;

    procedure SandMessage(const Conn: THttpApiWebSocketConnection; aBufferType: WEB_SOCKET_BUFFER_TYPE; msg: Pointer; msgSize: Cardinal);

    function Accept(Ctxt: THttpServerRequest; var Conn: THttpApiWebSocketConnection): Boolean;
    procedure Connect(const Conn: THttpApiWebSocketConnection );
    procedure Disconnect(const Conn: THttpApiWebSocketConnection ; aStatus: WEB_SOCKET_CLOSE_STATUS; msg: Pointer; msgSize: Cardinal);

  public
    constructor Create;
    destructor Destroy; override;
  end;


implementation
constructor TChatHub.Create;
begin
  fServer := THttpApiWebSocketServer.Create(false, 8, 10000);
  fServer.AddUrl('','8080', False, 'localhost');
//  fServer.OnRequest := GetHttpRequest;

  fServer.AddUrlWebSocket('socket', '8080', False, 'localhost');
  fServer.RegisterProtocol('chatHub', False, Accept, SandMessage, Connect, Disconnect);

end;

//[receiveMessage]
procedure TChatHub.SandMessage(const Conn: THttpApiWebSocketConnection;
aBufferType: WEB_SOCKET_BUFFER_TYPE; msg: Pointer; msgSize: Cardinal);
begin
  //[sandMessage]
  fServer.Protocols[0].Broadcast(WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE, msg, msgSize);
end;

//function TChatHub.GetHttpRequest(Ctxt: THttpServerRequest): cardinal;
//begin
//  Ctxt.OutContent := 'static/index.html';
//  Ctxt.OutContentType := HTTP_RESP_STATICFILE;
//  Result := 200;
//end;


destructor TChatHub.Destroy;
begin
  fServer.Free;
  inherited;
end;








function TChatHub.Accept(Ctxt: THttpServerRequest;var Conn: THttpApiWebSocketConnection): Boolean;
begin
  Result := true;
end;

procedure TChatHub.Connect(const Conn: THttpApiWebSocketConnection); begin end;

procedure TChatHub.Disconnect(const Conn: THttpApiWebSocketConnection; aStatus: WEB_SOCKET_CLOSE_STATUS; msg: Pointer; msgSize: Cardinal); begin end;


end.
