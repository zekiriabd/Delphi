unit BabyEdit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit;

type
  TFBabyEdit = class(TFrame)
    Layout3: TLayout;
    Layout2: TLayout;
    Layout1: TLayout;
    Circle1: TCircle;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Rectangle2: TRectangle;
    Rectangle4: TRectangle;
    SpeedButton1: TSpeedButton;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    Rectangle10: TRectangle;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

procedure TFBabyEdit.SpeedButton1Click(Sender: TObject);
begin
    ShowMessage('Save');
end;

end.
