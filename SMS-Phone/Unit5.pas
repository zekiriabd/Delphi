unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,

  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Telephony,

  FMX.Platform,
  FMX.PhoneDialer;

type
  TForm5 = class(TForm)
    btnSMS: TButton;
    btnPhone: TButton;
    procedure btnPhoneClick(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
  private
    { Private declarations }
    PhoneDialerService: IFMXPhoneDialerService;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;
var
  Form5: TForm5;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TForm5.btnSMSClick(Sender: TObject);
var
  smsManager: JSmsManager;
begin
  smsManager := TJSmsManager.JavaClass.getDefault;
  smsManager.sendTextMessage(StringToJString('0609690005'), nil, StringToJString('السلام عليكم'), nil, nil);
end;


constructor TForm5.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, IInterface(PhoneDialerService));
end;

procedure TForm5.btnPhoneClick(Sender: TObject);
begin
  if Assigned(PhoneDialerService) then
  begin
      PhoneDialerService.Call('0609690005');
  end;
end;

end.
