unit View.Home;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.Controls, WEBLib.Grids,
  XData.Web.Client, WEBLib.ExtCtrls;

type
  TFViewHome = class(TWebForm)
    WebLabel1: TWebLabel;
    tcHome: TWebTableControl;
    XDataClient: TXDataWebClient;
    procedure WebFormCreate(Sender: TObject);
    procedure XDataClientLoad(Response: TXDataClientResponse);
  end;

var
  FViewHome: TFViewHome;

implementation

uses
  JS, XData.Model.Classes,
  ConnectionModule;

{$R *.dfm}


procedure TFViewHome.WebFormCreate(Sender: TObject);
var
  Container: TXDataEntityContainer;
  EntitySet: TXDataEntitySet;
  I: integer;
begin
  Container := XDataClient.Connection.Model.DefaultEntityContainer;

  tcHome.ColCount := 2;
  tcHome.RowCount := Container.EntitySets.Count + 1;

  tcHome.Cells[0, 0] := 'EntitySetName';
  tcHome.Cells[1, 0] := 'RecordCount';

  for I := 0 to Container.EntitySets.Count - 1 do
  begin
    EntitySet := Container.EntitySets[I];
    XDataClient.List(EntitySet.Name, '$top=0&$inlinecount=allpages', EntitySet.Name);
    tcHome.Cells[0, I + 1] := EntitySet.Name;
  end;
end;

procedure TFViewHome.XDataClientLoad(Response: TXDataClientResponse);
var
  I: integer;
  ResponseEntityName: string;
  RecordCount: string;
begin
  RecordCount := IntToStr(Response.Count);
  ResponseEntityName := Response.RequestId;
  for I := 1 to tcHome.RowCount do
  begin
    if tcHome.Cells[0, I] = ResponseEntityName then
    begin
      tcHome.Cells[1, I] := RecordCount;
      Break;
    end;
  end;
end;

end.
