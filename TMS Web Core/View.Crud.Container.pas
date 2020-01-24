unit View.Crud.Container;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, WEBLib.Controls, Vcl.Forms,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls,

  Bcl.Rtti.Common,

  App.Types;

type
  TShowCrudListProc = reference to function(const AElementId: string;
    AEditProc: TEditProc): TWebForm;
  TShowCrudEditProc = reference to function(const AElementId: string;
    AListProc: TListProc; AId: JSValue): TWebForm;

  TFViewCrudContainer = class(TWebForm)
    WebPanel1: TWebPanel;
    lbTitle: TWebLabel;
  private
    FChildForm: TWebForm;
    FShowCrudListProc: TShowCrudListProc;
    FShowCrudEditProc: TShowCrudEditProc;
    procedure ShowListForm;
    procedure ShowEditForm(AId: TValue);
  public
    class function CreateForm(AElementID: string;
      ATitle: string; AShowCrudListProc: TShowCrudListProc;
      AShowCrudEditProc: TShowCrudEditProc): TWebForm;
  end;

var
  FViewCrudContainer: TFViewCrudContainer;

implementation


{$R *.dfm}

class function TFViewCrudContainer.CreateForm(AElementID, ATitle: string;
  AShowCrudListProc: TShowCrudListProc; AShowCrudEditProc: TShowCrudEditProc): TWebForm;

  procedure AfterCreate(AForm: TObject);
  begin
    TFViewCrudContainer(AForm).lbTitle.Caption := ATitle;
    TFViewCrudContainer(AForm).FShowCrudListProc := AShowCrudListProc;
    TFViewCrudContainer(AForm).FShowCrudEditProc := AShowCrudEditProc;
    TFViewCrudContainer(AForm).ShowListForm;
  end;

begin
  Application.CreateForm(TFViewCrudContainer, AElementID, Result, @AfterCreate);
end;

procedure TFViewCrudContainer.ShowEditForm(AId: JSValue);
begin
  if Assigned(FChildForm) then
    FChildForm.Free;
  FChildForm := FShowCrudEditProc(WebPanel1.ElementID, @ShowListForm, AId);
end;

procedure TFViewCrudContainer.ShowListForm;
begin
  if Assigned(FChildForm) then
    FChildForm.Free;
  FChildForm := FShowCrudListProc(WebPanel1.ElementID, @ShowEditForm);
end;

end.
