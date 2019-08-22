void function index_function(undefined) {

    function DrawUserGrid() {
        if ($fronted.Users) {
            // Draw users grid
            var table = $("<table id='grid_users' cellpadding='0' cellspacing='0' class='display'></table>");
            var thead = $("<thead><tr><th>ID</th><th>First Name</th><th>Last Name</th></tr></thead>");
            table.append(thead);
            var tbody = $("<tbody></tbody>");
            var tr;
            $.each($fronted.Users, function (i, u) {
                if (u != null) {
                    tr = $("<tr></tr>");
                    tr.append("<td>" + u.fields.Id + "</td><td>" + u.fields.FirstName + "</td><td>" + u.fields.LastName + "</td>");
                    tbody.append(tr);
                }
            });
            table.append(tbody);
            $("#div_users").empty();
            $("#div_users").append(table);
            $("#grid_users").DataTable();
        }
    }


    $(document).ready(function () {

    //{ "type":"User.TUser", "id":2, "fields":{ "Id":1, "LastName":"Abdelali", "FirstName":"Zekiri" } }
     $("#btn_AddUesr").on("click", function () {

            var _fields = {
                LastName: $("#tx_LastName").val(),
                FirstName: $("#tx_FirstName").val()
            }

            var newuser = { id: null, type: "User.TUser", fields: _fields };

            AddUesr(newuser, function () {
                GetUsers(function () {
                    DrawUserGrid();
                })
            });
        });

     // call api
     GetTitel(function () {
         $("#titel").html($fronted.titel);
     });

     GetUsers(function () {
         
         DrawUserGrid();
     });
 });





}.call();