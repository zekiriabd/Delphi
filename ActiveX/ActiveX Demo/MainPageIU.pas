unit MainPageIU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, Project2_TLB, StdVcl, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.DBCtrls;

type
  TMainPage = class(TActiveForm, IMainPage)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    ADOStoredProc1: TADOStoredProc;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
  private
    { Private declarations }
    FEvents: IMainPageEvents;
    procedure ActivateEvent(Sender: TObject);
    procedure AfterMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);
    procedure BeforeMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);

    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure MouseEnterEvent(Sender: TObject);
    procedure MouseLeaveEvent(Sender: TObject);
    procedure PaintEvent(Sender: TObject);
  protected
    { Protected declarations }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_Active: WordBool; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_AlignWithMargins: WordBool; safecall;
    function Get_AutoScroll: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    function Get_BorderWidth: Integer; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_DockSite: WordBool; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_ExplicitHeight: Integer; safecall;
    function Get_ExplicitLeft: Integer; safecall;
    function Get_ExplicitTop: Integer; safecall;
    function Get_ExplicitWidth: Integer; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_KeyPreview: WordBool; safecall;
    function Get_MouseInClient: WordBool; safecall;
    function Get_ParentCustomHint: WordBool; safecall;
    function Get_ParentDoubleBuffered: WordBool; safecall;
    function Get_PixelsPerInch: Integer; safecall;
    function Get_PopupMode: TxPopupMode; safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    function Get_Scaled: WordBool; safecall;
    function Get_ScreenSnap: WordBool; safecall;
    function Get_SnapBuffer: Integer; safecall;
    function Get_UseDockManager: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    procedure Set_AlignWithMargins(Value: WordBool); safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    procedure Set_BorderWidth(Value: Integer); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    procedure Set_ParentCustomHint(Value: WordBool); safecall;
    procedure Set_ParentDoubleBuffered(Value: WordBool); safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    procedure Set_PopupMode(Value: TxPopupMode); safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    procedure Set_ScreenSnap(Value: WordBool); safecall;
    procedure Set_SnapBuffer(Value: Integer); safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
  public
    { Public declarations }
    procedure Initialize; override;
  end;

implementation

uses ComObj, ComServ;

{$R *.DFM}

{ TMainPage }

procedure TMainPage.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_MainPagePage); }
end;

procedure TMainPage.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IMainPageEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure TMainPage.Initialize;
begin
  inherited Initialize;
  OnActivate := ActivateEvent;
  OnAfterMonitorDpiChanged := AfterMonitorDpiChangedEvent;
  OnBeforeMonitorDpiChanged := BeforeMonitorDpiChangedEvent;
  OnClick := ClickEvent;
  OnCreate := CreateEvent;
  OnDblClick := DblClickEvent;
  OnDeactivate := DeactivateEvent;
  OnDestroy := DestroyEvent;
  OnKeyPress := KeyPressEvent;
  OnMouseEnter := MouseEnterEvent;
  OnMouseLeave := MouseLeaveEvent;
  OnPaint := PaintEvent;
end;

function TMainPage.Get_Active: WordBool;
begin
  Result := Active;
end;

function TMainPage.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function TMainPage.Get_AlignWithMargins: WordBool;
begin
  Result := AlignWithMargins;
end;

function TMainPage.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TMainPage.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TMainPage.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TMainPage.Get_BorderWidth: Integer;
begin
  Result := Integer(BorderWidth);
end;

function TMainPage.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TMainPage.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TMainPage.Get_DockSite: WordBool;
begin
  Result := DockSite;
end;

function TMainPage.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TMainPage.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TMainPage.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TMainPage.Get_ExplicitHeight: Integer;
begin
  Result := ExplicitHeight;
end;

function TMainPage.Get_ExplicitLeft: Integer;
begin
  Result := ExplicitLeft;
end;

function TMainPage.Get_ExplicitTop: Integer;
begin
  Result := ExplicitTop;
end;

function TMainPage.Get_ExplicitWidth: Integer;
begin
  Result := ExplicitWidth;
end;

function TMainPage.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TMainPage.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TMainPage.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TMainPage.Get_MouseInClient: WordBool;
begin
  Result := MouseInClient;
end;

function TMainPage.Get_ParentCustomHint: WordBool;
begin
  Result := ParentCustomHint;
end;

function TMainPage.Get_ParentDoubleBuffered: WordBool;
begin
  Result := ParentDoubleBuffered;
end;

function TMainPage.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TMainPage.Get_PopupMode: TxPopupMode;
begin
  Result := Ord(PopupMode);
end;

function TMainPage.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TMainPage.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function TMainPage.Get_ScreenSnap: WordBool;
begin
  Result := ScreenSnap;
end;

function TMainPage.Get_SnapBuffer: Integer;
begin
  Result := SnapBuffer;
end;

function TMainPage.Get_UseDockManager: WordBool;
begin
  Result := UseDockManager;
end;

function TMainPage.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TMainPage.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure TMainPage._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TMainPage.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TMainPage.AfterMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);

begin
  if FEvents <> nil then FEvents.OnAfterMonitorDpiChanged(OldDPI, NewDPI);
end;

procedure TMainPage.BeforeMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);

begin
  if FEvents <> nil then FEvents.OnBeforeMonitorDpiChanged(OldDPI, NewDPI);
end;

procedure TMainPage.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TMainPage.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TMainPage.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TMainPage.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure TMainPage.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TMainPage.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TMainPage.MouseEnterEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnMouseEnter;
end;

procedure TMainPage.MouseLeaveEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnMouseLeave;
end;

procedure TMainPage.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure TMainPage.Set_AlignWithMargins(Value: WordBool);
begin
  AlignWithMargins := Value;
end;

procedure TMainPage.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TMainPage.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TMainPage.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TMainPage.Set_BorderWidth(Value: Integer);
begin
  BorderWidth := TBorderWidth(Value);
end;

procedure TMainPage.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TMainPage.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TMainPage.Set_DockSite(Value: WordBool);
begin
  DockSite := Value;
end;

procedure TMainPage.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TMainPage.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TMainPage.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TMainPage.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TMainPage.Set_HelpFile(const Value: WideString);
begin
  HelpFile := string(Value);
end;

procedure TMainPage.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TMainPage.Set_ParentCustomHint(Value: WordBool);
begin
  ParentCustomHint := Value;
end;

procedure TMainPage.Set_ParentDoubleBuffered(Value: WordBool);
begin
  ParentDoubleBuffered := Value;
end;

procedure TMainPage.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TMainPage.Set_PopupMode(Value: TxPopupMode);
begin
  PopupMode := TPopupMode(Value);
end;

procedure TMainPage.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TMainPage.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure TMainPage.Set_ScreenSnap(Value: WordBool);
begin
  ScreenSnap := Value;
end;

procedure TMainPage.Set_SnapBuffer(Value: Integer);
begin
  SnapBuffer := Value;
end;

procedure TMainPage.Set_UseDockManager(Value: WordBool);
begin
  UseDockManager := Value;
end;

procedure TMainPage.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TMainPage,
    Class_MainPage,
    0,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
end.
