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
unit CaptiveNetwork;

interface

{$IFDEF IOS}
uses
  Macapi.CoreFoundation;

const
  libSystemConfiguration = '/System/Library/Frameworks/SystemConfiguration.framework/SystemConfiguration';

function CNSetSupportedSSIDs(ssidArray: CFArrayRef): Boolean; cdecl;
  external libSystemConfiguration name _PU + 'CNSetSupportedSSIDs';
function CNMarkPortalOnline(interfaceName: CFStringRef): Boolean; cdecl;
  external libSystemConfiguration name _PU + 'CNMarkPortalOnline';
function CNMarkPortalOffline(interfaceName: CFStringRef): Boolean; cdecl;
  external libSystemConfiguration name _PU + 'CNMarkPortalOffline';
function CNCopySupportedInterfaces: CFArrayRef; cdecl;
  external libSystemConfiguration name _PU + 'CNCopySupportedInterfaces';
function CNCopyCurrentNetworkInfo(interfaceName: CFStringRef): CFDictionaryRef; cdecl;
  external libSystemConfiguration name _PU + 'CNCopyCurrentNetworkInfo';
{$ENDIF}

implementation

end.
