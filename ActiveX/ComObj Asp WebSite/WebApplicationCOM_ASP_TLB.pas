unit WebApplicationCOM_ASP_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 9/16/2017 2:18:34 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\ActiveX_Test2\WebApplicationCOM_ASP (1)
// LIBID: {373216A5-F6DA-4E13-B097-9DEB670C270F}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  WebApplicationCOM_ASPMajorVersion = 1;
  WebApplicationCOM_ASPMinorVersion = 0;

  LIBID_WebApplicationCOM_ASP: TGUID = '{373216A5-F6DA-4E13-B097-9DEB670C270F}';

  IID_IController: TGUID = '{E7294F9A-DEBC-4A16-8870-7778C745D584}';
  CLASS_Controller: TGUID = '{D860B818-A3FA-4CA5-8569-6FF35C34DE95}';
  IID_IUser: TGUID = '{9B9C5991-8EA9-4326-94A8-0D83ACF20EAF}';
  CLASS_User: TGUID = '{C065F5BC-D4BA-4714-A69E-84063722B679}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IController = interface;
  IControllerDisp = dispinterface;
  IUser = interface;
  IUserDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  Controller = IController;
  User = IUser;


// *********************************************************************//
// Interface: IController
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E7294F9A-DEBC-4A16-8870-7778C745D584}
// *********************************************************************//
  IController = interface(IDispatch)
    ['{E7294F9A-DEBC-4A16-8870-7778C745D584}']
    procedure OnStartPage(const AScriptingContext: IUnknown); safecall;
    procedure OnEndPage; safecall;
    procedure HelloWorld; safecall;
    function GetUsers: OleVariant; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IControllerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E7294F9A-DEBC-4A16-8870-7778C745D584}
// *********************************************************************//
  IControllerDisp = dispinterface
    ['{E7294F9A-DEBC-4A16-8870-7778C745D584}']
    procedure OnStartPage(const AScriptingContext: IUnknown); dispid 201;
    procedure OnEndPage; dispid 202;
    procedure HelloWorld; dispid 203;
    function GetUsers: OleVariant; dispid 204;
  end;

// *********************************************************************//
// Interface: IUser
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9B9C5991-8EA9-4326-94A8-0D83ACF20EAF}
// *********************************************************************//
  IUser = interface(IDispatch)
    ['{9B9C5991-8EA9-4326-94A8-0D83ACF20EAF}']
    function Get_FirstName: OleVariant; safecall;
    procedure Set_FirstName(Value: OleVariant); safecall;
    function Get_LastName: OleVariant; safecall;
    procedure Set_LastName(Value: OleVariant); safecall;
    property FirstName: OleVariant read Get_FirstName write Set_FirstName;
    property LastName: OleVariant read Get_LastName write Set_LastName;
  end;

// *********************************************************************//
// DispIntf:  IUserDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9B9C5991-8EA9-4326-94A8-0D83ACF20EAF}
// *********************************************************************//
  IUserDisp = dispinterface
    ['{9B9C5991-8EA9-4326-94A8-0D83ACF20EAF}']
    property FirstName: OleVariant dispid 203;
    property LastName: OleVariant dispid 204;
  end;

// *********************************************************************//
// The Class CoController provides a Create and CreateRemote method to
// create instances of the default interface IController exposed by
// the CoClass Controller. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoController = class
    class function Create: IController;
    class function CreateRemote(const MachineName: string): IController;
  end;

// *********************************************************************//
// The Class CoUser provides a Create and CreateRemote method to
// create instances of the default interface IUser exposed by
// the CoClass User. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUser = class
    class function Create: IUser;
    class function CreateRemote(const MachineName: string): IUser;
  end;

implementation

uses System.Win.ComObj;

class function CoController.Create: IController;
begin
  Result := CreateComObject(CLASS_Controller) as IController;
end;

class function CoController.CreateRemote(const MachineName: string): IController;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Controller) as IController;
end;

class function CoUser.Create: IUser;
begin
  Result := CreateComObject(CLASS_User) as IUser;
end;

class function CoUser.CreateRemote(const MachineName: string): IUser;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_User) as IUser;
end;

end.

