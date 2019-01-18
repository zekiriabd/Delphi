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
unit UNetworkState.Android;

interface

{$IFDEF ANDROID}
uses
  System.SysUtils, System.Classes, UNetworkState, UNetworkStateBroadcastReceiver,
  Androidapi.JNIBridge, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes, FMX.Helpers.Android, Androidapi.JNI.Net,
  Androidapi.Helpers;

type
  TAndroidNetworkState = class (TNetworkState)
  private
    FBroadcastReceiver: TNetworkStateBroadcastReceiver;
    FConnectivityManager: JConnectivityManager;

    function GetConnectivityManager: JConnectivityManager;
  protected
    procedure DoOnConnectivityBroadcastAction(Sender: TObject);
    function GetCurrentValue: TNetworkStateValue; override;
  public
    constructor Create(AOwner: TComponent;
      AOnChange: TNetworkStateChangeEvent); reintroduce; override;
  end;
{$ENDIF}

implementation

{$IFDEF ANDROID}

{ TAndroidNetworkState }

constructor TAndroidNetworkState.Create(AOwner: TComponent;
  AOnChange: TNetworkStateChangeEvent);
begin
  self.FConnectivityManager := self.GetConnectivityManager;

  self.FBroadcastReceiver := TNetworkStateBroadcastReceiver.Create(
    self, self.DoOnConnectivityBroadcastAction
  );

  inherited;
end;

function TAndroidNetworkState.GetConnectivityManager: JConnectivityManager;
var
  ConnectivityServiceNative: JObject;
begin
  ConnectivityServiceNative := TAndroidHelper.Context.getSystemService(
    TJContext.JavaClass.CONNECTIVITY_SERVICE
  );

  if not Assigned(ConnectivityServiceNative) then
    raise Exception.Create('Could not locate Connectivity Service');

  Result := TJConnectivityManager.Wrap((ConnectivityServiceNative as ILocalObject).GetObjectID);

  if not Assigned(Result) then
    raise Exception.Create('Could not access Connectivity Manager');
end;

procedure TAndroidNetworkState.DoOnConnectivityBroadcastAction(Sender: TObject);
begin
  self.DoOnChange;
end;

function TAndroidNetworkState.GetCurrentValue: TNetworkStateValue;
var
  ActiveNetwork: JNetworkInfo;
  Connected: boolean;
begin
  ActiveNetwork := self.FConnectivityManager.getActiveNetworkInfo;

  Connected := Assigned(ActiveNetwork) and ActiveNetwork.isConnectedOrConnecting;

  if Connected then begin
    if ActiveNetwork.getType = TJConnectivityManager.JavaClass.TYPE_WIFI then
      Result := nsConnectedWifi
    else
      Result := nsConnectedMobileData;
  end
  else
    Result := nsDisconnected;
end;

{$ENDIF}

end.
