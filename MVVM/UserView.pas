unit UserView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, Data.Bind.Components,
  Data.Bind.ObjectScope, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Math.Vectors, FMX.Styles.Objects,
  FMX.Controls3D, FMX.Layers3D, FMX.StdCtrls,
  UserViewModel;
type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Circle1: TCircle;
    Button1: TButton;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkPropertyToFieldFillBitmapBitmap: TLinkPropertyToField;
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  user : TUserViewModel;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
begin
   user.Update();
end;

procedure TForm2.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
   user := TUserViewModel.Create();
  ABindSourceAdapter :=
  TObjectBindSourceAdapter<TUserViewModel>.Create(self,user,True);
end;

end.
