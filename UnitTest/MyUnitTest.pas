unit MyUnitTest;

interface

type
TmyUnitTest = class
    public
    class function Test1(name:string):Boolean;
end;


implementation

{ TmyUnitTest }

class function TmyUnitTest.Test1(name: string): Boolean;
begin
    Result:=length(name) = 6;
end;

end.
