unit Dataset.Plugins;

interface

uses
  SysUtils, DB,

  JS, WEBLib.DBCtrls,

  XData.Web.Dataset,
  XData.Web.JsonDataset,
  XData.Web.Connection,
  XData.Model.Classes,

  Grid.Settings;

type
  TDatasetPlugin = class;

  TOnLoad = reference to procedure(DatasetPlugin: TDatasetPlugin);

  TDatasetPlugin = class
  strict private
    FDataset: TXDataWebDataSet;
    FOriginalQuery: string;
    FPageSize: integer;
    FPageNumber: integer;
    procedure AddPaginationQueryUrl(Dataset: TXDataWebDataSet; APageNumber: Integer;
      APageSize: integer);
    procedure AddExpandQueryUrl(Dataset: TXDataWebDataSet);
    procedure AddFilterQueryUrl(Dataset: TXDataWebDataSet; AGrid: TWebDBTableControl;
      AFilterText: string);
    procedure AddOrderByQueryUrl(Dataset: TXDataWebDataSet; SortedItems: TSortedItems);
  private
    procedure SetPageSize(const Value: Integer);
    procedure SetPageNumber(const Value: Integer);
    function GetServerRecordCount: Integer;
  private
    // events
    FOnLoad: TOnLoad;
    FOriginalAfterOpen: TDataSetNotifyEvent;
    procedure InternalAfterOpen(ADataset: TDataSet);
  public
    constructor Create(ADataset: TXDataWebDataSet; ALoadCallback: TOnLoad);
    procedure LoadDataset(GridSettings: TGridSettings);
    function IsLastPage: Boolean;
    function PreviousPage: Boolean;
    function NextPage: Boolean;
    property PageSize: Integer read FPageSize write SetPageSize;
    property PageNumber: Integer read FPageNumber write SetPageNumber;
    property ServerRecordCount: Integer read GetServerRecordCount;
  end;

implementation

{ TDatasetPlugin }

procedure TDatasetPlugin.AddPaginationQueryUrl(Dataset: TXDataWebDataSet;
  APageNumber: Integer; APageSize: integer);
begin
  if APageSize = 0 then
    Exit;
  Dataset.QueryTop := APageSize;
  Dataset.QuerySkip := (APageNumber - 1) * APageSize;
end;

procedure TDatasetPlugin.AddExpandQueryUrl(Dataset: TXDataWebDataSet);
var
  Field: TField;
  I: integer;
  QueryUrl, FieldName, ExpandProp: string;
  ExpandProps, rs: TJSArray;
begin
  ExpandProps := TJSArray.new;
  for I := 0 to Dataset.FieldCount - 1 do
  begin
    Field := Dataset.Fields[I];
    if Field is TXDataWebEntityField then
    begin
      FieldName := Field.FieldName;
      ExpandProp := FieldName;
      if not ExpandProps.includes(ExpandProp) then
        ExpandProps.push(ExpandProp);
    end
    else if Pos('.', Field.FieldName) > 0 then
    begin
      FieldName := Field.FieldName;
      rs := TJSArray(TJSString(FieldName).split('.'));
      rs.pop;
      ExpandProp := rs.join('/');
      if not ExpandProps.includes(ExpandProp) then
        ExpandProps.push(ExpandProp);
    end;
  end;

  QueryUrl := ExpandProps.join(',');

  if QueryUrl <> '' then
  begin
    if Dataset.QueryString <> '' then
      Dataset.QueryString := Dataset.QueryString + '&';
    Dataset.QueryString := Dataset.QueryString + '$expand=' + QueryUrl;
  end;
end;

procedure TDatasetPlugin.AddFilterQueryUrl(Dataset: TXDataWebDataSet; AGrid: TWebDBTableControl;
  AFilterText: string);

  function FindPropertyType(AEntityType: TXDataEntityType; AName: string): TXDataType;
  var
    NavProp: TXDataNavigationProperty;
  begin
    if Pos('.', AName) > 0 then
    begin
      NavProp := AEntityType.FindNavigationProperty(TJSString(AName).split('.')[0]);
      Result := FindPropertyType(NavProp.Target, Copy(AName, Pos('.', AName) + 1, Length(AName)));
    end
    else
      Result := AEntityType.FindProperty(AName).PropertyType;
  end;

  function IsNumber(Value: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 1 to Length(Value) do
    begin
      Result := (Value[I] in ['0'..'9']);
      if not Result then
        Exit;
    end;
  end;

var
  QueryUrl: string;
  FilterExpressions: TJSArray;
  Model: TXDataModel;
  EntityType: TXDataEntityType;
  DataField: string;
  Field: TField;
  FieldName: string;
  Prop: TXDataProperty;
  PropType: TXDataType;
  I: integer;
begin
  if  AFilterText = '' then
    Exit;
  Model := Dataset.Connection.Model;
  EntityType := Model.FindEntitySet(Dataset.EntitySetName).EntityType;
  FilterExpressions := TJSArray.new;
  for I := 0 to AGrid.Columns.Count - 1 do
  begin
    DataField := AGrid.Columns[I].DataField;
    if DataField = '' then
      Continue;
    Field := Dataset.FieldByName(DataField);
    if Field = nil then
      Continue;
    FieldName := Field.FieldName;
    if Pos('.', FieldName) = 0 then
      Prop := EntityType.FindProperty(FieldName)
    else
      Prop := EntityType.FindNavigationProperty( TJSString(FieldName).split('.')[0] );
    if Prop = nil then
      Continue;
    PropType := FindPropertyType(EntityType, FieldName);
    if PropType = nil then
      Continue;
    case PropType.TypeKind of
      TXTypeKind.xtInt16, TXTypeKind.xtInt32, TXTypeKind.xtInt64,
      TXTypeKind.xtDouble, TXTypeKind.xtCurrency:
      begin
        if IsNumber(AFilterText) then
          FilterExpressions.push(Format('(%s eq %s)',
            [TJSString(FieldName).replace('.', '/'), AFilterText]));
      end;
      TXTypeKind.xtText:
      begin
        if isString(AFilterText) then
          FilterExpressions.push(Format('(contains(%s, ''%s''))',
            [ TJSString(FieldName).replace('.', '/') , AFilterText]));
      end;
    end;
  end;

  if FilterExpressions.Length > 0 then
  begin
    QueryUrl := '$filter=' + FilterExpressions.join(' or ');
    if Dataset.QueryString <> '' then
      Dataset.QueryString := Dataset.QueryString + '&';
    Dataset.QueryString := Dataset.QueryString + QueryUrl;
  end;
end;

procedure TDatasetPlugin.AddOrderByQueryUrl(Dataset: TXDataWebDataSet; SortedItems: TSortedItems);
var
  I: integer;
  QueryUrl: string;
  OrderInfo: TOrderInfo;
  OrderProps: array of string;
begin
  SetLength(OrderProps, Length(SortedItems));
  for I := 0 to Length(SortedItems) - 1 do
  begin
    OrderInfo := SortedItems[I];
    if OrderInfo.Ascending then
      OrderProps[I] := OrderInfo.FieldName + ' asc'
    else
      OrderProps[I] := OrderInfo.FieldName + ' desc';
    OrderProps[I] := StringReplace(OrderProps[I], '.', '/', [rfReplaceAll]);
  end;

  QueryUrl := TJSArray(OrderProps).join(',');

  if QueryUrl <> '' then
  begin
    if Dataset.QueryString <> '' then
      Dataset.QueryString := Dataset.QueryString + '&';
    Dataset.QueryString := Dataset.QueryString + '$orderby=' + QueryUrl;
  end;
end;

constructor TDatasetPlugin.Create(ADataset: TXDataWebDataSet;
  ALoadCallback: TOnLoad);
begin
  FDataset := ADataset;
  FOriginalQuery := FDataset.QueryString;
  FDataset.ServerRecordCountMode := TServerRecordCountMode.smNone;
  FPageSize := 0;
  FPageNumber := 0;

  FOnLoad := ALoadCallback;
  FOriginalAfterOpen := FDataset.AfterOpen;
  FDataset.AfterOpen := InternalAfterOpen;
end;

function TDatasetPlugin.GetServerRecordCount: Integer;
begin
  Result := FDataset.ServerRecordCount;
end;

procedure TDatasetPlugin.InternalAfterOpen(ADataset: TDataSet);
begin
  try
    if Assigned(FOnLoad) then
      FOnLoad(Self);
    if Assigned(FOriginalAfterOpen) then
      FOriginalAfterOpen(ADataset);
  finally
    FDataset.EnableControls;
  end;
end;

function TDatasetPlugin.IsLastPage: Boolean;
begin
  if PageSize = 0 then
    Result := True
  else
    Result := ( PageNumber * PageSize ) >= FDataset.ServerRecordCount;
end;

procedure TDatasetPlugin.LoadDataset(GridSettings: TGridSettings);
begin
  FDataset.DisableControls;
  try
    FDataSet.Close;
    FDataSet.QueryString := FOriginalQuery;

    AddPaginationQueryUrl(FDataSet, PageNumber, PageSize);
    AddExpandQueryUrl(FDataSet);
    AddFilterQueryUrl(FDataSet, GridSettings.Grid, GridSettings.FilterText);
    AddOrderByQueryUrl(FDataSet, GridSettings.SortedItems);
    FDataSet.QueryString := StringReplace(FDataSet.QueryString, '.', '/', [rfReplaceAll, rfIgnoreCase]);

    FDataSet.Load;
  except
    FDataset.EnableControls;
    raise;
  end;
end;

function TDatasetPlugin.NextPage: Boolean;
begin
  Result := not IsLastPage;
  if Result then
    FPageNumber := FPageNumber + 1;
end;

function TDatasetPlugin.PreviousPage: Boolean;
begin
  Result := False;
  if FPageNumber > 1 then
  begin
    FPageNumber := FPageNumber - 1;
    Result := True;
  end;
end;

procedure TDatasetPlugin.SetPageNumber(const Value: Integer);
begin
  FPageNumber := Value;
  if FPageNumber > 0 then
    FDataset.ServerRecordCountMode := TServerRecordCountMode.smInlineCount
  else
    FDataset.ServerRecordCountMode := TServerRecordCountMode.smNone;
end;

procedure TDatasetPlugin.SetPageSize(const Value: Integer);
begin
  FPageSize := Value;
  if FPageSize > 0 then
  begin
    FPageNumber := 1;
    FDataset.ServerRecordCountMode := TServerRecordCountMode.smInlineCount;
  end
  else
  begin
    FPageNumber := 0;
    FDataset.ServerRecordCountMode := TServerRecordCountMode.smNone;
  end;
end;

end.
