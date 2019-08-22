$fronted = {};
$fronted.host = "http://delphiweb.net/api/Backend.dll/datasnap/rest/TServerMethods1/";
$fronted.SERVICE =
    {
    hello_Word_url: $fronted.host + "HelloWorld",
    user_list_url: $fronted.host + "GetUserListFromDb",
    add_user_url: $fronted.host + "%22AddNewUser%22",
    };

/*======================================================================
   Service Web Metod
 ======================================================================*/

function GetTitel(fnOnComplete) {
    $.ajax($fronted.SERVICE.hello_Word_url, { method: 'GET', xhrFields: { withCredentials: false } })
        .success(function (data) {
            $fronted.titel = JSON.parse(data).result[0];
            if (fnOnComplete) { fnOnComplete(); }
        })
        .fail(function (xhr, textStatus, errorThrown) {
        });
}

function GetUsers(fnOnComplete)
{
 $.ajax($fronted.SERVICE.user_list_url, { method: 'GET', xhrFields: { withCredentials: false } })
 .success(function (data) {
  var _data = JSON.parse(data);
   $fronted.Users = _data.result[0].fields.FItems;
   if (fnOnComplete) { fnOnComplete(); }
 })
 .fail( function(xhr, textStatus, errorThrown) {
 });
}

function AddUesr(newuser,fnOnComplete) {
    $.ajax($fronted.SERVICE.add_user_url, {
        method: 'POST',
        xhrFields: { withCredentials: false },
        headers: {
            Accept: "text/plain; charset=utf-8",
            "Content-Type": "text/plain; charset=utf-8"
        },     
        data: JSON.stringify(newuser)
    })
        .success(function (data) {
            console.log(data);
            if (fnOnComplete) { fnOnComplete(); }
        })
        .fail(function (xhr, textStatus, errorThrown) {

        });
}
