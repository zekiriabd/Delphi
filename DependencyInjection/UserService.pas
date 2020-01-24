unit UserService;

interface
uses  System.SysUtils,UserDao;

type

 TUserService = class
  private
  oUserDao : IUserDao;
  public
    Constructor Create(userDao : TUserDao);
    function getFullName():string;
  end;

implementation

{ TUserService }

constructor TUserService.Create(userDao : TUserDao);
begin
   self.oUserDao := userDao;
end;

function TUserService.getFullName: string;
begin
     var userinfo := self.oUserDao.getDbUser();
     Result   := userinfo[0] + ' _ ' + userinfo[1];
end;

end.
