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
    Rectangle4: TRectangle;
    Layout1: TLayout;
    procedure Circle1Click(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
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
     Layout1.Visible := true;
     Rectangle1.Visible := true;
     FloatAnimation1.Delay        := 0;
     FloatAnimation1.PropertyName := 'Position.Y';
     FloatAnimation1.StartValue   := 20;
     FloatAnimation1.StopValue    := 0;
     FloatAnimation1.Duration     := 0.1;
     FloatAnimation1.Inverse      := True;
     FloatAnimation1.Enabled      := True;
end;

procedure TForm5.FloatAnimation1Finish(Sender: TObject);
begin
     Rectangle2.Visible := true;
     FloatAnimation2.Delay        := 0;
     FloatAnimation2.PropertyName := 'Position.Y';
     FloatAnimation2.StartValue   := 70;
     FloatAnimation2.StopValue    := 0;
     FloatAnimation2.Duration     := 0.3;
     FloatAnimation2.Inverse      := True;
     FloatAnimation2.Enabled      := True;
end;

procedure TForm5.FloatAnimation2Finish(Sender: TObject);
begin
     Rectangle3.Visible := true;
     FloatAnimation3.Delay        := 0;
     FloatAnimation3.PropertyName := 'Position.Y';
     FloatAnimation3.StartValue   := 100;
     FloatAnimation3.StopValue    := 0;
     FloatAnimation3.Duration     := 0.5;
     FloatAnimation3.Inverse      := True;
     FloatAnimation3.Enabled      := True;
end;

procedure TForm5.Rectangle1Click(Sender: TObject);
begin
    FloatAnimation3.Enabled      := false;
    FloatAnimation3.Enabled      := false;
    FloatAnimation3.Enabled      := false;
    Layout1.Visible := false;
end;

end.

