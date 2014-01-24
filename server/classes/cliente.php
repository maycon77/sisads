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

	public function get_allOrders($idUsuario){
		$sql = "SELECT id FROM clientes WHERE idUsuario = :idUsuario";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("idUsuario", $idUsuario);
		$stmt->execute();
		$id = $stmt->fetch();

		$sql = "SELECT p.id, p.data, p.descricao, sp.nome as status, p.dataPrazo, p.dataEntrega  FROM pedidos as p, status_pedidos as sp WHERE p.idCliente = :id and sp.id = p.status";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("id", $id->id);
		$stmt->execute();

		$result = $stmt->fetchAll();
	
		foreach($result as $res){
			$res->data = DB::dateFromMysql($res->data);
			$res->dataPrazo = DB::dateFromMysql($res->dataPrazo);
			$res->dataEntrega = DB::dateFromMysql($res->dataEntrega);		
		}
		
		return $result;
	}

}