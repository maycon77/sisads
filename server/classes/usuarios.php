<?php

class usuarios{

	public function post_save($data){
		$sql = "";
		if($data->id == 0){
			//Insert
			$sql = "INSERT INTO usuarios (nome, endereco, numero, bairro, cep, cidade, uf, email,
					obs, tipo, telefone, celular, data_cad) VALUES (:nome, :endereco, :numero, :bairro, :cep, :cidade, :uf, :email,
					:obs, :tipo, :telefone, :celular, now())";
		}else{
			//Update
			$sql = "UPDATE usuarios SET nome=:nome, endereco=:endereco, numero=:numero, bairro=:bairro, cep=:cep, cidade=:cidade, uf=:uf, email=:email,
					obs=:obs, tipo=:tipo, telefone=:telefone, celular=:celular WHERE id=:id";
		}
		$stmt = DB::prepare($sql);
		$stmt->bindParam("nome", $data->nome);
		$stmt->bindParam("endereco", $data->endereco);
		$stmt->bindParam("numero", $data->numero);
		$stmt->bindParam("bairro", $data->bairro);
		$stmt->bindParam("cep", $data->cep);
		$stmt->bindParam("cidade", $data->cidade);
		$stmt->bindParam("uf", $data->uf);
		$stmt->bindParam("email", $data->email);
		$stmt->bindParam("obs", $data->obs);
		$stmt->bindParam("tipo", $data->tipo);
		$stmt->bindParam("telefone", $data->telefone);
		$stmt->bindParam("celular", $data->celular);
		if($data->id == 0){
			//insert data 
			//$stmt->bindParam("data_cad", ;
		}else{
			//update
			$stmt->bindParam("id", $data->id);
		}
		$stmt->execute();
		if($data->id != 0){
			$data->id = DB::lastInsertId();
			return $data;
		}//endif
	}//end post_save()




}