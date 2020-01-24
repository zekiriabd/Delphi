unit View.user.List;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, Vcl.StdCtrls, Math,

  WEBLib.StdCtrls, Web, JS, WEBLib.Lists,

  App.Types, WEBLib.Controls, WEBLib.Grids, Data.DB,
  XData.Web.Dataset, WEBLib.DBCtrls, WEBLib.DB, WEBLib.ExtCtrls,

  XData.Web.JsonDataset,
  XData.Web.Dataset,

  Grid.Plugins,
  Crud.Utils;

type
  TFViewuserList = class(TWebForm)
    btNew: TWebButton;
    userDataset: TXDataWebDataSet;
    userDatasetid: TIntegerField;
    userDatasetFirstName: TStringField;
    userDatasetLastName: TStringField;
    WebDBTableControl1: TWebDBTableControl;
    WebDataSource: TWebDataSource;
    cbPageSize: TWebComboBox;
    edSearch: TWebEdit;
    lbPaginationInfo: TWebLabel;
    lcPaginator: TWebListControl;
    procedure WebFormCreate(Sender: TObject);
    procedure btNewClick(Sender: TObject);
    procedure WebDBTableControl1GetCellChildren(Sender: TObject; ACol,
      ARow: Integer; AField: TField; AValue: string; AElement: TJSHTMLElement);
    procedure cbPageSizeChange(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
  private
    FEditProc: TEditProc;
    FGridPlugin: TGridPlugin;
  public
    class function CreateForm(AElementID: string; AShowEditProc: TEditProc): TWebForm;
  end;

var
  FViewuserList: TFViewuserList;

implementation

uses
  ConnectionModule;

{$R *.dfm}

{ TFViewuserList }

procedure TFViewuserList.cbPageSizeChange(Sender: TObject);
begin
  FGridPlugin.SetPageSize(StrToInt(cbPageSize.Text), True);
end;

class function TFViewuserList.CreateForm(AElementID: string;
  AShowEditProc: TEditProc): TWebForm;

  procedure AfterCreate(AForm: TObject);
  begin
    TFViewuserList(AForm).FEditProc := AShowEditProc;
  end;

begin
  Application.CreateForm(TFViewuserList, AElementID, Result, @AfterCreate);
end;

procedure TFViewuserList.edSearchChange(Sender: TObject);
begin
  FGridPlugin.SetFilterText(edSearch.Text, True);
end;

procedure TFViewuserList.btNewClick(Sender: TObject);
begin
  FEditProc( nil );
end;

procedure TFViewuserList.WebDBTableControl1GetCellChildren(Sender: TObject;
  ACol, ARow: Integer; AField: TField; AValue: string;
  AElement: TJSHTMLElement);
var
  RecordId: JSValue;

  procedure EditButtonClick(Sender: TObject);
  begin
    FEditProc(RecordId);
  end;

var
  ElementID: string;
  Button: TWebButton;
begin
  if ARow = 0 then
    Exit;

  if WebDBTableControl1.Columns[ACol].Title = 'Actions' then
  begin
    RecordId := TCrudUtils.GetIdFromObject(
      userDataset.Connection.Model.DefaultSchema.FindEntityType(userDataset.EntitySetName),
      userDataset.CurrentData
    );
    Button := TWebButton.Create(nil);
    Button.Caption := 'Edit';
    Button.OnClick := @EditButtonClick;
    Button.ElementClassName := 'btn btn-outline btn-default btn-xs';
    Button.ParentElement := AElement;
    Button.WidthStyle := TSizeStyle.ssAuto;
    Button.HeightStyle := TSizeStyle.ssAuto;
  end;
end;

procedure TFViewuserList.WebFormCreate(Sender: TObject);
begin
  FGridPlugin := TGridPlugin.Create(
    WebDBTableControl1,
    userDataset,
    lcPaginator,
    lbPaginationInfo
  );
  FGridPlugin.SetPageSize(StrToInt(cbPageSize.Text));
  FGridPlugin.SetFilterText(edSearch.Text);
  FGridPlugin.Load;
end;

end.
