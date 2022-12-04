$(document).ready(function () {
    loadData();
});

$("#User").html(sessionStorage.getItem("UserName"));

function loadData() {
    $.ajax({
        url: "/Attendance/List",
        type: "Get",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (result.length >= 1) {
                if (result[0].Checkin.split(" ")[0] != result[0].Date.split(" ")[0]) {//For show/hide checkin and checkout button
                    $("#MarkCheckout").attr("disabled", true);
                    $("#MarkCheckout").hide();
                }
                if (result[0].Checkin.split(" ")[0] == result[0].Date.split(" ")[0]) {
                    $("#MarkCheckin").attr("disabled", true);
                    $("#MarkCheckin").hide();
                }
                if (result[0].Checkout.split(" ")[0] == result[0].Date.split(" ")[0]) {
                    $("#MarkCheckout").attr("disabled", true);
                    $("#MarkCheckout").hide();
                    $("#AlreadyMarked").show();
                }
                if (result[0].Checkin.split(" ")[0] == result[0].Date.split(" ")[0]) {
                    $("#ShortLeaveDiv").show();
                    $("#ShortLeave").val(result[0].ShortLeave);
                }
                if (result[0].Checkout.split(" ")[0] == result[0].Date.split(" ")[0]) {
                    $("#ShortLeave").prop('disabled', true);
                    $("#BtnShortLeave").prop('disabled', true);
                }
            }
            else {
                $("#MarkCheckout").hide();
            }
            var html = '';
            $.each(result, function (key, item) {
                html += '<tr>';
                html += '<td>' + item.Checkin.split(" ")[0] + '</td>';
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

function MarkShortLeave() {
    var ShortLeave = {
        ShortLeave: $("#ShortLeave").val(),
    };
    $.ajax({
        url: "/Attendance/MarkShortLeave",
        data: JSON.stringify(ShortLeave),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            
        },
        error: function (errormessage) {
            alert(errormessage.responseText)
        }
    });
}

$("#BtnShortLeave").click(function () {
    MarkShortLeave();
    loadData();
    $("#ShowAtt").click();
});

$("#Logout").click(function () {
    $.ajax({
        url: "/Login/Logout"
    });
    location.href = "/Login/Index";
});

$("#MarkAttendance").click(function () {
    $("#AttDiv").hide();
    $("#MarkAttDiv").show();
    $("#ShowAtt").show();
    $("#MarkAttendance").hide();
});

$("#ShowAtt").click(function () {
    $("#AttDiv").show();
    $("#MarkAttDiv").hide();
    $("#ShowAtt").hide();
    $("#MarkAttendance").show();
});

function MarkAttendance() {
    $.ajax({
        url: "/Attendance/MarkAttendance",
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            loadData();
            $("#AttDiv").show();
            $("#MarkAttDiv").hide();
        },
        error: function (errormessage) {
            alert(errormessage.responseText)
        }
    });
}

$("#MarkCheckin").click(function () {
    MarkAttendance();
    $("#ShowAtt").hide();
    $("#MarkAttendance").show();
    $("#MarkCheckout").attr("disabled", false);
    $("#MarkCheckout").show();
});

$("#MarkCheckout").click(function () {
    MarkAttendance();
    $("#ShowAtt").hide();
    $("#MarkAttendance").show();
});