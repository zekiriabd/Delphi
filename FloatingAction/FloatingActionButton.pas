unit FloatingActionButton;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ImgList, FMX.Ani, FMX.Objects,
  FMX.Layouts;

type
  TForm5 = class(TForm)
    Circle1: TCircle;
    Rectangle1: TRectangle;
    Circle2: TCircle;
    Label2: TLabel;
    Label1: TLabel;
    Rectangle2: TRectangle;
    Circle3: TCircle;
    Label4: TLabel;
    Rectangle3: TRectangle;
    Circle4: TCircle;
    Label5: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    procedure Circle1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation
  uses System.Threading;
{$R *.fmx}

procedure TForm5.Circle1Click(Sender: TObject);
begin
     GridPanelLayout1.Visible:=True;
     Rectangle1.Visible           := True;
     FloatAnimation1.Enabled      := False;
     FloatAnimation1.Delay        := 0;
     FloatAnimation1.PropertyName := 'Position.Y';
     FloatAnimation1.StartValue   := 20;
     FloatAnimation1.StopValue    := 0;
     FloatAnimation1.Duration     := 0.5;
     FloatAnimation1.Inverse      := True;
     FloatAnimation1.Enabled      := True;

     Rectangle2.Visible           := True;
     FloatAnimation2.Enabled      := False;
     FloatAnimation2.Delay        := 1;
     FloatAnimation2.PropertyName := 'Position.Y';
     FloatAnimation2.StartValue   := 70;
     FloatAnimation2.StopValue    := 0;
     FloatAnimation2.Duration     := 1;
     FloatAnimation2.Inverse      := True;
     FloatAnimation2.Enabled      := True;

     Rectangle3.Visible           := True;
     FloatAnimation3.Enabled      := False;
     FloatAnimation3.Delay        := 2;
     FloatAnimation3.PropertyName := 'Position.Y';
     FloatAnimation3.StartValue   := 120;
     FloatAnimation3.StopValue    := 0;
     FloatAnimation3.Duration     := 1;
     FloatAnimation3.Inverse      := True;
     FloatAnimation3.Enabled      := True;


end;

end.

