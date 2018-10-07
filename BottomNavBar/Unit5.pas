unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TForm5 = class(TForm)
    Rectangle2: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    Rectangle3: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    Rectangle4: TRectangle;
    Image3: TImage;
    Label3: TLabel;
    Rectangle5: TRectangle;
    Image4: TImage;
    Label4: TLabel;
    Rectangle6: TRectangle;
    Image5: TImage;
    Label5: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    Rectangle1: TRectangle;
    GridPanelLayout2: TGridPanelLayout;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Image6: TImage;
    Label6: TLabel;
    Rectangle9: TRectangle;
    Image7: TImage;
    Label7: TLabel;
    Rectangle10: TRectangle;
    Image8: TImage;
    Label8: TLabel;
    Rectangle11: TRectangle;
    Image9: TImage;
    Label9: TLabel;
    Rectangle12: TRectangle;
    Image10: TImage;
    Label10: TLabel;
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



procedure TForm5.RectangleClick(Sender: TObject);
var
  control :TControl;
begin
   for control in GridPanelLayout2.Controls do
   begin
      (control as TRectangle).Fill.Color := TAlphaColorRec.Null;
   end;
   (Sender as TRectangle).Fill.Color := TAlphaColorRec.Aqua;
end;

end.
