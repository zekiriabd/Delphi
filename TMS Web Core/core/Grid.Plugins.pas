unit Grid.Plugins;

interface

uses
  SysUtils, Math, DB, Web, JS,

  WEBLib.StdCtrls, WEBLib.DBCtrls, WEBLib.Grids, WEBLib.Lists,

  XData.Web.Dataset,

  Grid.Settings,
  Dataset.Plugins,
  Paginator.Plugins;

type
  TDBTableControl = TWebDBTableControl;
  TListControl = TWebListControl;
  TLabel = TWebLabel;

  TGridPlugin = class
  const
    SORTING_CLASS = 'sorting';
    SORTING_ASC_CLASS = 'sorting_asc';
    SORTING_DESC_CLASS = 'sorting_desc';
  private
    FGrid: TWebDBTableControl;
    FDatasetPlugin: TDatasetPlugin;
    FPaginatorPlugin: TPaginatorPlugin;
    FPaginationInfo: TLabel;
    FSortedItems: TSortedItems;
    FSortingChanged: Boolean;
    FFilterText: string;
    function IsOrdenableColumn(ACol: integer): Boolean;
    function IsSortedAsc(ACol: integer): Boolean;
    function IsSortedDesc(ACol: integer): Boolean;
    procedure SetOrderIndicator(ACol: integer);
    function GetFieldByColumn(ACol: Integer): TField;
    function GetPageSize: Integer;
    function GetPageNumber: Integer;
    function GetFilterText: string;
    function CreateSettings: TGridSettings;
  private
    FOnGetCellChildren: TGridGetCellChildrenEvent;
    procedure ConfigureHeaderElement(ACol: integer);
    procedure DatasetLoadCallback(ADatasetPlugin: TDatasetPlugin);
    procedure PaginatorItemClickCallback(APaginatorPlugin: TPaginatorPlugin);
    procedure OnGetCellChildren(Sender: TObject;
      ACol, ARow: Integer; AField: TField; AValue: string;
      AElement: TJSHTMLElement);
  public
    constructor Create(AGrid: TDBTableControl; ADataset: TXDataWebDataSet;
      APaginator: TListControl; APaginationInfo: TLabel);
    destructor Destroy; override;
    procedure Load;
    procedure NextPage;
    procedure PreviousPage;
    procedure SetPageSize(APageSize: Integer; AutoReload: Boolean = False);
    procedure SetFilterText(AFilterText: string; AutoReload: Boolean = False);
    function IsLastPage: Boolean;
    property SortedItems: TSortedItems read FSortedItems;
    property FilterText: string read GetFilterText;
    property PageSize: Integer read GetPageSize;
    property PageNumber: Integer read GetPageNumber;
  end;

implementation

{ TGridPlugin }

constructor TGridPlugin.Create(AGrid: TDBTableControl; ADataset: TXDataWebDataSet;
  APaginator: TListControl; APaginationInfo: TLabel);
begin
  FGrid := AGrid;
  FDatasetPlugin := TDatasetPlugin.Create(ADataset, @DatasetLoadCallback);
  FPaginatorPlugin := TPaginatorPlugin.Create(APaginator, @PaginatorItemClickCallback);
  FPaginationInfo := APaginationInfo;
  SetFilterText('');

  FOnGetCellChildren := FGrid.OnGetCellChildren;
  FGrid.OnGetCellChildren := @OnGetCellChildren;

  FSortingChanged := False;
  SetLength(FSortedItems, 0);
end;

function TGridPlugin.CreateSettings: TGridSettings;
begin
  Result := TGridSettings.Create(FGrid, SortedItems, FilterText);
end;

procedure TGridPlugin.DatasetLoadCallback(ADatasetPlugin: TDatasetPlugin);
var
  lPageCount: integer;
  lPageSize: integer;
  lPageNumber: integer;
  lServerRecordCount: integer;
  lFirstRecordOfPage: integer;
  lLastRecordOfPage: integer;
begin
  lPageSize := ADatasetPlugin.PageSize;
  lPageNumber := ADatasetPlugin.PageNumber;
  lServerRecordCount := ADatasetPlugin.ServerRecordCount;

  lPageCount := lServerRecordCount div lPageSize;
  if (lServerRecordCount mod lPageSize) > 0 then
    Inc(lPageCount);
  FPaginatorPlugin.Init(lPageNumber, lPageCount);

  lFirstRecordOfPage := Min(
    ((lPageNumber - 1) * lPageSize) + 1,
    lServerRecordCount
  );

  lLastRecordOfPage := Min(
    lPageNumber * lPageSize,
    lServerRecordCount
  );

  FPaginationInfo.Caption := Format('Showing %d to %d of %d entries', [
    lFirstRecordOfPage, lLastRecordOfPage, lServerRecordCount
  ]);
end;

destructor TGridPlugin.Destroy;
begin
  FPaginatorPlugin.Free;
  FDatasetPlugin.Free;
  inherited;
end;

function TGridPlugin.GetFieldByColumn(ACol: Integer): TField;
var
  DataField: string;
begin
  DataField := FGrid.Columns[ACol].DataField;
  if (DataField = '') then
    Exit(nil);
  if FGrid.DataSource = nil then
    Exit(nil);
  if FGrid.DataSource.DataSet = nil then
    Exit(nil);
  Result := FGrid.DataSource.DataSet.FieldByName(DataField);
end;

function TGridPlugin.GetFilterText: string;
begin
  Result := FFilterText;
end;

function TGridPlugin.GetPageNumber: Integer;
begin
  Result := FDatasetPlugin.PageNumber;
end;

function TGridPlugin.GetPageSize: Integer;
begin
  Result := FDatasetPlugin.PageSize;
end;

function TGridPlugin.IsLastPage: Boolean;
begin
  Result := FDatasetPlugin.IsLastPage;
end;

function TGridPlugin.IsOrdenableColumn(ACol: integer): Boolean;
var
  DataField: string;
  Field: TField;
begin
  DataField := FGrid.Columns[ACol].DataField;
  if (DataField = '') then
    Exit(False);
  if FGrid.DataSource = nil then
    Exit(False);
  if FGrid.DataSource.DataSet = nil then
    Exit(False);
  Field := FGrid.DataSource.DataSet.FieldByName(DataField);
  if Field = nil then
    Exit(False);
  Result := True;
end;

function TGridPlugin.IsSortedAsc(ACol: integer): Boolean;
var
  OrderInfo: TOrderInfo;
  I: integer;
  Items: TSortedItems;
begin
  Result := False;
  Items := FSortedItems;
  for I := 0 to Length(Items) - 1 do
  begin
    OrderInfo := Items[I];
    Result := (OrderInfo.FieldName = GetFieldByColumn(ACol).FieldName) and
              OrderInfo.Ascending;
    if Result then
      Break;
  end;
end;

function TGridPlugin.IsSortedDesc(ACol: integer): Boolean;
var
  OrderInfo: TOrderInfo;
  I: integer;
  Items: TSortedItems;
begin
  Result := False;
  Items := FSortedItems;
  for I := 0 to Length(Items) - 1 do
  begin
    OrderInfo := Items[I];
    Result := (OrderInfo.FieldName = GetFieldByColumn(ACol).FieldName) and
              (not OrderInfo.Ascending);
    if Result then
      Break;
  end;
end;

procedure TGridPlugin.Load;
var
  Settings: TGridSettings;
begin
  Settings := CreateSettings;
  try
    FDatasetPlugin.LoadDataset(Settings);
  finally
    Settings.Free;
  end;
end;

procedure TGridPlugin.NextPage;
begin
  if FDatasetPlugin.NextPage then
    Load;
end;

procedure TGridPlugin.OnGetCellChildren(Sender: TObject; ACol, ARow: Integer;
  AField: TField; AValue: string; AElement: TJSHTMLElement);
begin
  if ARow = 0 then
    ConfigureHeaderElement(ACol);

  if Assigned(FOnGetCellChildren) then
    FOnGetCellChildren(Sender, ACol, ARow, AField, AValue, AElement);
end;

procedure TGridPlugin.PaginatorItemClickCallback(
  APaginatorPlugin: TPaginatorPlugin);
begin
  if APaginatorPlugin.ActivePage <> FDatasetPlugin.PageNumber then
  begin
    FDatasetPlugin.PageNumber := APaginatorPlugin.ActivePage;
    Load;
  end;
end;

procedure TGridPlugin.PreviousPage;
begin
  if FDatasetPlugin.PreviousPage then
    Load;
end;

procedure TGridPlugin.SetFilterText(AFilterText: string; AutoReload: boolean);
begin
  FFilterText := AFilterText;
  if FDatasetPlugin.PageSize > 0 then
    FDatasetPlugin.PageNumber := 1;
  if AutoReload then
    Load;
end;

procedure TGridPlugin.SetOrderIndicator(ACol: integer);
var
  Element: TJSElement;
begin
  Element := FGrid.CellElements[ACol, 0];
  if Element = nil then
    Exit;
  if IsSortedAsc(ACol) then
  begin
    Element.classList.remove(SORTING_CLASS);
    Element.classList.remove(SORTING_DESC_CLASS);
    if not Element.classList.contains(SORTING_ASC_CLASS) then
      Element.classList.add(SORTING_ASC_CLASS);
  end
  else if IsSortedDesc(ACol) then
  begin
    Element.classList.remove(SORTING_CLASS);
    Element.classList.remove(SORTING_ASC_CLASS);
    if not Element.classList.contains(SORTING_DESC_CLASS) then
      Element.classList.add(SORTING_DESC_CLASS);
  end
  else
  begin
    Element.classList.remove(SORTING_ASC_CLASS);
    Element.classList.remove(SORTING_DESC_CLASS);
    if not Element.classList.contains(SORTING_CLASS) then
      Element.classList.add(SORTING_CLASS);
  end;
end;

procedure TGridPlugin.ConfigureHeaderElement(ACol: integer);
var
  Element: TJSHTMLElement;

  function HeaderClick(Event: TJSMouseEvent): boolean;
  begin
    SetLength(FSortedItems, 1);
    FSortedItems[0].Ascending := not IsSortedAsc(ACol);
    FSortedItems[0].FieldName := GetFieldByColumn(ACol).FieldName;
    FSortingChanged := True;

    SetOrderIndicator(ACol);

    Load;
    Result := True;
  end;

begin
  if IsOrdenableColumn(ACol) then
  begin
    Element := FGrid.CellElements[ACol, 0];

    if Element = nil then
      Exit;

    Element.onclick := @HeaderClick;
    Element.style.setProperty('cursor', 'pointer');

    SetOrderIndicator(ACol);
  end;

end;

procedure TGridPlugin.SetPageSize(APageSize: Integer; AutoReload: boolean);
begin
  FDatasetPlugin.PageSize := APageSize;
  if AutoReload then
    Load;
end;

end.
