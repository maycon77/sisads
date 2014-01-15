<?php

class admin{
	public function post_save($admin) {
		if($admin->id == 0){
			//Insert
			$sql = "INSERT INTO admin (login, password, idUsuario) 
			VALUES (:login, :password, :idUsuario)";
		}else{
			//update
			/*
				Verifica se o login foi alterado e se foi, deve verificar
				se o login ja existe para outo usuario.
			*/
				$sqlUsuario = "SELECT id, login FROM admin WHERE id=:id";
				$stmtUsuario = DB::prepare($sqlUsuario);
				$stmtUsuario->bindParam("id",$admin->id);
				$stmtUsuario->execute();
				$usuario = $stmtUsuario->fetch();

				if ($usuario->login != $admin->login) {
					$sqlSelect = "SELECT u.id,u.nome FROM usuarios as u, admin as a WHERE a.login=:login AND u.id=a.idUsuario";
					$stmtSelect = DB::prepare($sqlSelect);
					$stmtSelect->bindParam("login", $admin->login);
					$stmtSelect->execute();
					$usuario = $stmtSelect->fetch();
					if($usuario)
						throw new Exception("Login pertence ao usuario '{$usuario->nome}'");
				}
				$sqlUpdateAdmin = "UPDATE admin SET login=:login, password=:password WHERE idUsuario = :idUsuario";
				$stmtAdmin = DB::prepare($sqlUpdateAdmin);
				$stmtAdmin->bindParam("login", $admin->login);
				$stmtAdmin->bindParam("password", $admin->password);
				$stmtAdmin->bindParam("idUsuario", $admin->idUsuario);
				$stmtAdmin->execute();
		}//end else
	}//end post_save()

	public function post_delete($admin){
		$sqlDeleteAdmin = "DELETE FROM admin WHERE id=:id";
		$sqlDeleteUsuario = "DELETE FROM usuarios WHERE id=:idUsuario";

		try{
			DB::beginTransaction();

			$stmt = DB::prepare($sqlDeleteAdmin);
			$stmt->bindParam("id", $admin->id);
			$stmt->execute();

			$stmt = DB::prepare($sqlDeleteUsuario);
			$stmt->bindParam("idUsuario", $admin->idUsuario);
			$stmt->execute();

			DB::commit();

		} catch (Exception $exc){

			DB::rollBack();
			throw new Exception($exc->getMessage());

		}
	}//end post_delete()

	function get_listAll(){
		$sqlGetAll = "SELECT * FROM admin";
		$stmtGetAll = DB::prepare($sqlGetAll);
		$stmtGetAll->execute();
		return ($stmtGetAll->fetchAll());
	}

	function get_list($id){
		$sql = "SELECT * FROM admin WHERE id=:id";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$result = $stmt->fetch();
		return $result;
	}

	public function post_login($admin){
		if((empty($admin->login)) or (empty($admin->password)))
			throw new Exception("Login{$admin->login} ou senha {$admin->pasword} precisam ser preenchidos");

		

		$sql = "SELECT * FROM admin WHERE (login=:login and password=:password)";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("login", $admin->login);
		$stmt->bindParam("password", $admin->password);
		$stmt->execute();

		$db_admin = $stmt->fetch();

		if($db_admin){
			unset($db_admin->password);
			$this->doLogin($db_admin);
			
			return $db_admin;
			
		}else{
			throw new Exception("Erro ao efetuar login. Login/Senha Incorretos");
		}
		
	}
	

	protected function doLogin($admin){
		/*Adiciona a data/ip do login*/
		$sql = "UPDATE admin SET lastLogin=now(), lastIp=:lastIp WHERE id=:id";
		$stmt = DB::prepare($sql);
		$stmt->bindParam("lastIp", $_SERVER["REMOTE_ADDR"]);
		$stmt->bindParam("id", $admin->id);
		$stmt->execute();
		session_start();
		$_SESSION["nome"] = $admin->login;
	}

	public function get_isLogged(){
		return isset($_SESSION["nome"]);
	}

	public function get_logout(){
		$_SESSION['nome'] = null;
		session_unset();
		session_destroy();
		return true;
	}
}