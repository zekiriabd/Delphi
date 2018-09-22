unit Player;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media, FMX.Controls.Presentation,
  FMX.StdCtrls, system.iOUtils, FMX.Ani, FMX.Effects;

type
  TfrmMain = class(TForm)
    btnPlay: TButton;
    procedure btnPlayClick(Sender: TObject);


  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}



procedure TfrmMain.btnPlayClick(Sender: TObject);
var
  mPlayer:TMediaPlayer;
  path: string;
begin

  //For Android, set the Remote Path to .\assets\internal
  //For iOS, set the Remote Path to StartUp\Documents

  {$IFDEF MSWINDOWS}
    path := ExpandFileName(GetCurrentDir) + '\Sample.mp3';
  {$ELSE}
    path := TPath.GetDocumentsPath + PathDelim + 'Sample.mp3';
  {$ENDIF}

    showmessage(path);
    mPlayer:= TMediaPlayer.Create(self);
    mPlayer.FileName := path;
    mPlayer.Play;

end;




end.

