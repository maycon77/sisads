/**
 * Created by: http://gustavopaes.net
 * Created on: Nov/2009
 * 
 * Retorna os valores de parâmetros passados via url.
 *
 * @param String Nome da parâmetro.
 */
function _GETURL(name)
{
  var url   = window.location.search.replace("?", "");
  var itens = url.split("&");

  for(n in itens)
  {
    if( itens[n].match(name) )
    {
      return decodeURIComponent(itens[n].replace(name+"=", ""));
    }
  }
  return null;
}

var id = _GETURL('id');

$(document).ready(function() {
	verifyLogin();
  pegaCliente(id);
	atualizaGrid(id);
});

$('#btnChange').click(function () {

});

$('#btnPrevious').click(function () {

});

$('#btnNext').click(function () {

});

$(".alterar").live("click", function(){
  $("#novoModal").modal("show");
});

function pegaCliente(id){
  $.ajax({
    type: "post",
    url: rootUrl + "cliente/list",
    dataType: "json",
    data: JSON.stringify({id: id}),
    success: function(data) {
      var cliente = data.result;
          row = '<div class="row">'
              +'<div class="span7 bg-clean"><h5>Nome: </h5><span class="resultH5">'+cliente.nome+'</span></div>'
              +'<div class="span5  bg-clean"><h5>CPF/CNPJ</h5><span class="resultH5">'+cliente.cpf+'</span></div>'            +'</div>'
            +'<div class="row">'
              +'<div class="span4 bg-clean"><h5>Fone: </h5><span class="resultH5">'+cliente.telefone+'</span></div>'              
              +'<div class="span4 bg-clean"><h5>Cel: </h5><span class="resultH5">'+cliente.celular+'</span></div>'              
              +'<div class="span4 bg-clean"><h5>Email:</h5><span class="resultH5">'+cliente.email+'</span></div>'              
            +'</div>'
            +'<div class="row">'
              +'<div class="span9 bg-clean"><h5>Endereco: </h5><span class="resultH5">'+cliente.endereco+'</span></div>'              
              +'<div class="span3 bg-clean"><h5>Numero: </h5><span class="resultH5">'+cliente.numero+'</span></div>'              
            +'</div>'
            +'<div class="row">'
            +'<div class="span4 bg-clean"><h5>Bairro: </h5><span class="resultH5">'+cliente.bairro+'</span></div>'              
              +'<div class="span3 bg-clean"><h5>Cidade: </h5> <span class="resultH5">'+cliente.cidade+'</span></div>'              
              +'<div class="span2 bg-clean"><h5>UF: </h5><span class="resultH5">'+cliente.uf+'</span></div>'
              +'<div class="span3 bg-clean"><h5>CEP: </h5><span class="resultH5">'+cliente.cep+'</span></div>'
            +'</div>'
            +'<button>Alterar</button>';
          $(row).appendTo($("#dadosCliente")); 
    }
  });
}

function atualizaGrid(id) {

  /*Pegar todos os pedidos do cliente*/
  $.ajax({
    type: "get",
    url: rootUrl + "cliente/allOrders/" + id,
    dataType: "json",
    success: function(data) {
      console.log(data.result);
      data.result.forEach(function(pedido) {

                row = '<tr>'
                +'<td><a href="#" class="alterar" data-id="' + pedido.id + '">' + pedido.id + '</a></td>'
                +'<td>' + pedido.data + '</td>'
                +'<td>' + pedido.descricao + '</td>'
                +'<td>' + pedido.status + '</td>'
                +'<td>' +'</td>'
                +'<td>' + pedido.dataPrazo + '</td>'
                +'<td>' + pedido.dataEntrega + '</td>'
                +'<td><a href="#"><i class="icon-trash" data-id="'+ pedido.id +'" data-idUsuario="'+pedido.idUsuario+'"></i></a></td>'
            +'</tr>';
                $("#tablePedidos > tbody:last").append(row);
            });
    }
  });

}
