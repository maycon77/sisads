<?php

class cliente{
	
	public function post_list($id){
		/*tive que mandar pelo post por causa do id que não deu pra fazer por url amigavel*/
		$sql = "SELECT * FROM usuarios, clientes WHERE clientes.idUsuario = usuarios.id AND usuarios.id = :id";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("id", $id->id);
		$stmt->execute();
		
		$result = $stmt->fetch();
		
		return $result;
		
	}

	public function get_allOrders($id){
		$sql = "SELECT * FROM pedidos WHERE idCliente = :id";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();

		return $stmt->fetchAll();
	}

}