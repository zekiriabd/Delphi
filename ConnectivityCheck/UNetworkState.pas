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
unit UNetworkState;

interface

uses
  System.SysUtils, System.Classes;

type
  TNetworkStateValue = (nsUnknown = 0, nsConnectedWifi = 1, nsConnectedMobileData = 2, nsDisconnected = 3);

  TNetworkStateChangeEvent = procedure (Sender: TObject; Value: TNetworkStateValue) of object;

  TNetworkState = class (TComponent)
  private
    FCurrentValue: TNetworkStateValue;
    FOnChange: TNetworkStateChangeEvent;

  protected
    procedure DoOnChange;
    function GetCurrentValue: TNetworkStateValue; virtual;
    constructor Create(AOwner: TComponent;AOnChange: TNetworkStateChangeEvent); reintroduce; virtual;
  public
    class function Factory(AOwner: TComponent; AOnChange: TNetworkStateChangeEvent): TNetworkState;
    property CurrentValue: TNetworkStateValue read FCurrentValue;
  end;

implementation

uses
  {$IF DEFINED(Android)}
    UNetworkState.Android;
  {$ELSEIF DEFINED(iOS)}
    UNetworkState.iOS;
  {$IFEND}

{ TNetworkState }

constructor TNetworkState.Create(AOwner: TComponent;
  AOnChange: TNetworkStateChangeEvent);
begin
  inherited Create(AOwner);
  self.FOnChange := AOnChange;

  self.FCurrentValue := self.GetCurrentValue;
end;

class function TNetworkState.Factory(AOwner: TComponent;AOnChange: TNetworkStateChangeEvent): TNetworkState;
begin
  {$IF DEFINED(Android)}
    Result := TAndroidNetworkState.Create(AOwner, AOnChange);
    {$ELSEIF DEFINED(iOS)}
      {$IF DEFINED(CPUARM)} // real device
        Result := TiOSNetworkState.Create(AOwner, AOnChange);
      {$ELSEIF DEFINED(CPUX86)} // simulator
      Result := TNetworkState.Create(AOwner, AOnChange);
    {$ENDIF}
  {$ENDIF}
end;

function TNetworkState.GetCurrentValue: TNetworkStateValue;
begin
  Result := nsUnknown;
end;

procedure TNetworkState.DoOnChange;
var
  NewValue: TNetworkStateValue;
begin
  NewValue := self.GetCurrentValue;
  if (self.FCurrentValue <> NewValue) then
  begin
    self.FCurrentValue := NewValue;
    if Assigned(self.FOnChange) then
       self.FOnChange(self, self.FCurrentValue);
  end;
end;


end.
