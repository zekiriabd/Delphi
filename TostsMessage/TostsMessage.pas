unit TostsMessage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Rectangle1: TRectangle;
    lbMessage: TLabel;
    Image1: TImage;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    procedure Button1Click(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    { Private declarations }
    procedure ShowTost(msg: string);
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.ShowTost(msg: string);
begin
     lbMessage.Text:= msg;
     FloatAnimation1.Enabled      := False;
     FloatAnimation2.Enabled      := False;
     Rectangle1.Visible           := True;

     FloatAnimation1.PropertyName     := 'Position.Y';
     FloatAnimation1.StartFromCurrent := True;
     FloatAnimation1.StopValue        := Image1.Position.Y + 500;
     FloatAnimation1.Duration         := 1;

     FloatAnimation2.PropertyName := 'Opacity';
     FloatAnimation2.StartValue   := 0.1;
     FloatAnimation2.StopValue    := 0.7;
     FloatAnimation2.Duration     := 3;
     FloatAnimation2.Inverse      := True;

     FloatAnimation1.Enabled          := True;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
    ShowTost('Custom Toast By Zekiri Abdelali');
end;


procedure TForm5.FloatAnimation1Finish(Sender: TObject);
begin
     FloatAnimation2.Enabled := True;
end;

procedure TForm5.FloatAnimation2Finish(Sender: TObject);
begin
     Rectangle1.Opacity := 0.7;
     Rectangle1.Visible := False;

end;

end.
