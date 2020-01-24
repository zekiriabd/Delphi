unit Crud.Utils;

interface

uses
  DB,
  JS, Web,
  WEBLib.StdCtrls,
  XData.Web.Dataset,
  XData.Web.JsonDataset,
  XData.Model.Classes;

type
  TComboBox = TWebComboBox;

  TCrudUtils = class
  private
  public
    class procedure PopulateAssociationCombobox(Combobox: TComboBox;
      Dataset: TXDataWebDataSet; DescriptionField: string);
    class procedure SelectAssociationItem(Combobox: TComboBox;
      EntityField: TXDataWebEntityField);
    class procedure LoadAssociationDataset(Dataset: TXDataWebDataSet;
      DescriptionProp: string);
    class function GetIdFromObject(AEntityType: TXDataEntityType; Value: JSValue): JSValue;
    class function GetEntityGetQueryString(AEntityType: TXDataEntityType): string;
  end;

implementation

{ TCrudUtils }

class function TCrudUtils.GetEntityGetQueryString(
  AEntityType: TXDataEntityType): string;
var
  I: Integer;
begin
  for I := 0 to AEntityType.NavigationProperties.Count - 1 do
  begin
    Result := Result + AEntityType.NavigationProperties[I].Name + ',';
  end;
  if AEntityType.NavigationProperties.Count > 0 then
    Result := Copy(Result, 1, Length(Result) - 1);
  Result := '$expand=' + Result;
end;

class function TCrudUtils.GetIdFromObject(AEntityType: TXDataEntityType;
  Value: JSValue): JSValue;
var
  I: integer;
begin
  if (AEntityType = nil) or (AEntityType.Key.Count = 0) then
  begin
    Result := nil;
  end
  else if AEntityType.Key.Count = 1 then
  begin
    Result := TJSObject(Value).Properties[AEntityType.Key[0].Name];
  end
  else
  begin
    Result := TJSArray.new;
    for I := 0 to AEntityType.Key.Count - 1 do
    begin
      if AEntityType.Key[I].IsSimple then
        TJSArray(Result).push(TJSObject(Value).Properties[AEntityType.Key[I].Name])
      else
      begin
        TJSArray(Result).push(
          GetIdFromObject(
            TXDataNavigationProperty(AEntityType.Key[I]).Target,
            TJSObject(Value).Properties[AEntityType.Key[I].Name]
          )
        );
      end;
    end;
  end;
end;

class procedure TCrudUtils.LoadAssociationDataset(Dataset: TXDataWebDataSet;
  DescriptionProp: string);
begin
  Dataset.QueryString := '$orderby=' + DescriptionProp;
  Dataset.Load;
end;

class procedure TCrudUtils.PopulateAssociationCombobox(Combobox: TComboBox;
  Dataset: TXDataWebDataSet; DescriptionField: string);
begin
  Combobox.Items.Clear;
  Dataset.First;
  while not Dataset.Eof do
  begin
    Combobox.Items.AddObject(Dataset.FieldByName(DescriptionField).AsString, TObject(Dataset.CurrentData));
    Dataset.Next;
  end;
end;

class procedure TCrudUtils.SelectAssociationItem(Combobox: TComboBox;
  EntityField: TXDataWebEntityField);
var
  I, J: Integer;
  Dataset: TXDataWebDataSet;
  Container: TXDataEntityContainer;
  EntitySet: TXDataEntitySet;
  Key: TXDataProperty;
  Prop: TXDataProperty;
  KeyValueMatches: Integer;
begin
  Dataset := (EntityField.DataSet as TXDataWebDataSet);
  Container := Dataset.Connection.Model.DefaultEntityContainer;
  EntitySet := Container.FindEntitySet(Dataset.EntitySetName);
  Prop := EntitySet.EntityType.FindProperty(EntityField.FieldName);
  if Prop = nil then
    Prop := EntitySet.EntityType.FindNavigationProperty(EntityField.FieldName);

  for I := 0 to Combobox.Items.Count - 1 do
  begin
    KeyValueMatches := 0;

    for J := 0 to EntitySet.EntityType.Key.Count - 1 do
    begin
      Key := EntitySet.EntityType.Key[J];

      if TJSObject(Combobox.Items.Objects[I]).Properties[Key.Name] = TJSObject(EntityField.Value).Properties[Key.Name] then
        Inc(KeyValueMatches);

      if KeyValueMatches = EntitySet.EntityType.Key.Count then
      begin
        Combobox.ItemIndex := I;
        Exit;
      end;
    end;
  end;
end;

end.
