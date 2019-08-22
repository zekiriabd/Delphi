unit s;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TMyTestObject = class(TObject)

  public
    [Test]
    [TestCase('TEST AAA 1111','Zekir')]
     procedure Test1(const name:string);

    [Test]
    [TestCase('1111111','10,2')]
    [TestCase('222222','2,2')]
    procedure Test2(const p1 : Integer;const p2 : Integer);

  end;

implementation

procedure TMyTestObject.Test1(const name: string);
begin
   Assert.
end;

procedure TMyTestObject.Test2(const p1 : Integer;const p2 : Integer);
var calc :real;
begin
    calc := p1 * p2 ;
    Assert.AreEqual<real>(20,calc);
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);
end.
