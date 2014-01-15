$("#btnIr").click(function(event) {

    valido = true;

    $("#form-login input").map(function() {
        if ($(this).val().length == 0)
        {
            valido = false;
            $(this).parents("div").addClass("error");
        }
        else
        {
            $(this).parents("div").removeClass("error");
        }
    });

    if (valido)
    {
        $("#erroLoginEmpty").hide();
        $("#erroLoginServer").hide();
        $("#btnIr").addClass("disabled");
        $("#tryLogin").show();

        data = JSON.stringify({"login": $("#login").val(), "password": $("#senha").val()});

        $.ajax({
            type: "post",
            url: rootUrl + "admin/login",
            dataType: "json",
            data: data,
            success: onSuccessLogin,
            error: onErrorLogin
        });
    }
    else
    {
        $("#erroLoginServer").hide();
        $("#erroLoginEmpty").show();
    }
    
});

function onSuccessLogin(data) {
	console.log(data.responseText);

    $("#tryLogin").hide();
    $("#erroLoginServer").hide();
    $("#erroLoginEmpty").hide();

//    $.cookie.json = true;
//    $.cookie('usuario', data.login, {expires: 1});

    goPage("bemVindo");

}

function onErrorLogin(error) {
    $("#tryLogin").hide();
    $("#erroLoginServer").html(getErrorMessage(error.responseText));
    $("#erroLoginServer").show();
    $("#btnIr").removeClass("disabled");
}