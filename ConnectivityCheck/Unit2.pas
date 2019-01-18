unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, UNetworkState,
  FMX.Ani;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Layout1: TLayout;
    Label1: TLabel;
    FloatAnimation1: TFloatAnimation;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FNetworkState: TNetworkState;
  protected
    procedure DoOnChange(Sender: TObject; Value: TNetworkStateValue);
  public

  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}



procedure TForm2.Button1Click(Sender: TObject);
begin
     if self.FNetworkState.CurrentValue = nsConnectedWifi then
    self.Memo1.Lines.Add('On startup: Connected with WiFi')
  else if self.FNetworkState.CurrentValue = nsConnectedMobileData then
    self.Memo1.Lines.Add('On startup: Connected with mobile data')
  else if self.FNetworkState.CurrentValue = nsDisconnected then
    self.Memo1.Lines.Add('On startup: Disconnected')
  else
    self.Memo1.Lines.Add('On startup: Unknown');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   self.FNetworkState := TNetworkState.Factory(self, DoOnChange);
end;


procedure TForm2.DoOnChange(Sender: TObject; Value: TNetworkStateValue);
begin
  if Value = nsDisconnected  then
  begin
     Label1.Visible:=True;
     FloatAnimation1.Enabled := false;
     FloatAnimation1.Inverse := false;
     FloatAnimation1.Enabled := True;
  end
  else
  begin
    FloatAnimation1.Enabled := false;
    FloatAnimation1.Inverse := true;
    FloatAnimation1.Enabled := True;
  end;
end;


end.
