unit App.Types;

interface

type
  TProc = reference to procedure;

  TSuccessProc = reference to procedure;
  TLogoutProc = reference to procedure(AMessage: string = '');
  TUnauthorizedAccessProc = reference to procedure(AMessage: string);

  TListProc = reference to procedure;
  TEditProc = reference to procedure(AId: JSValue);

implementation


end.
