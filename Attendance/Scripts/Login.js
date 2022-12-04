
$("#Signup1").click(function () {
    $("#LoginDiv").hide();
    $("#SignupDiv").show();
    ClearTextBox();
});

$("#Login2").click(function () {
    $("#LoginDiv").show();
    $("#SignupDiv").hide();
    ClearTextBox();
});

$("#Signup2").click(function () {
    var check;
    check = ValidateSignup();
    if (check == 1) {
        Signup();
    }
});

$("#Login1").click(function () {
    var check;
    check = ValidateLogin();
    if (check == 1) {
        Login();
    }
});

function ClearTextBox() {
    $("#SignupName").val("");
    $("#SignupEmail").val("");
    $("#SignupPassword").val("");
    $("#LoginEmail").val("");
    $("#LoginPassword").val("");
}

function ValidateSignup() {
    if ($("#SignupName").val() == "" || $("#SignupEmail").val() == "" || $("#SignupPassword").val() == "") {
        alert("Fill all the Values")
        return 0;
    }
    else
        return 1;
}

function ValidateLogin() {
    if ($("#LoginEmail").val() == "" || $("#LoginPassword").val() == "") {
        alert("Fill all the Values")
        return 0;
    }
    else
        return 1;
}

function Signup() {
    var SignupUser = {
        Name: $("#SignupName").val(),
        Email: $("#SignupEmail").val(),
        Password: $("#SignupPassword").val(),
    };
    $.ajax({
        url: "/Login/Add",
        data: JSON.stringify(SignupUser),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (result.Message == 'User Already Exists') {
                alert("User Already Exists, Please Enter another Email Address");
            }
            if (result.Message == 'Account Created Successfully') {
                $("#LoginDiv").show();
                $("#SignupDiv").hide();
                ClearTextBox();
                alert("Account Created Successfully");
            }
        },
        error: function (errormessage) {
            alert(errormessage.responseText)
        }
    });
}

function Login() {
    var LoginUser = {
        Email: $("#LoginEmail").val(),
        Password: $("#LoginPassword").val(),
    };
    $.ajax({
        url: "/Login/Login",
        data: JSON.stringify(LoginUser),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (result.Message == 'User Not Exists') {
                ClearTextBox();
                alert("Incorrect User Name or Password");
            }
            if (result.Message == 'User Exists') {
                sessionStorage.setItem("UserName", result.Email);
                ClearTextBox();
                alert("Login Successfull");
                if (result.UserType == 1) {
                    location.href = "/Attendance/Index";
                }
                if (result.UserType == 2) {
                    location.href = "/Admin/Index";
                }
            }
        },
        error: function (errormessage) {
            alert(errormessage.responseText)
        }
    });
}