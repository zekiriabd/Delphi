unit Grid.Settings;

interface

uses
  WEBLib.DBCtrls,
  XData.Web.Dataset;

type
  TOrderInfo = record
    FieldName: string;
    Ascending: Boolean;
  end;
  TSortedItems = array of TOrderInfo;

  TGridSettings = class
  private
    FGrid: TWebDBTableControl;
    FSortedItems: TSortedItems;
    FFilterText: string;
  public
    constructor Create(AGrid: TWebDBTableControl; ASortedItems: TSortedItems;
      AFilterText: string);
    destructor Destroy; override;
    property Grid: TWebDBTableControl read FGrid;
    property SortedItems: TSortedItems read FSortedItems;
    property FilterText: string read FFilterText;
  end;

implementation

{ TGridSettings }

constructor TGridSettings.Create(AGrid: TWebDBTableControl; ASortedItems: TSortedItems;
  AFilterText: string);
begin
  FGrid := AGrid;
  FSortedItems := ASortedItems;
  FFilterText := AFilterText;
end;

destructor TGridSettings.Destroy;
begin
  inherited;
end;

end.
