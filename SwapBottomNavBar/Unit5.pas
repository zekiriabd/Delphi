unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Ani, FMX.TabControl,
  FMX.Gestures;

type
  TForm5 = class(TForm)
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Rectangle2: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    Rectangle3: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    Rectangle5: TRectangle;
    Image4: TImage;
    Label4: TLabel;
    Rectangle6: TRectangle;
    Image5: TImage;
    Label5: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    GestureManager1: TGestureManager;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Circle1: TCircle;
    Circle2: TCircle;
    Circle3: TCircle;
    Circle4: TCircle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    FloatAnimation4: TFloatAnimation;
    procedure TabControl1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure RectangleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}
{$R *.iPhone55in.fmx IOS}

procedure TForm5.RectangleClick(Sender: TObject);
var
  control :TControl;
  selectRec: TRectangle;
  circle : TCircle;
  floatAnimation : TFloatAnimation;
begin
  selectRec := (Sender as TRectangle);
  circle := (selectRec.Controls[2] as TCircle);
  floatAnimation := (circle.Children[0] as TFloatAnimation);
     circle.Visible := True;
     floatAnimation.Enabled      := False;
     floatAnimation.AutoReverse  := True;
     floatAnimation.PropertyName := 'Opacity';
     floatAnimation.StartValue   := 0;
     floatAnimation.StopValue    := 0.5;
     floatAnimation.Duration     := 0.3;
     floatAnimation.Enabled      := True;

   Rectangle1.Fill.Color :=  selectRec.Stroke.Color;
   TabControl1.TabIndex :=   selectRec.Tag;

   for control in GridPanelLayout1.Controls do
   begin
      ((control as TRectangle).Controls[1] as TLabel).TextSettings.Font.Style := [];
   end;

  (selectRec.Controls[1] as TLabel).TextSettings.Font.Style := [TFontStyle.fsBold];
end;

procedure TForm5.TabControl1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
    control :TControl;
    selectRec: TRectangle;
    selectLabel :TLabel;
begin
    if (EventInfo.GestureID = sgiRight) and (TabControl1.TabIndex > 0) then
        TabControl1.TabIndex := TabControl1.TabIndex - 1
    else
    if (EventInfo.GestureID = sgiLeft) and (TabControl1.TabIndex < TabControl1.TabCount - 1) then
        TabControl1.TabIndex := TabControl1.TabIndex + 1;


     for control in GridPanelLayout1.Controls do
     begin
        ((control as TRectangle).Controls[1] as TLabel).TextSettings.Font.Style := [];
     end;

     selectRec := (GridPanelLayout1.Controls[TabControl1.TabIndex ] as TRectangle);
     Rectangle1.Fill.Color :=  selectRec.Stroke.Color;


     selectLabel := (selectRec.Controls[1] as TLabel);
    (selectRec.Controls[1] as TLabel).TextSettings.Font.Style := [TFontStyle.fsBold];



end;
end.


