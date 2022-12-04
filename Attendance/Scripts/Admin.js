$(document).ready(function () {
    if (sessionStorage.getItem("UserName") != "0" && sessionStorage.getItem("UserName") != null) {
        $("#Main").show();
        loadData();
    }
    if (sessionStorage.getItem("UserName") == "0" || sessionStorage.getItem("UserName") == null ) {
        location.href = "/Login/Index";
    }
});

$("#User").html(sessionStorage.getItem("UserName"));

$("#Logout").click(function () {
    $.ajax({
        url: "/Login/Logout"
    });
    sessionStorage.setItem("UserName", "0");
    location.href = "/Login/Index";
});

function loadData() {
    $.ajax({
        url: "/Admin/List",
        type: "Get",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            var html = '';
            $.each(result, function (key, item) {
                html += '<tr>';
                html += '<td>' + item.UserID + '</td>';
                html += '<td>' + item.Name + '</td>';
                html += '<td>' + item.Date.split(" ")[0] + '</td>';
                html += '<td>' + item.Checkin.split(" ")[1] + " " + item.Checkin.split(" ")[2] + '</td>';
                if (item.Checkout != "01/01/1900 12:00:00 am") {
                    html += '<td>' + item.Checkout.split(" ")[1] + " " + item.Checkout.split(" ")[2] + '</td>';
                }
                if (item.Checkout == "01/01/1900 12:00:00 am") {
                    html += '<td>' + '</td>';
                }
                html += '<td>' + item.ShortLeave + '</td>';
                html += '</tr>';
            });
            $('#tbody').html(html);
        }
    })
}

$("#Export").click(function () {
    DownloadExcel('xlsx');
});

function DownloadExcel(type) {
    var data = document.getElementById('AttendanceTable');
    var file = XLSX.utils.table_to_book(data, { sheet: "sheet1" });
    XLSX.write(file, { bookType: type, bookSST: true, type: 'base64' });
    XLSX.writeFile(file, 'Attendance.' + type);
}
