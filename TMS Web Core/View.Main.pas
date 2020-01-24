unit View.Main;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, Vcl.Forms, WEBLib.Controls, WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls,
  App.Types,
  ConnectionModule, WEBLib.Lists,

  View.Crud.Container;

type
  TFViewMain = class(TWebForm)
    WebPanel1: TWebPanel;
    lbViewHome: TWebLinkLabel;  
    lbViewuser: TWebLinkLabel;
    procedure WebFormCreate(Sender: TObject);    
	procedure lbViewHomeClick(Sender: TObject);	
    procedure lbViewuserClick(Sender: TObject);
  private
    FChildForm: TWebForm;
    procedure ShowForm(AFormClass: TWebFormClass);
    procedure ShowCrudContainer(ACrudFormClass: TWebFormClass; ATitle: string;
      AShowCrudListProc: TShowCrudListProc; AShowCrudEditProc: TShowCrudEditProc);
  public
    class procedure Display(AElementId: string; LogoutProc: TLogoutProc);
  end;

var
  FViewMain: TFViewMain;

implementation

uses
  JS, Web,
  Auth.Service,
  View.Login,
  View.UserProfile,  
  View.user.List,
  View.user.Edit,
  View.Home;

{$R *.dfm}

procedure TFViewMain.WebFormCreate(Sender: TObject);
begin
  FChildForm := nil;
  ShowForm(TFViewHome);
end;

procedure TFViewMain.lbViewHomeClick(Sender: TObject);
begin
  ShowForm(TFViewHome);
end;

procedure TFViewMain.lbViewuserClick(Sender: TObject);

  function CreateuserListForm(const AElementId: string; AEditProc: TEditProc): TWebForm;
  begin
    Result := TFViewuserList.CreateForm(AElementId, AEditProc);
  end;

  function CreateuserEditForm(const AElementId: string; AListProc: TListProc;
    AId: JSValue): TWebForm;
  begin
    Result := TFViewuserEdit.CreateForm(AElementId, AListProc, AId);
  end;

begin
  ShowCrudContainer(TFViewuserList, 'user', @CreateuserListForm, @CreateuserEditForm);
end;



class procedure TFViewMain.Display(AElementId: string; LogoutProc: TLogoutProc);

  procedure AfterCreate(AForm: TObject);
  begin
    //TFViewMain(AForm).FLogoutProc := LogoutProc;
  end;

begin
  if Assigned(FViewMain) then
    FViewMain.Free;
  FViewMain := TFViewMain.CreateNew(AElementId, @AfterCreate);
end;

procedure TFViewMain.ShowCrudContainer(ACrudFormClass: TWebFormClass; ATitle: string;
  AShowCrudListProc: TShowCrudListProc; AShowCrudEditProc: TShowCrudEditProc);

  function CreateAlbumListForm(const AElementId: string; AEditProc: TEditProc): TWebForm;
    procedure AfterCreateListForm(Form: TObject);
    begin
      TJSObject(Form)['FEditProc'] := AEditProc;
    end;
  begin
    Application.CreateForm(ACrudFormClass, AElementId, Result, @AfterCreateListForm);
  end;

  function CreateAlbumEditForm(const AElementId: string; AListProc: TListProc;
    AId: JSValue): TWebForm;
    procedure AfterCreateEditForm(Form: TObject);
    begin
      //TJSObject(Form)['FEditProc'] := AEditProc;
    end;
  begin
    //Application.CreateForm(ACrudFormClass, AElementId, Result, @AfterCreateListForm);

    //Result := TFViewAlbumEdit.CreateForm(AElementId, AListProc, AId);
  end;

begin
  if Assigned(FChildForm) then
    FChildForm.Free;
  FChildForm := TFViewCrudContainer.CreateForm(WebPanel1.ElementID,
    ATitle, @CreateAlbumListForm, AShowCrudEditProc
  );
end;

procedure TFViewMain.ShowForm(AFormClass: TWebFormClass);
begin
  if Assigned(FChildForm) then
    FChildForm.Free;
  Application.CreateForm(AFormClass, WebPanel1.ElementID, FChildForm);
end;

end.
