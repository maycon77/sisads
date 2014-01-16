
$(document).ready(function() {
    verifyLogin();
    atualizaGrid();
});
$('#btnNovo').click(function() {

    if ($("#inputId").val() != "") {
        $("form")[0].reset();
        $("#inputId").val("");
        $("#inputIdUsuario").val("");
        $("#errorServer").hide();
    }
    $('#novoModal').modal('show');
});

$('#btnBuscar').click(function() {
    atualizaGrid();
});

$('#salvar').click(function() {

    var valido = true;
    //remove o erro destacado em todos os inputs
    $("#form input").map(function() {
        $(this).parents("div").removeClass("error");
    });
    if ($('#inputNome').val().length == 0)
    {
        valido = false;
        $('#inputNome').parents("div").addClass("error");
    }

    if ($('#inputEndereco').val().length == 0)
    {
        valido = false;
        $('#inputEndereco').parents("div").addClass("error");
    }

    if ($('#inputNumero').val().length == 0)
    {
        valido = false;
        $('#inputNumero').parents("div").addClass("error");
    }

    if (valido)
    {
        travarFormulario();

        cliente = JSON.stringify({
            id: $("#inputId").val(),
            idUsuario: $("#inputIdUsuario").val(),
            nome: $("#inputNome").val(),
            endereco: $("#inputEndereco").val(),
            numero: $("#inputNumero").val(),
            bairro: $("#inputBairro").val(),
            cep: $("#inputCep").val(),
            cidade: $("#inputCidade").val(),
            uf: $("#inputUF").val(),
            email: $("#inputEmail").val(),
            obs: $("#inputObs").val(),
            telefone: $("#inputTelefone").val(),
            celular: $("#inputCelular").val(),
            tipo: $("#inputTipo").val(),
            cpf: $("#inputCpf").val(),
            cnpj: $("#inputCnpj").val(),
            ie: $("#inputIe").val()
        });
        console.log(cliente);

        $.ajax({
            type: "post",
            url: rootUrl + "clientes/save",
            dataType: "json",
            data: cliente,
            success: function(result) {
                destravarFormulario();
                $('#novoModal').modal('hide');
                $("form")[0].reset();
                atualizaGrid();
            },
            error: function(result) {
                destravarFormulario();
                $("#errorServer").html(getErrorMessage(result.responseText));
                $("#errorServer").show();
            }

        });
    }
    else
    {
        $("#errorEmpty").show();
        $("#erroServer").hide();
    }

});
function travarFormulario()
{
    $("#errorEmpty").hide();
    $("form").hide();
    $("#saveMessage").show();
    $("#salvar").addClass("disabled");
    $("#clearForm").addClass("disabled");
}

function destravarFormulario()
{
    $("#errorEmpty").hide();
    $("#errorServer").hide();
    $("form").show();
    $("#saveMessage").hide();
    $("#salvar").removeClass("disabled");
    $("#clearForm").removeClass("disabled");
}

function atualizaGrid()
{
    
    $("#tableClientes").find("tbody tr").remove();
    $("#tableClientes").find("tbody").append('<tr><td colspan=10><div class="alert alert-success"><img src="img/ajax-loader.gif">Carregando...</div></td></tr>');

    filtro = "";
    if ($("#filtrar").val())
        filtro = "/" + $("#filtrar").val();

    $.ajax({
        type: "get",
        url: rootUrl + "clientes/listAll" + filtro,
        dataType: "json",
        success: function(data) {
            $("#tableClientes").find("tbody tr").remove();
            data.result.forEach(function(cliente) {

                row = "<tr>"
                        + "<td><a href='index.php?go=cliente&id=" + cliente.idUsuario + "'>" + cliente.nome + "</a></td>"
                        + "</td><td>" + cliente.telefone
                        + "</td><td>" + cliente.celular
                        + "</td><td>" + cliente.email
                        + "</td><td> <a href='#'><i class='icon-edit' data-idUsuario='" + cliente.idUsuario + "' data-id='" + cliente.id + "' data-nome='" + cliente.nome + "'/></i></a>"
                        + "</td><td> <a href='#'><i class='icon-remove' data-idUsuario='" + cliente.idUsuario + "' data-id='" + cliente.id + "' data-nome='" + cliente.nome + "'/></i></a>"
                        + "</tr>";
                $("#tableClientes > tbody:last").append(row);
            });
        }
    });
}


$(".icon-remove").live("click", function() {
    id = $(this).attr("data-id");
    idUsuario = $(this).attr("data-idUsuario");
    nome = $(this).attr("data-nome");
    row = $(this);
    if (confirm("Excluir " + nome + "?"))
    {

        $.ajax({
            type: "post",
            url: rootUrl + "clientes/delete",
            dataType: "json",
            data: JSON.stringify({id: id, idUsuario: idUsuario}),
            success: function() {
                row.parent().parent().parent().fadeTo(400, 0, function() {
                    row.parent().parent().parent().remove();
                });
            },
            error: function() {
                //todo
            }
        });
    }

});

$(".icon-edit").live("click", function() {

    id = $(this).attr("data-id");
    idUsuario = $(this).attr("data-idUsuario");

    $("#errorServer").hide();
    $("#errorEmpty").hide();


    $.ajax({
        type: "get",
        url: rootUrl + "clientes/list/" + id,
        dataType: "json",
        success: function(data) {

            cliente = data.result;
            $("#inputId").val(cliente.id);
            $("#inputIdUsuario").val(cliente.idUsuario);
            $("#inputNome").val(cliente.nome);
            $("#inputEndereco").val(cliente.endereco);
            $("#inputNumero").val(cliente.numero);
            $("#inputBairro").val(cliente.bairro);
            $("#inputCep").val(cliente.cep);
            $("#inputCidade").val(cliente.cidade);
            $("#inputUF").val(cliente.uf);
            $("#inputEmail").val(cliente.email);
            $("#inputObs").val(cliente.obs);
            $("#inputTelefone").val(cliente.telefone);
            $("#inputCelular").val(cliente.celular);
            $("#inputTipo").val(cliente.tipo);
            $("#inputCpf").val(cliente.cpf);
            $("#inputCnpj").val(cliente.cnpj);
            $("#inputIe").val(cliente.ie);
            $("#novoModal").modal("show");
        }
    });


});    