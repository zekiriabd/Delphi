unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;




implementation
{$R *.fmx}
uses uClass;

procedure TForm1.Button1Click(Sender: TObject);
var
   MyObject : MyClass;

begin
   try
      MyObject := MyClass.Create();
      Edit1.Text := MyObject.GetName;
   finally
     FreeAndNil(MyObject);
   end;

end;

end.
