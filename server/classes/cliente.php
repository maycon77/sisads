<?php

class cliente{
	
	public function get_customer($id){
		$sql = "SELECT * FROM usuarios, clientes ";
		$sql += "WHERE clientes.idUsuario = :id AND usuarios.id = :id";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();

		return $stmt->fetch();

	}

	public function get_allOrders($id){
		$sql = "SELECT * FROM pedidos WHERE idCliente = :id";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();

		return $stmt->fetchAll();
	}

}