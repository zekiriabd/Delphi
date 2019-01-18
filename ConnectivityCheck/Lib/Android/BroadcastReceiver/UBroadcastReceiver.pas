{****************************************************}
{                                                    }
{ firemonkey-network-state                           }
{                                                    }
{ Copyright (C) 2018 Code Partners Pty Ltd           }
{                                                    }
{ http://www.code-partners.com                       }
{                                                    }
{****************************************************}
{                                                    }
{ This Source Code Form is subject to the terms of   }
{ the Mozilla Public License, v. 2.0. If a copy of   }
{ the MPL was not distributed with this file, You    }
{ can obtain one at                                  }
{                                                    }
{ http://mozilla.org/MPL/2.0/                        }
{                                                    }
{****************************************************}
unit UBroadcastReceiver;

interface

{$IFDEF ANDROID}
uses
  System.SysUtils, System.Classes, Androidapi.JNIBridge, Androidapi.JNI.Embarcadero,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.JavaTypes, Androidapi.helpers;

type
  // based on https://github.com/ashumkin/Delphi-Android-BroadcastSample

  TDataReceivedEvent = procedure (Sender: TObject; Data: string) of object;

  TBroadcastReceiver = class;

  TListener = class(TJavaLocal, JFMXBroadcastReceiverListener)
  private
    fOwner: TBroadcastReceiver;
    fReceiver: JFMXBroadcastReceiver;
  public
    constructor Create(aOwner: TBroadcastReceiver);
    destructor Destroy; override;
    procedure onReceive(context: JContext; intent: JIntent); cdecl;
  end;

  TOnReceive = procedure (aContext: JContext; aIntent: JIntent; aResultCode: integer) of object;

  TBroadcastReceiver = class (TComponent)
  private
    fListener : TListener;
    fRegistered: boolean;
    fOnReceive: TOnReceive;
  protected
    procedure DoReceiveBroadcast(AContext: JContext; AIntent: JIntent; AResultCode: integer); virtual;
  public
    constructor Create(AOwner: TComponent; aOnReceiveProc: TOnReceive); reintroduce;
    destructor Destroy; override;
    procedure AddActions(const Args: array of JString);
  end;
{$ENDIF}

implementation

{ TBroadcastReceiver }

{$IFDEF ANDROID}
constructor TBroadcastReceiver.Create(AOwner: TComponent; aOnReceiveProc: TOnReceive);
begin
  inherited Create(AOwner);
  fListener := TListener.Create(Self);
  fOnReceive := aOnReceiveProc;
end;

destructor TBroadcastReceiver.Destroy;
begin
  fListener.Free;
  inherited;
end;

procedure TBroadcastReceiver.AddActions(const Args: array of JString);
var
  vFilter: JIntentFilter;
  i: Integer;
begin
  if fRegistered then
    TAndroidHelper.context.getApplicationContext.UnregisterReceiver(fListener.fReceiver);

  vFilter := TJIntentFilter.JavaClass.init;
  for i := 0 to High(Args) do
    vFilter.addAction(Args[i]);

  TAndroidHelper.context.getApplicationContext.registerReceiver(fListener.fReceiver, vFilter);
  fRegistered := true;
end;

//

procedure TBroadcastReceiver.DoReceiveBroadcast(AContext: JContext; AIntent: JIntent; AResultCode: integer);
begin
  //
end;

{ TListener }

constructor TListener.Create(aOwner: TBroadcastReceiver);
begin
  inherited Create;
  fOwner := aOwner;
  fReceiver := TJFMXBroadcastReceiver.JavaClass.init(Self);
end;

destructor TListener.Destroy;
begin
  TAndroidHelper.context.getApplicationContext.unregisterReceiver(fReceiver);
  inherited;
end;

// usually android call it from "UI thread" - it's not main Delphi thread
procedure TListener.onReceive(context: JContext; intent: JIntent);
begin
  if Assigned(fOwner.fOnReceive) then
    fOwner.fOnReceive(Context, Intent, fReceiver.getResultCode);
end;
{$ENDIF}

end.



