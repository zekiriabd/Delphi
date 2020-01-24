unit Auth.Service;

interface

uses
  SysUtils, Web, JS,
  XData.Web.Client;

const
  TOKEN_NAME = 'XDATAMUSIC_TOKEN';

type
  TOnLoginSuccess = reference to procedure;
  TOnLoginError = reference to procedure(AMsg: string);

  TAuthService = class
  private
    FClient: TXDataWebClient;
    procedure SetToken(AToken: string);
    procedure DeleteToken;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Login(AUser, APassword: string; ASuccess: TOnLoginSuccess;
      AError: TOnLoginError);
    procedure Logout;
    function GetToken: string;
    function Authenticated: Boolean;
    function TokenExpirationDate: TDateTime;
    function TokenExpired: Boolean;
    function TokenPayload: JS.TJSObject;
  end;

  TJwtHelper = class
  private
    class function HasExpirationDate(AToken: string): Boolean;
  public
    class function TokenExpirationDate(AToken: string): TJSDate;
    class function TokenExpired(AToken: string): Boolean;
    class function DecodePayload(AToken: string): string;
  end;

  function AuthService: TAuthService;

implementation

uses
  ConnectionModule;

var
  _AuthService: TAuthService;

function AuthService: TAuthService;
begin
  if not Assigned(_AuthService) then
  begin
    _AuthService := TAuthService.Create;
  end;
  Result := _AuthService;
end;

{ TAuthService }

function TAuthService.Authenticated: Boolean;
begin
  Result := not isNull(window.localStorage.getItem(TOKEN_NAME)) and
            (window.localStorage.getItem(TOKEN_NAME) <> '');
end;

constructor TAuthService.Create;
begin
  FClient := TXDataWebClient.Create(nil);
  FClient.Connection := DMConnection.AuthConnection;
end;

procedure TAuthService.DeleteToken;
begin
  window.localStorage.removeItem(TOKEN_NAME);
end;

destructor TAuthService.Destroy;
begin
  FClient.Free;
  inherited;
end;

function TAuthService.GetToken: string;
begin
  Result := window.localStorage.getItem(TOKEN_NAME);
end;

procedure TAuthService.Login(AUser, APassword: string; ASuccess: TOnLoginSuccess;
  AError: TOnLoginError);

  procedure OnLoad(Response: TXDataClientResponse);
  var
    Token: JS.TJSObject;
  begin
    Token := JS.TJSObject(Response.Result);
    SetToken(JS.toString(Token.Properties['value']));
    ASuccess;
  end;

  procedure OnError(Error: TXDataClientError);
  begin
    AError(Format('%s: %s', [Error.ErrorCode, Error.ErrorMessage]));
  end;

begin
  if (AUser = '') or (APassword = '') then
  begin
    AError('Enter the username and password!');
    Exit;
  end;

  FClient.RawInvoke(
    'ILoginService.Login', [AUser, APassword],
    @OnLoad, @OnError
  );
end;

procedure TAuthService.Logout;
begin
  DeleteToken;
end;

procedure TAuthService.SetToken(AToken: string);
begin
  window.localStorage.setItem(TOKEN_NAME, AToken);
end;

function TAuthService.TokenExpirationDate: TDateTime;
var
  ExpirationDate: TJSDate;
begin
  if not Authenticated then
    Exit(Now);

  ExpirationDate := TJwtHelper.TokenExpirationDate(GetToken);

  Result := EncodeDate(
              ExpirationDate.FullYear,
              ExpirationDate.Month + 1,
              ExpirationDate.Date
            ) +
            EncodeTime(
              ExpirationDate.Hours,
              ExpirationDate.Minutes,
              ExpirationDate.Seconds,
              0
            );
end;

function TAuthService.TokenExpired: Boolean;
begin
  if not Authenticated then
    Exit(False);
  Result := TJwtHelper.TokenExpired(GetToken);
end;

function TAuthService.TokenPayload: JS.TJSObject;
begin
  if not Authenticated then
    Exit(nil);
  Result := TJSObject(TJSJSON.parse(TJwtHelper.DecodePayload(GetToken)));
end;

{ TJwtHelper }

class function TJwtHelper.DecodePayload(AToken: string): string;
begin
  if Trim(AToken) = '' then
    Exit('');
  Result := '';
  asm
    var Token = AToken.split('.');
    if (Token.length = 3) {
      Result = Token[1];
      Result = atob(Result);
    }
  end;
end;

class function TJwtHelper.HasExpirationDate(AToken: string): Boolean;
var
  Payload: string;
  Obj: TJSObject;
begin
  Payload := DecodePayload(AToken);
  Obj := TJSObject(TJSJSON.parse(Payload));
  Result := Obj.hasOwnProperty('exp');
end;

class function TJwtHelper.TokenExpirationDate(AToken: string): TJSDate;
var
  Payload: string;
  Obj: TJSObject;
  Epoch: NativeInt;
begin
  if not HasExpirationDate(AToken) then
    raise Exception.Create('Token has not expiration date');

  Payload := DecodePayload(AToken);
  Obj := TJSObject(TJSJSON.parse(Payload));
  Epoch := toInteger(Obj.Properties['exp']);
  Result := TJSDate.New(Epoch * 1000);
end;

class function TJwtHelper.TokenExpired(AToken: string): Boolean;
begin
  if not HasExpirationDate(AToken) then
    Exit(False);
  Result := TJSDate.now > toInteger(TokenExpirationDate(AToken).valueOf);
end;

end.
