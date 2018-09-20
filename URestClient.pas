unit URestClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,REST.Json, FMX.ScrollBox, FMX.Memo,
  FMX.Edit, IPPeerClient, REST.Client, REST.Response.Adapter,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
TUser = class
    private
      FuserId :integer;
      FjobTitleName:string;
      FfirstName:string;
      FlastName:string;
      FemailAddress:string;
    published
      property userId :       integer read FuserId       write FuserId;
      property jobTitleName : string  read FjobTitleName write FjobTitleName;
      property firstName :    string  read FfirstName    write FfirstName;
      property lastName :     string  read FlastName     write FlastName;
      property emailAddress : string  read FemailAddress write FemailAddress;
  end;

  TForm5 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Memo1: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTResponse1: TRESTResponse;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}


procedure TForm5.Button1Click(Sender: TObject);
var
 RestClient   : TRESTClient;
 RestResponse : TRESTResponse;
 RestRequest  : TRESTRequest;
 User         : TUser;

begin

  TRY
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);

    RestClient.BaseURL   := 'https://free.currencyconverterapi.com';
    RestRequest.Resource := '/api/v6/convert?q=USD_EUR&compact=y';
    RestRequest.Client   := RestClient;
    RestRequest.Response := RestResponse;

    RestRequest.Execute;
    Memo1.Text := RestResponse.Content;

    RESTRequest1.Execute;
    Memo1.Text := RESTResponse1.Content;

    Memo1.Text :='{"userId":1,"jobTitleName":"Developer","firstName":"Zekiri","lastName":"Abdelali","emailAddress":"zekiriabd@gmail.com"}';
    User := TUser.Create();
    User := TJson.JsonToObject<Tuser>(Memo1.Text);
    Edit1.Text:=User.userId.ToString();
    Edit2.Text:=User.jobTitleName;
    Edit3.Text:=User.firstName;
    Edit4.Text:=User.lastName;
    Edit5.Text:=User.emailAddress;
  FINALLY
    RestClient.Free;
    RestResponse.Free;
    RestRequest.Free;
  END;

end;
end.
