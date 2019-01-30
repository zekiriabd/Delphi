unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.WebBrowser, FMX.Controls.Presentation ,system.iOUtils,
  FMXTee.Chart, FMXTee.Engine, FMXTee.Series, FMXTee.Procs, FMXTee.Series.Bubble;

type
  TForm4 = class(TForm)
    Chart1: TChart;
    Series1: TPieSeries;
    procedure FormCreate(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.FormCreate(Sender: TObject);
var i:Integer;
begin
  Chart1.Series[0].Clear; //Efface le contenu de la série
  for i:=0 to 10 do  //Ajoute 10 valeurs dans la série
  Chart1.Series[0].Add(Random(50)); //Ajoute un nombre entre 0 et 50 à la série
end;

end.
