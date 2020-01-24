unit View.user.Edit;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,

  Bcl.Rtti.Common, XData.Web.Client, Data.DB, WEBLib.CDS,
  WEBLib.DBCtrls, XData.Web.JsonDataset, XData.Web.Dataset, JS,

  App.Types, Crud.Utils, WEBLib.DB, WEBLib.Controls, WEBLib.ExtCtrls;

type
  TFViewuserEdit = class(TWebForm)
    pnlMessage: TWebPanel;
    lbMessage: TWebLabel;
    btCloseMessage: TWebButton;
    DataSource: TWebDatasource;
    btCancel: TWebButton;
    btSave: TWebButton;
    btDelete: TWebButton;
    lbid: TWebLabel;
    edid: TWebDBEdit;
    lbFirstName: TWebLabel;
    edFirstName: TWebDBEdit;
    lbLastName: TWebLabel;
    edLastName: TWebDBEdit;
    XDataClientuserGet: TXDataWebClient;
    XDataClientuserDelete: TXDataWebClient;
    userDataset: TXDataWebDataSet;
    userDatasetid: TIntegerField;
    userDatasetFirstName: TStringField;
    userDatasetLastName: TStringField;
    procedure btCloseMessageClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure XDataClientuserGetLoad(Response: TXDataClientResponse);
    procedure XDataClientuserDeleteLoad(Response: TXDataClientResponse);
    procedure XDataClientuserDeleteError(Error: TXDataClientError);
    procedure userDatasetAfterApplyUpdates(Sender: TDataSet;
      Info: TResolveResults);
    procedure WebFormCreate(Sender: TObject);
  private
    FInserting: Boolean;
    FId: JSValue;
    FShowListProc: TListProc;
    procedure InsertEntity;
    procedure LoadEntity;
    procedure ShowNotification(Notification: string);
    procedure HiddenNotification;
    class function InternalCreateForm(AElementID: string;
      AShowListProc: TListProc; AInserting: Boolean; AId: JSValue): TWebForm; overload;
  public
    class function CreateForm(AElementID: string;
      AShowListProc: TListProc; AId: JSValue): TWebForm; overload;
  end;

var
  FViewuserEdit: TFViewuserEdit;

implementation

uses
  ConnectionModule;

{$R *.dfm}

{ TFViewuserEdit }

procedure TFViewuserEdit.btSaveClick(Sender: TObject);
begin
  if userDataset.State in dsEditModes then
  begin
        userDataset.Post;
    userDataset.ApplyUpdates;
  end
  else
    FShowListProc;
end;

procedure TFViewuserEdit.btDeleteClick(Sender: TObject);
begin
  if userDataset.State in dsEditModes then
    userDataset.Post;
  XDataClientuserDelete.Delete(userDataset.EntitySetName,
    TJSObject(userDataset.CurrentData));
end;


class function TFViewuserEdit.CreateForm(AElementID: string;
  AShowListProc: TListProc; AId: JSValue): TWebForm;
var
  Inserting: Boolean;
begin
  Inserting := isNull(AId);
  Result := InternalCreateForm(AElementID, AShowListProc, Inserting, AId);
end;

procedure TFViewuserEdit.HiddenNotification;
begin
  pnlMessage.ElementHandle.hidden := True;
end;

procedure TFViewuserEdit.InsertEntity;
begin
  userDataset.Close;
  userDataset.SetJsonData('{}');
  userDataset.Open;
  userDataset.Insert;
end;

class function TFViewuserEdit.InternalCreateForm(AElementID: string;
  AShowListProc: TListProc; AInserting: Boolean; AId: JSValue): TWebForm;

  procedure AfterCreate(AForm: TObject);
  begin
    TFViewuserEdit(AForm).FInserting := AInserting;
    TFViewuserEdit(AForm).FId := AId;
    TFViewuserEdit(AForm).FShowListProc := AShowListProc;
    if AInserting then
      TFViewuserEdit(AForm).InsertEntity
    else
      TFViewuserEdit(AForm).LoadEntity;
    TFViewuserEdit(AForm).btDelete.Enabled := not AInserting;
  end;

begin
  Application.CreateForm(TFViewuserEdit, AElementID, Result, @AfterCreate);
end;

procedure TFViewuserEdit.LoadEntity;
var
  QueryString: string;
begin
  QueryString := TCrudUtils.GetEntityGetQueryString(
    userDataset.Connection.Model.DefaultSchema.FindEntityType(
      userDataset.EntitySetName
    )
  );
  XDataClientuserGet.Get(userDataset.EntitySetName, QueryString, FId);
end;

procedure TFViewuserEdit.ShowNotification(Notification: string);
begin
  lbMessage.Caption := Notification;
  pnlMessage.ElementHandle.hidden := False;
end;

procedure TFViewuserEdit.btCloseMessageClick(Sender: TObject);
begin
  HiddenNotification;
end;

procedure TFViewuserEdit.WebFormCreate(Sender: TObject);
begin
  HiddenNotification;
end;

procedure TFViewuserEdit.XDataClientuserGetLoad(Response: TXDataClientResponse);
begin
  userDataset.Close;
  userDataset.SetJsonData(Response.Result);
  userDataset.Open;
  
  userDataset.Edit;  
end;

procedure TFViewuserEdit.XDataClientuserDeleteError(
  Error: TXDataClientError);
begin
  ShowNotification(Error.ErrorMessage);
end;

procedure TFViewuserEdit.XDataClientuserDeleteLoad(
  Response: TXDataClientResponse);
begin
  FShowListProc;
end;

procedure TFViewuserEdit.userDatasetAfterApplyUpdates(Sender: TDataSet;
  Info: TResolveResults);
var
  I: integer;
  ResolveInfo: TResolveInfo;
begin
  for I := 0 to Length(Info.Records) - 1 do
  begin
    ResolveInfo := Info.Records[I];
    if ResolveInfo.Status = TUpdateStatus.usResolveFailed then
    begin
      ShowNotification(ResolveInfo.Error);
      Exit;
    end;
  end;
  FShowListProc;
end;

procedure TFViewuserEdit.btCancelClick(Sender: TObject);
begin
  FShowListProc;
end;

end.
