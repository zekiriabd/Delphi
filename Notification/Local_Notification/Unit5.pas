unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Notification, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    NotificationCenter1: TNotificationCenter;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation
    uses
    FMX.Platform;
{$R *.fmx}

procedure TForm5.Button1Click(Sender: TObject);
var
  MyNot : TNotification;
begin

Try
  MyNot := NotificationCenter1.CreateNotification();
  MyNot.Name := 'MyNot';
  MyNot.Title:= 'عنوان الرسالة';
  MyNot.AlertBody:= 'موضوع الرسالة';
  NotificationCenter1.PresentNotification(MyNot);
Finally
  MyNot.DisposeOf;
End;





end;
end.
