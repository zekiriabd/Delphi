program ConnectivityCheck;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  UNetworkState in 'UNetworkState.pas',
  UNetworkState.Android in 'Lib\Android\UNetworkState.Android.pas',
  UBroadcastReceiver in 'Lib\Android\BroadcastReceiver\UBroadcastReceiver.pas',
  UNetworkStateBroadcastReceiver in 'Lib\Android\BroadcastReceiver\UNetworkStateBroadcastReceiver.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
