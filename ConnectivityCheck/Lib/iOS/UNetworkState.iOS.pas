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
unit UNetworkState.iOS;

interface

{$IFDEF IOS}
uses
  System.SysUtils, System.Classes, UNetworkState, Macapi.ObjectiveC,
  Macapi.CoreFoundation, iOSApi.CocoaTypes, iOSApi.Foundation,
  Macapi.ObjCRuntime, Macapi.Helpers
  // linker will fail without these two files
  , SCNetworkReachability, CaptiveNetwork;

type
  SCNetworkReachabilityFlags = UInt32;

  TReachability = class;

  Reachability = interface(NSObject)
    ['{B405394F-57B1-4FF1-83D9-8FBFA38FFD7B}']
    function startNotifier: LongBool; cdecl;
    procedure stopNotifier; cdecl;
    function isReachable: LongBool; cdecl;
    function isReachableViaWWAN: LongBool; cdecl;
    function isReachableViaWiFi: LongBool; cdecl;
    function isConnectionRequired: LongBool; cdecl;
    function connectionRequired: LongBool; cdecl;
    function isConnectionOnDemand: LongBool; cdecl;
    function isInterventionRequired: LongBool; cdecl;
    function currentReachabilityStatus: NSInteger; cdecl;
    function reachabilityFlags: SCNetworkReachabilityFlags; cdecl;
    function currentReachabilityString: NSString; cdecl;
    function currentReachabilityFlags: NSString; cdecl;
  end;

  ReachabilityClass = interface(NSObjectClass)
    ['{39EC0490-2787-4BB9-95EA-77BB885BFD01}']
    function reachabilityWithHostname(hostname: NSString): pointer; cdecl;
    function reachabilityForInternetConnection: pointer; cdecl;
    function reachabilityWithAddress: pointer; cdecl;
    function reachabilityForLocalWiFi: pointer; cdecl;
  end;

  TReachability = class(TOCGenericImport<ReachabilityClass, Reachability>)
  end;

  INetworkChangeDelegate = interface(IObjectiveC)
    ['{BC4EABBE-F21F-4592-93B0-0C40415E4A91}']
    procedure handleNetworkChange(notice: NSNotification); cdecl;
  end;

  TiOSNetworkState = class;

  TNetworkChangeDelegate = class (TOCLocal, INetworkChangeDelegate)
  private
    FNetworkState: TiOSNetworkState;
  public
    constructor Create(ANetworkState: TiOSNetworkState);

    //  (void) handleNetworkChange:(NSNotification *)notice
    procedure handleNetworkChange(notice: NSNotification); cdecl;
  end;

  TiOSNetworkState = class (TNetworkState)
  private
    FReachability: Reachability;
    FDelegate: TNetworkChangeDelegate;
  protected
    function GetCurrentValue: TNetworkStateValue; override;
  public
    constructor Create(AOwner: TComponent;
      AOnChange: TNetworkStateChangeEvent); reintroduce; override;
  end;

{$IFDEF CPUARM}
  {$IF DEFINED(IOS32)}
    function FakeLoader: Reachability; cdecl; external 'libReachability.a' name 'OBJC_CLASS_$_Reachability';
  {$ELSEIF DEFINED(IOS64)}
    function FakeLoader: Reachability; cdecl; external 'libReachability64.a' name 'OBJC_CLASS_$_Reachability';
  {$ENDIF}
{$ENDIF}

{$ENDIF}

implementation

{$IFDEF IOS}

{ TiOSNetworkState }

constructor TiOSNetworkState.Create(AOwner: TComponent;
  AOnChange: TNetworkStateChangeEvent);
begin
  FDelegate := TNetworkChangeDelegate.Create(self);

  TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter).addObserver(
    FDelegate.GetObjectID,
    sel_getUid('handleNetworkChange:'),
    StringToID('kReachabilityChangedNotification'),
    nil
  );

  FReachability := TReachability.Wrap(TReachability.OCClass.reachabilityForInternetConnection);
  FReachability.startNotifier;

  inherited;
end;

function TiOSNetworkState.GetCurrentValue: TNetworkStateValue;
var
  Status: integer;
begin
  Status := self.FReachability.currentReachabilityStatus;

  // 0 - disconnected, 1 - reachable via wifi, 2 - reachable via wwan
  if (Status = 0) then
    Result := nsDisconnected
  else if (Status = 2) then
    Result := nsConnectedWifi
  else
    Result := nsConnectedMobileData;
end;

{ TNetworkChangeDelegate }

constructor TNetworkChangeDelegate.Create(ANetworkState: TiOSNetworkState);
begin
  inherited Create;
  self.FNetworkState := ANetworkState;
end;

procedure TNetworkChangeDelegate.handleNetworkChange(notice: NSNotification);
begin
  TThread.Synchronize(
    nil,
    procedure
    begin
      self.FNetworkState.DoOnChange;
    end
  );
end;

{$ENDIF}

initialization

end.
