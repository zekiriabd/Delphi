unit Paginator.Plugins;

interface

uses
  SysUtils, WEBLib.Lists,

  Dataset.Plugins;

type
  TPaginatorPlugin = class;

  TOnItemClick = reference to procedure(APaginatorPlugin: TPaginatorPlugin);

  TPaginatorPlugin = class
  const
    VISIBLE_PAGES = 7;
    ITEM_CLASS_NAME = 'pagination_button';
    NEXT_TEXT = 'Next';
    PREVIOUS_TEXT = 'Previous';
  strict private
    FPaginator: TWebListControl;
    FActivePage: integer;
    function CreateItem: TListItem;
    procedure InitPaginator(AActivePage: Integer; APageCount: Integer;
      AVisiblePages: integer);
    function GetActivePage: integer;
  private
    FOnItemClick: TOnItemClick;
    FOriginalOnItemClick: TListItemEvent;
    procedure InternalItemClick(Sender: TObject; AListItem: TListItem);
  public
    constructor Create(APaginator: TWebListControl;
      AItemClickCallback: TOnItemClick);
    procedure Init(AActivePage: Integer; APageCount: Integer);
    property ActivePage: Integer read GetActivePage;
  end;

implementation

{ TPaginatorPlugin }

constructor TPaginatorPlugin.Create(APaginator: TWebListControl;
  AItemClickCallback: TOnItemClick);
begin
  FPaginator := APaginator;
  FOnItemClick := AItemClickCallback;
  FOriginalOnItemClick := APaginator.OnItemClick;
  APaginator.OnItemClick := InternalItemClick;
end;

function TPaginatorPlugin.CreateItem: TListItem;
begin
  Result := FPaginator.Items.Add;
  Result.ItemClassName := ITEM_CLASS_NAME;
end;

function TPaginatorPlugin.GetActivePage: integer;
begin
  Result := FActivePage;
end;

procedure TPaginatorPlugin.Init(AActivePage, APageCount: Integer);
begin
  FActivePage := AActivePage;
  InitPaginator(FActivePage, APageCount, VISIBLE_PAGES);
end;

procedure TPaginatorPlugin.InitPaginator(AActivePage, APageCount,
  AVisiblePages: integer);
var
  Item: TListItem;
  I, ButtonNumber, Idx: integer;
  HasLeftSeparator: Boolean;
  HasRightSeparator: Boolean;
begin
  FPaginator.Items.Clear;

  HasLeftSeparator := (AVisiblePages < APageCount) and (AActivePage > AVisiblePages - 2);
  HasRightSeparator := (AVisiblePages < APageCount) and (AActivePage < APageCount - AVisiblePages + 3);

  // Previous
  Item := CreateItem;
  Item.Enabled := AActivePage > 1;
  Item.Text := PREVIOUS_TEXT;

  // first page
  ButtonNumber := 1;
  Item := CreateItem;
  Item.Active := AActivePage = 1;
  Item.Text := IntToStr(ButtonNumber);

  if HasLeftSeparator then
  begin
    Item := CreateItem;
    Item.Active := False;
    Item.Enabled := False;
    Item.Text := '...';
  end;

  if HasRightSeparator and HasLeftSeparator then
  begin
    Idx := (AVisiblePages - 2) div 2;
    for I := AActivePage - Idx to AActivePage + Idx do
    begin
      ButtonNumber := I;
      Item := CreateItem;
      Item.Active := ButtonNumber = AActivePage;
      Item.Text := IntToStr(ButtonNumber);
    end;
  end
  else
    for I := 2 to AVisiblePages - 1 do
    begin
      if I > APageCount - 1 then
        Break;

      ButtonNumber := I;
      if (not HasRightSeparator) and HasLeftSeparator then
        ButtonNumber := APageCount - AVisiblePages + I;

      Item := CreateItem;
      Item.Active := ButtonNumber = AActivePage;
      Item.Text := IntToStr(ButtonNumber);
    end;

  if APageCount > 1 then
  begin
    // last page
    if HasRightSeparator then
    begin
      Item := CreateItem;
      Item.Active := False;
      Item.Enabled := False;
      Item.Text := '...';
    end;
    ButtonNumber := APageCount;
    Item := CreateItem;
    Item.Active := AActivePage = APageCount;
    Item.Text := IntToStr(ButtonNumber);
  end;

  // Next
  Item := CreateItem;
  Item.Enabled := AActivePage < APageCount;
  Item.Text := NEXT_TEXT;
end;

procedure TPaginatorPlugin.InternalItemClick(Sender: TObject;
  AListItem: TListItem);
var
  ActivePage: integer;
begin
  if not AListItem.Enabled then Exit;

  ActivePage := FActivePage;
  if AListItem.Text = PREVIOUS_TEXT then
    Dec(ActivePage)
  else if AListItem.Text = NEXT_TEXT then
    Inc(ActivePage)
  else
    TryStrToInt(AListItem.Text, ActivePage);

  if ActivePage <> FActivePage then
  begin
    FActivePage := ActivePage;
    if Assigned(FOnItemClick) then
      FOnItemClick(Self);
    if Assigned(FOriginalOnItemClick) then
      FOriginalOnItemClick(Sender, AListItem);
  end;
end;

end.
