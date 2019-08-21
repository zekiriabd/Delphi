unit uClass;

interface
uses uInterface;
type

  

   MyClass = class(TInterfacedObject,MyInterface)
   public
    function GetName: string;

   end;

implementation

function MyClass.GetName: string;
begin
  Result := 'Zekiri Abdelali';
end;

end.
