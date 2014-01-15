/*variaveis globais*/
var rootUrl = "http://localhost/sisads/server/",
	clienteUrl = "http://localhost/sisads/cliente/";

function getErrorMessage(jsonError) {
    return (JSON.parse(jsonError)).error.text;
}

function goPage(page){
	location.href = clienteUrl + "index.php?go=" + page;
}

function preparaData(data) {
	data.datapicker();
	data.datapicker("option", "dateFormat", "dd/mm/yy");
	data.keypress(function(event){
		event.preventDefault();
	});
}

function verifyLogin() {
    $.ajax({
    	type: "get",
    	url: rootUrl + "admin/isLogged",
    	dataType: "json",
    	success: function(data){
    		console.log(data)
    	},
    	error: function(data){
    		console.log(data.responseText)
    	}
    });
}

$(document).ready(function(){
	$("#linkSair").click(function(){
		$.ajax({
			type: "get",
			url: rootUrl + "admin/logout",
			success: function(){
				
				goPage("login");
			}
		});
	});


	$(".moeda").maskMoney({thousands: '.', decimal: ','});

	$(window).keydown(function(event){
		if(event.keyCode == 13){
			event.preventDefault();
			return false;
		}
	});
});