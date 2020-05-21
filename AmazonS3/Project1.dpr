program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses

System.SysUtils,
System.Classes,
System.IOUtils,

FMX.Forms,

Data.Cloud.CloudAPI,
Data.Cloud.AmazonAPI;



const accessKeyID = 'XXXXXXXXXXX';
const secretKey   = 'ZZZZZZZZZZZZZZZZ';
const bucketName  = 'YYYYYYYYYYYYYYYYYY';
const postDir     = 'D:\\';

var x: string;
var firstfileisOk : Boolean = False;
var aws           : TAmazonConnectionInfo;
var service       : TAmazonStorageService;

// Create an OAuth2 client with the given credentials
procedure GetUserCredentials();
var
    list : TStrings;
    str : string;
begin
     list    := TStrings.Create();

     aws:= TAmazonConnectionInfo.Create(nil);
     aws.AccountName := accessKeyID;
     aws.AccountKey  := secretKey;
     aws.region      := TAmazonRegion.amzrUSEast1;

     service := TAmazonStorageService.Create(aws);
//     list    := service.ListBuckets();
//     for str in list do Writeln(str);
end;

// Lists the names and IDs of up to 10 files.
procedure DownloadFile(fileId: string);
var
  mfile     : TBytesStream;
  localFile : string;
begin
    mfile     := TBytesStream.Create;
    localFile :=  TGUID.NewGuid.ToString() + '.csv';
    try
        service.GetObject( bucketName, fileId, mfile);
        mfile.SaveToFile(TPath.Combine(postDir , localFile));
        firstfileisOk := True;
    finally
      mfile.Free;
    end;
End;

// Lists the names and IDs of up to 10 files.
procedure Getfiles();
var
    response        : TAmazonBucketResult;
    fileobj         : TAmazonObjectResult;
    filePath        :  TArray<string>;
    exten           :  string;
begin
  Try
      response := service.GetBucket(bucketName,nil);

      for fileobj in response.Objects do
      begin
          filePath := fileobj.Name.Split(['/']);
          if (length(filePath) = 3) and (filePath[2].Contains('.')) then
          begin
              exten := filePath[2].Split(['.'])[1];
              Writeln(string.Format('key = XXXXXXXXXX.%s size = %d', [exten, fileobj.Size]));

              if not(firstfileisOk) then
               DownloadFile(fileobj.Name);
          end;
      end;
    Except
       on E: Exception do
       Writeln(E.Message);
    End;

end;



// Main() Methode
begin
   GetUserCredentials();

   Getfiles();

   //service.Free;
   aws.Free;

   Readln(X);
end.

