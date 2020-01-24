unit UserDao;
interface
uses  System.SysUtils;

type
TUserDao = class
  public
    Constructor Create;
    function getDbUser(): TArray<string>;
  end;

implementation

{ TUserDao }

constructor TUserDao.Create;
begin

end;

function TUserDao.getDbUser: TArray<string>;
begin
    { الاتصال بالقاعدة و جلب البيا نات}
     result:= [ 'Zekiri', 'Abdelali' ];
end;

end.
