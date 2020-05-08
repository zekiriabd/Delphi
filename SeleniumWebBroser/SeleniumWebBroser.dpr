program SeleniumWebBroser;

{$APPTYPE CONSOLE}

{$R *.res}

uses

  System.SysUtils,Windows,
  JsonDataObjects,Webdriver4D,webdriver_js_string,WD_httpDelphi,WD_http;

  const
      url = 'https://translate.google.fr/?hl=fr';
  var
      driver : TChromeDriver;
      source : TWebElement;
      result : TWebElement;
      strResult : string;
      x:string;
begin
   driver := TChromeDriver.Create(nil);
   try
      driver.StartDriver('D:\Program Files (x86)\WebDriver\chromedriver.exe');
      driver.NewSession();

      driver.Set_Window_Size(1920, 1080);
      driver.GetURL(url);
      {
        Writeln(driver.GetDocument);
        Writeln(driver.GetCurUrl);
      }

       driver.FindElementByID('source').SendKey('السلام عليكم');

      Sleep(1000);

      //result := driver.FindElementByClassName('tlid-translation translation');
      result :=driver.FindElementByXPath('//span[@class="tlid-translation translation"]');
      strResult := result.AttributeValue('innerText');
      OutputDebugString(Pchar(result.AttributeValue('innerText')));

      driver.Quit;
   Finally
      driver.Free;
   end;
end.
