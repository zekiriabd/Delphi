program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  REST.Authenticator.OAuth,
  REST.Client;

var 
    oAuth2Client: TOAuth2Authenticator;
    service: TRESTClient;
    request: TRESTRequest;
    response: TRESTResponse;
    x:string;

const SCOPES = 
    'https://www.googleapis.com/auth/drive ' +
    'https://www.googleapis.com/auth/drive.file ' +
    'https://www.googleapis.com/auth/drive.metadata ' +
    'https://www.googleapis.com/auth/drive.appdata ';

const TOKEN = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';

// Create an OAuth2 client with the given credentials    
procedure GetUserCredentials();
begin
     oAuth2Client:= TOAuth2Authenticator.Create(nil);
     Try
        oAuth2Client.AccessToken := TOKEN;
        oAuth2Client.Scope := SCOPES;
     Except on E: Exception do
        Writeln(E.Message);
     End;  
end;


// Lists the names and IDs of up to 10 files.    
procedure Getfiles();
begin
   service  := TRESTClient.Create(nil);
   response := TRESTResponse.Create(nil);
   request  := TRESTRequest.Create(nil);
Try   
  Try
    service.Authenticator := oAuth2Client;
    service.Accept := 'application/json; charset=UTF-8';
    service.BaseURL := 'https://www.googleapis.com/drive/v3/files';

    request.Client := service;
    request.Response := response;
    
    request.Execute;
    
    Writeln(response.Content);

    Except
       on E: Exception do
       Writeln(E.Message);
    End;
Finally

End;
   response.Free;
   request.Free;
end;


// Lists the names and IDs of up to 10 files.    
procedure DownloadFile(fileId: string);
begin
 Try
   response := TRESTResponse.Create(nil);
   request  := TRESTRequest.Create(nil);
  Try
    service.BaseURL := 'https://www.googleapis.com/drive/v3/files/'+
                        fileId +
                        '/export?mimeType=image/jpeg';
    request.Client := service;
    request.Response := response;
    
    request.Execute;
    
    Writeln(response.Content);

    Except
       on E: Exception do
       Writeln(E.Message);
    End;
 Finally
   response.Free;
   request.Free;
 End;

end;




// Main() Methode 
begin
   GetUserCredentials();

   Getfiles();

   DownloadFile('XXXXXXXXXXXX');

   service.Free;   
   oAuth2Client.Free;
   
   Readln(X);
end.

