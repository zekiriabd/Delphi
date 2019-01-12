unit CaptiveNetwork;

interface

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

implementation

end.
