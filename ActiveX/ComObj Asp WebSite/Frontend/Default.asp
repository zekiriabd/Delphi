<HTML>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

  <head>
    <title></title>
    <link id="favicon" rel="shortcut icon" type="image/x-icon" href="img/users.ico" />
    <link type="text/css" rel="Stylesheet" href="css/index.css" />
  </head>

  <body>
      <div class="top-menu"><img src="img/Menu.png"/></div>
      <div class="main">
          <div class="left-menu"><img src="img/LeftBarr.png"></div>
          <div class="content">
              <div class="logo"><img src="img/logo.png"></div>
              <h1 id="titel"></h1>
              <h2>facebook User : </h2>
              <div id="div_users">
                <%
                    Set service = Server.CreateObject("WebApplicationCOM_ASP.Controller")
                    _user = service.GetUsers

                %>
              </div>
          </div>
      </div>

<BODY>
  </body>
</html>

