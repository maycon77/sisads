<?php

include_once "usuarios.php";

class clientes extends usuarios {

	public function get_texto(){
		echo "Voce esta no no Class Clientes";
	}

	public function post_save($cliente){
		if($cliente->id == null || $cliente->id == ''){
			//Insert
			//Aqui faço o cadastro na tabela usuario para depois cadastrar o cliente que utiliza o ultimo id do cadastro de usuario;
			usuarios::post_save($cliente);

			$sqlCliente = "INSERT INTO clientes (idUsuario, cpf, cnpj, ie) 
			VALUES (:idUsuario, :cpf, :cnpj, :ie)";
		}else{
			//update
			//faço o update do usuario para depois fazer o update na tabela cliente
			usuarios::post_save($cliente);
			$sqlCliente = "UPDATE clientes SET cpf=:cpf, cnpj=:cnpj, ie=:ie WHERE idUsuario = :idUsuario";
		}

		$stmtCliente = DB::prepare($sqlCliente);
		
		if($cliente->id == null || $cliente->id == ""){
			/*Se for Insert entao pego o lastInsertId para fazer o cadastro de cliente,
			 DB::lastInsertId() -> recupera o valor do ultimo id cadastrado que foi realizado no usuarios::post_save();
			*/
			 $lastInsertUsuario = DB::lastInsertId();
			$stmtCliente->bindParam("idUsuario", $lastInsertUsuario);
		}else{
			/*Se for update utilizo o $idUsuario passado como parametro*/
			$stmtCliente->bindParam("idUsuario", $cliente->idUsuario);
		}

		$stmtCliente->bindParam("cpf", $cliente->cpf);
		$stmtCliente->bindParam("cnpj", $cliente->cnpj);
		$stmtCliente->bindParam("ie", $cliente->ie);

		$stmtCliente->execute();

	}

	public function post_delete($cliente){
		$sqlDeleteCliente = "DELETE FROM clientes WHERE idUsuario=:idUsuario";
		$sqlDeleteUsuario = "DELETE FROM usuarios WHERE id=:idUsuario";
		try{
			
			DB::beginTransaction();
			$stmtCliente = DB::prepare($sqlDeleteCliente);
			$stmtCliente->bindParam("idUsuario", $cliente->idUsuario);
			$stmtCliente->execute();

			$stmtUsuario = DB::prepare($sqlDeleteUsuario);
			$stmtUsuario->bindParam("idUsuario", $cliente->idUsuario);
			$stmtUsuario->execute();

			DB::commit();

		} catch (Exception $exc) {
			DB::rollBack();
			throw new Exception ($exc->getMessage());
		}
	}

	public function get_listAll($parameter){
		$filtroWHERE = "ORDER BY usuarios.nome";
        $nomeLike = "%$parameter%";

        if ($parameter)
            $filtroWHERE = " AND usuarios.nome LIKE :nome";

        $sql = "SELECT * FROM usuarios, clientes WHERE usuarios.id = clientes.idUsuario $filtroWHERE";

        $stmt = DB::prepare($sql);

        if ($parameter)
            $stmt->bindParam("nome", $nomeLike);

        $stmt->execute();

        $result = $stmt->fetchAll();
        return $result;
	}

	public function get_list($id){
		$sql = "SELECT * FROM clientes c, usuarios u WHERE c.idUsuario = u.id AND c.id = :id";
        $stmt = DB::prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        return ($stmt->fetch());
	}
}