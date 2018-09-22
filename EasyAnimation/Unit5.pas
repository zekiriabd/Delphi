unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Objects, FMX.Edit,
  FMX.Ani;

type
  TForm5 = class(TForm)
    Button3: TButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Edit1: TEdit;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    FloatAnimation1: TFloatAnimation;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
begin
     ShowMessage('السلام عليكم');
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
     //MessageDlg('Are you ready to learn Delphi in LUCCA?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbOK, System.UITypes.TMsgDlgBtn.mbCancel], 0)
     //MessageDlgPos(text, mtInformation, [mbOk], 0, 100, 200);
end;


procedure TForm5.Button4Click(Sender: TObject);
begin
     Rectangle1.Visible:=false;
     Rectangle2.Visible:=false;
end;

procedure TForm5.Label2Click(Sender: TObject);
begin
     Rectangle1.Visible:=false;
     Rectangle2.Visible:=false;

end;


procedure TForm5.Button3Click(Sender: TObject);
begin
     Rectangle1.Visible:=True;
     Rectangle2.Visible:=True;




    { FloatAnimation1.Enabled      := False;
     FloatAnimation1.PropertyName := 'RotationAngle';//'RotationCenter.X' / 'RotationCenter.Y'
     FloatAnimation1.StartValue   := 0;
     FloatAnimation1.StopValue    := 360;
     FloatAnimation1.Duration     := 5;
     FloatAnimation1.Enabled      := True;






     FloatAnimation1.Enabled      := False;
     FloatAnimation1.PropertyName := 'Size.Height';
     FloatAnimation1.StartValue   := 1;
     FloatAnimation1.StopValue    := 200;
     FloatAnimation1.Duration     := 1;
     FloatAnimation1.Enabled      := True;

          }

     FloatAnimation1.Enabled      := False;
     FloatAnimation1.PropertyName := 'Opacity';
     FloatAnimation1.StartValue   := 0.1;
     FloatAnimation1.StopValue    := 1;
     FloatAnimation1.Duration     := 3;
     FloatAnimation1.Enabled      := True;


end;

end.
