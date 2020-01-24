unit App.Config;

interface

uses
  JS,
  XData.Web.Connection,
  XData.Web.Request,
  XData.Web.Response;

type
  TAppConfig = class
  private
    FAuthUrl: string;
    FApiUrl: string;
  public
    constructor Create;
    property AuthUrl: string read FAuthUrl write FAuthUrl;
    property ApiUrl: string read FApiUrl write FApiUrl;
  end;

  TConfigLoadedProc = reference to procedure(Config: TAppConfig);

  procedure LoadConfig(LoadProc: TConfigLoadedProc);

implementation

procedure LoadConfig(LoadProc: TConfigLoadedProc);

  procedure OnSuccess(Response: IHttpResponse);
  var
    Obj: TJSObject;
    Config: TAppConfig;
  begin
    Config := TAppConfig.Create;
    try
      if Response.StatusCode = 200 then
      begin
        Obj := TJSObject(TJSJSON.parse(Response.ContentAsText));

        if JS.toString(Obj['AuthUrl']) <> '' then
          Config.AuthUrl := JS.toString(Obj['AuthUrl']);

        if JS.toString(Obj['ApiUrl']) <> '' then
          Config.ApiUrl := JS.toString(Obj['ApiUrl']);
      end;
    finally
      LoadProc(Config);
      Config.Free;
    end;
  end;

  procedure OnError;
  var
    Config: TAppConfig;
  begin
    Config := TAppConfig.Create;
    try
      LoadProc(Config);
    finally
      Config.Free;
    end;
  end;

var
  Conn: TXDataWebConnection;
begin
  Conn := TXDataWebConnection.Create(nil);
  try
    Conn.SendRequest(THttpRequest.Create('config/config.json'), @OnSuccess, @OnError);
  finally
    Conn.Free;
  end;
end;

{ TAppConfig }

constructor TAppConfig.Create;
begin
  FAuthUrl := '';
  FApiUrl := '';
end;

end.
