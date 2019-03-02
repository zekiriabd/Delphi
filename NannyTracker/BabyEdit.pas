unit BabyEdit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit;

type
  TFBabyEdit = class(TFrame)
    Layout1: TLayout;
    Circle1: TCircle;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle4: TRectangle;
    SpeedButton1: TSpeedButton;
    Save: TLabel;
    Edit1: TEdit;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Edit2: TEdit;
    Rectangle7: TRectangle;
    Edit3: TEdit;
    Rectangle8: TRectangle;
    Edit4: TEdit;
    Rectangle9: TRectangle;
    Edit5: TEdit;

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
